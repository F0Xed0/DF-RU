function pairsByKeys (t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0
    local iter = function ()
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
    end
    return iter
end

function pick_random(t)
    if t and #t>0 then
        return t[trandom(#t)+1]
    else
        return nil
    end
end

function pick_random_no_replace(t)
    if t and #t>0 then
        return table.remove(t,trandom(#t)+1)
    else
        return nil
    end
end

function pick_random_conditional(t,cond,...)
    local is_fun=type(cond)=="function"
    local candidates={}
    -- we use pairsByKeys so the RNG seed is stable
    for k,v in pairsByKeys(t) do
        if is_fun then 
            if cond(k,v,...) then
                candidates[#candidates+1]=v
            end
        elseif v[cond](...) then
            candidates[#candidates+1]=v
        end
    end
    return pick_random(candidates)
end

function pick_random_conditional_pairs(t,cond,...)
    local is_fun=type(cond)=="function"
    local candidates={}
    -- we use pairsByKeys so the RNG seed is stable
    for k,v in pairsByKeys(t) do
        if is_fun then 
            if cond(k,v,...) then
                candidates[#candidates+1]=k
            end
        elseif v[cond](...) then
            candidates[#candidates+1]=k
        end
    end
    return pick_random(candidates)
end

function one_in(x)
    return type(x)=="number" and x>0 and trandom(math.floor(x))==0
end

function split_to_lines(tbl,str)
    for s in string.gmatch(str,"[^\r\n]+") do
        tbl[#tbl+1]=s
    end
    return tbl
end

function map_merge(tbl1,tbl2)
    if not (type(tbl1)=='table' and type(tbl2)=='table') then return tbl1 end
    for k,v in pairs(tbl2) do
        tbl1[k]=tbl1[k] or v
    end
    return tbl1
end

function table_merge(tbl1,tbl2)
    if not (type(tbl1)=='table' and type(tbl2)=='table') then return tbl1 end
    for k,v in ipairs(tbl2) do
        tbl1[#tbl1+1]=v
    end
    return tbl1
end

function find_in_array_part(tbl,item)
    for k,v in ipairs(tbl) do
        if v==item then return true end
    end
    return false
end

function convert_array_to_set(tbl)
    for k,v in ipairs(tbl) do
        tbl[v]=true
    end
end

function add_unique(tbl,item)
    if not find_in_array_part(tbl,item) then
        tbl[#tbl+1]=item
        return true
    end
    return false
end

function remove_item(tbl,item)
    for i=#tbl,1,-1 do
        if tbl[i]==item then table.remove(tbl,i) end
    end
end

function pick_random_pairs(tbl)
    if not tbl then return nil end
    local cand={}
    -- we use pairsByKeys so the RNG seed is stable
    for k,v in pairsByKeys(tbl) do
        if v then cand[#cand+1]=k end
    end
    return pick_random(cand)
end

function pick_random_pairs_with_sort(tbl,f)
    if not tbl then return nil end
    local cand={}
    -- we use pairsByKeys so the RNG seed is stable
    for k,v in pairsByKeys(tbl,f) do
        if v then cand[#cand+1]=k end
    end
    return pick_random(cand)
end

function log(...)
    local s=""
    local args=table.pack(...)
    for i=1,args.n do
        s=s..tostring(args[i]).." "
    end
    lua_log(s)
end

--------------------------
debug_level=0

function get_caller_loc_string()
    local info = debug.getinfo(3)
    return info.source..":"..info.currentline
end


function get_debug_logger(level)
    level=level or 1
    if debug_level>=level then
        local count=0
        return function(...)
            log(count,get_caller_loc_string(),...)
            count=count+1
        end
    else
        return function() end
    end
end

function partial_function(f,arg)
    return function(...) return f(arg,...) end
end

function pick_weighted_from_table(tbl)
    -- we assume this table is sorted for RNG stability before the call since pairsByKeys doesn't sort arrays
    local l=get_debug_logger(4)
    local o=get_debug_logger(-10)
    l("Picking weighted table at ",get_caller_loc_string)
    local total_weight=0
    for k,v in pairs(tbl) do
        l(k,v,v.weight)
        if not v.weight then
            o("A table that should have a weight does not. Spewing contents of table below.")
            print_table(v)
        end
        total_weight=total_weight+(v.weight or 1)
    end
    local roll=trandom(total_weight)
    l("Roll:",roll)
    for i=1,10 do
        for k,v in pairs(tbl) do
            l(k,v.weight,roll)
            roll=roll-v.weight
            if roll<=0 then return v end
        end
    end
    return nil
end

function log_table(tbl,debug_level,nest_level,added_debug_from_nest)
    if type(tbl) ~= "table" then return end
    if not nest_level then nest_level=0 end
    if not added_debug_from_nest then added_debug_from_nest=0 end
    local f = get_debug_logger(debug_level+nest_level*added_debug_from_nest)
    local already_printed={}
    local open_str = '|'
    open_str = open_str..string.rep('-',nest_level)
    open_str = open_str..'>'
    for k,v in pairs(tbl) do
        f(open_str,k,v)
        already_printed[k]=true
        log_table(v,debug_level,nest_level+1,added_debug_from_nest)
    end
    for k,v in ipairs(tbl) do
        if not already_printed[k] then
            f(open_str,k,v)
            log_table(v,debug_level,nest_level+1,added_debug_from_nest)
        end
    end
end

function print_table(tbl,nest_level)
    if type(tbl) ~= "table" then return end
    if not nest_level then nest_level=0 end
    local already_printed={}
    local open_str = '|'
    open_str = open_str..string.rep('-',nest_level)
    open_str = open_str..'>'
    for k,v in pairs(tbl) do
        log(open_str,k,v)
        already_printed[k]=true
        print_table(v,nest_level+1)
    end
    for k,v in ipairs(tbl) do
        if not already_printed[k] then
            log(open_str,k,v)
            print_table(v,nest_level+1)
        end
    end
end

function shallow_copy(tbl)
    if type(tbl) ~= "table" then return tbl end
    local ret={}
    for k,v in pairs(tbl) do
        ret[k]=v
    end
    return ret
end

function deep_copy(tbl)
    if type(tbl) ~= "table" then return tbl end
    local ret={}
    for k,v in pairs(tbl) do
        ret[k]=deep_copy(v)
    end
    return ret
end

function generate_from_list(tbl,...)
    local results={}
    local total_weight=0
    local o=get_debug_logger(-10)
    -- we use pairsByKeys so the RNG seed is stable
    for k,v in pairsByKeys(tbl) do
        local result = v(...)
        if result then
            if not result.weight then
                o("A table that should have a weight does not. Spewing contents of table below.")
                print_table(result)
            end
            total_weight = total_weight + (result.weight or 1)
            results[#results+1]=result
        end
    end
    local roll = trandom(math.ceil(total_weight))+1
    for i=1,10 do -- We're probably not going to do it even twice, but it's fine
        for k,v in ipairs(results) do
            roll = roll - v.weight
            if roll<=0 then 
                return v
            end
        end
    end
    return results[1] or nil
end

evil_spheres = {
    "BLIGHT",
    "CHAOS",
    "DEATH",
    "DEFORMITY",
    "DEPRAVITY",
    "DISEASE",
    "JEALOUSY",
    "LIES",
    "MISERY",
    "MURDER",
    "NIGHTMARES",
    "SUICIDE",
    "THEFT",
    "THRALLDOM",
    "TORTURE",
    "TREACHERY",
}

good_spheres = {
"CHARITY",
"CONSOLATION",
"FORGIVENESS",
"FREEDOM",
"GENEROSITY",
"HAPPINESS",
"HEALING",
"HOSPITALITY",
"LOVE",
"MERCY",
"PEACE",
"REVELRY",
"SACRIFICE",
"TRUTH",
"WISDOM",
}

-- mods can add more
random_sphere_adjective={
    AGRICULTURE={"земледельческий"},
    ANIMALS={"звериный"},
    ART={"худЇжественный"},
    BALANCE={"уравнЇвешенный"},
    BEAUTY={"їрекрасный"},
    BIRTH={"рЇждающий"},
    BLIGHT={"чумнЇй"},
    BOUNDARIES={"їЇграничный"},
    CAVERNS={"їещерный"},
    CHAOS={"хаЇтический"},
    CHARITY={"милЇсердный"},
    CHILDREN={"детский"},
    COASTS={"їрибрежный"},
    CONSOLATION={"утешающий"},
    COURAGE={"Їтважный"},
    CRAFTS={"рукЇтвЇрный"},
    CREATION={"сЇтвЇрєнный"},
    DANCE={"танцующий"},
    DARKNESS={"тємный"},
    DAWN={"рассветный"},
    DAY={"їЇлуденный"},
    DEATH={"мєртвый"},
    DEFORMITY={"урЇдливый"},
    DEPRAVITY={"їЇрЇчный"},
    DISCIPLINE={"дисциїлинирЇванный"},
    DISEASE={"хвЇрый"},
    DREAMS={"грезящий"},
    DUSK={"сумеречный"},
    DUTY={"исїЇлнительный"},
    EARTH={"землянЇй"},
    FAMILY={"семейный"},
    FAME={"їрЇславленный"},
    FATE={"їредначертанный"},
    FERTILITY={"їлЇдЇрЇдный"},
    FESTIVALS={"їраздничный"},
    FIRE={"Їгненный"},
    FISH={"рыбный"},
    FISHING={"рыбный"},
    FOOD={"їечєный"},
    FORGIVENESS={"всеїрЇщающий"},
    FORTRESSES={"защищєнный"},
    FREEDOM={"свЇбЇдный"},
    GAMBLING={"азартный"},
    GAMES={"игривый"},
    GENEROSITY={"щедрый"},
    HAPPINESS={"счастливый"},
    HEALING={"целительный"},
    HOSPITALITY={"гЇстеїриимный"},
    HUNTING={"ЇхЇтящийся"},
    INSPIRATION={"вдЇхнЇвенный"},
    JEALOUSY={"ревнивый"},
    JEWELS={"самЇцветный"},
    JUSTICE={"сїраведливый"},
    LABOR={"трудящийся"},
    LAKES={"влажный"},
    LAWS={"стрЇгий"},
    LIES={"лживый"},
    LIGHT={"сияющий"},
    LIGHTNING={"грЇзЇвЇй"},
    LONGEVITY={"дЇлгЇживущий"},
    LOVE={"любящий"},
    LOYALTY={"верный"},
    LUCK={"удачливый"},
    LUST={"їЇхЇтливый"},
    MARRIAGE={"венчанный"},
    MERCY={"милЇстивый"},
    METALS={"металлический"},
    MINERALS={"кристальный"},
    MISERY={"несчастный"},
    MIST={"туманный"},
    MOON={"лунный"},
    MOUNTAINS={"гЇрный"},
    MUCK={"грязный"},
    MURDER={"убийственный"},
    MUSIC={"лиричный"},
    NATURE={"їрирЇдный"},
    NIGHT={"тємный"},
    NIGHTMARES={"кЇшмарный"},
    OATHS={"їрисягнувший"},
    OCEANS={"Їкеанский"},
    ORDER={"уїЇрядЇченный"},
    PAINTING={"расїиснЇй"},
    PEACE={"мирный"},
    PERSUASION={"убедительный"},
    PLANTS={"лиственный"},
    POETRY={"їЇэтичный"},
    PREGNANCY={"їлЇдЇнЇсный"},
    RAIN={"дЇждливый"},
    RAINBOWS={"красЇчный"},
    REBIRTH={"вЇзрЇждєнный"},
    REVELRY={"радЇстный"},
    REVENGE={"мстительный"},
    RIVERS={"текучий"},
    RULERSHIP={"властный"},
    RUMORS={"шеїчущий"},
    SACRIFICE={"жертвенный"},
    SALT={"сЇлєный"},
    SCHOLARSHIP={"учєный"},
    SEASONS={"сезЇнный"},
    SILENCE={"безмЇлвный"},
    SKY={"Їблачный"},
    SONG={"їЇющий"},
    SPEECH={"краснЇречивый"},
    STARS={"звєздный"},
    STORMS={"бурный"},
    STRENGTH={"сильный"},
    SUICIDE={"безнадєжный"},
    SUN={"сЇлнечный"},
    THEFT={"вЇрЇватый"},
    THRALLDOM={"їЇрабЇщєнный"},
    THUNDER={"грЇмЇвЇй"},
    TORTURE={"злЇбный"},
    TRADE={"їредїриимчивый"},
    TRAVELERS={"странствующий"},
    TREACHERY={"верЇлЇмный"},
    TREES={"деревянный"},
    TRICKERY={"хитрый"},
    TRUTH={"истинный"},
    TWILIGHT={"сумеречный"},
    VALOR={"дЇблестный"},
    VICTORY={"їЇбедЇнЇсный"},
    VOLCANOS={"вулканический"},
    WAR={"вЇинственный"},
    WATER={"вЇдный"},
    WEALTH={"бЇгатый"},
    WEATHER={"ненастный"},
    WIND={"ветреный"},
    WISDOM={"мудрый"},
    WRITING={"книжный"},
    YOUTH={"юный"},
}

function get_random_sphere_adjective(sph)
    return sph and pick_random(random_sphere_adjective[sph]) or "без сферы"
end

-- structure's a bit of a mess, but one can e.g. do
-- random_sphere_nouns.AGRICULTURE[#random_sphere_nouns.AGRICULTURE+1]={str="agriculture"}
-- which is hopefully good
random_sphere_nouns={
    AGRICULTURE={{str="земледелие",gen="земледелия"}},
    ANIMALS={{str="живЇтные",gen="живЇтных",flags={OF=true}}},
    ART={{str="искусствЇ",gen="искусства"}},
    BALANCE={{str="равнЇвесие",gen="равнЇвесия"}},
    BEAUTY={{str="красЇта",gen="красЇты"}},
    BIRTH={{str="рЇждение",gen="рЇждения"}},
    BLIGHT={{str="їЇрча",gen="їЇрчи"}},
    BOUNDARIES={{str="границы",gen="границ",flags={OF=true}}},
    CAVERNS={{str="їещеры",gen="їещер",flags={OF=true}}},
    CHAOS={{str="хаЇс",gen="хаЇса"}},
    CHARITY={{str="милЇсердие",gen="милЇсердия"}},
    CHILDREN={{str="дети",gen="детей",flags={OF=true}}},
    COASTS={{str="їЇбережья",gen="їЇбережий",flags={OF=true}}},
    CONSOLATION={{str="утешение",gen="утешения",flags={OF=true}}},
    COURAGE={{str="Їтвага",gen="Їтваги"}},
    CRAFTS={{str="ремєсла",gen="ремєсел",flags={OF=true}}},
    CREATION={{str="твЇрение",gen="твЇрения"}},
    DANCE={{str="танец",gen="танца"}},
    DARKNESS={{str="тьма",gen="тьмы"}},
    DAWN={{str="рассвет",gen="рассвета"}},
    DAY={{str="день",gen="дня"}},
    DEATH={{str="смерть",gen="смерти"}},
    DEFORMITY={{str="урЇдствЇ",gen="урЇдства",flags={OF=true}}},
    DEPRAVITY={{str="їЇрЇк",gen="їЇрЇка",flags={OF=true}}},
    DISCIPLINE={{str="дисциїлина",gen="дисциїлины",flags={OF=true}}},
    DISEASE={{str="бЇлезни",gen="бЇлезней"}},
    DREAMS={{str="сны",gen="снЇв",flags={OF=true}}},
    DUSK={{str="сумерки",gen="сумерек"}},
    DUTY={{str="дЇлг",gen="дЇлга"}},
    EARTH={{str="земля",gen="земли"}},
    FAMILY={{str="семья",gen="семьи"}},
    FAME={{str="слава",gen="славы"}},
    FATE={{str="судьба",gen="судьбы"}},
    FERTILITY={{str="їлЇдЇрЇдие",gen="їлЇдЇрЇдия",flags={OF=true}}},
    FESTIVALS={{str="їразднества",gen="їразднеств",flags={OF=true}}},
    FIRE={{str="ЇгЇнь",gen="Їгня"}},
    FISH={{str="рыба",gen="рыбы",flags={OF=true}}},
    FISHING={{str="рыбалка",gen="рыбалки"}},
    FOOD={{str="еда",gen="еды"}},
    FORGIVENESS={{str="їрЇщение",gen="їрЇщения",flags={OF=true}}},
    FORTRESSES={{str="креїЇсти",gen="креїЇстей",flags={OF=true}}},
    FREEDOM={{str="свЇбЇда",gen="свЇбЇды"}},
    GAMBLING={{str="азартные игры",gen="азартных игр"}},
    GAMES={{str="игры",gen="игр",flags={OF=true}}},
    GENEROSITY={{str="щедрЇсть",gen="щедрЇсти",flags={OF=true}}},
    HAPPINESS={{str="счастье",gen="счастья",flags={PRE=true,OF=true}}},
    HEALING={{str="исцеление",gen="исцеления"}},
    HOSPITALITY={{str="гЇстеїриимствЇ",gen="гЇстеїриимства",flags={OF=true}}},
    HUNTING={{str="ЇхЇта",gen="ЇхЇты"}},
    INSPIRATION={{str="вдЇхнЇвение",gen="вдЇхнЇвения",flags={OF=true}}},
    JEALOUSY={{str="ревнЇсть",gen="ревнЇсти",flags={OF=true}}},
    JEWELS={{str="драгЇценнЇсти",gen="драгЇценнЇстей",flags={OF=true}}},
    JUSTICE={{str="сїраведливЇсть",gen="сїраведливЇсти"}},
    LABOR={{str="труд",gen="труда"}},
    LAKES={{str="Їзєра",gen="Їзєр",flags={OF=true}}},
    LAWS={{str="закЇны",gen="закЇнЇв",flags={OF=true}}},
    LIES={{str="лЇжь",gen="лжи",flags={OF=true}}},
    LIGHT={{str="свет",gen="света"}},
    LIGHTNING={{str="мЇлния",gen="мЇлнии"}},
    LONGEVITY={{str="дЇлгЇлетие",gen="дЇлгЇлетия",flags={OF=true}}},
    LOVE={{str="любЇвь",gen="любви"}},
    LOYALTY={{str="вернЇсть",gen="вернЇсти",flags={OF=true}}},
    LUCK={{str="удача",gen="удачи"}},
    LUST={{str="їЇхЇть",gen="їЇхЇти"}},
    MARRIAGE={{str="брак",gen="брака"}},
    MERCY={{str="милЇсть",gen="милЇсти"}},
    METALS={{str="металлы",gen="металлЇв",flags={OF=true}}},
    MINERALS={{str="минералы",gen="минералЇв",flags={OF=true}}},
    MISERY={{str="страдание",gen="страдания"}},
    MIST={{str="туман",gen="тумана"}},
    MOON={{str="луна",gen="луны"}},
    MOUNTAINS={{str="гЇры",gen="гЇр",flags={OF=true}}},
    MUCK={{str="грязь",gen="грязи"}},
    MURDER={{str="убийствЇ",gen="убийства"}},
    MUSIC={{str="музыка",gen="музыки"}},
    NATURE={{str="їрирЇда",gen="їрирЇды"}},
    NIGHT={{str="нЇчь",gen="нЇчи"}},
    NIGHTMARES={{str="кЇшмары",gen="кЇшмарЇв",flags={OF=true}}},
    OATHS={{str="клятвы",gen="клятв",flags={OF=true}}},
    OCEANS={{str="Їкеаны",gen="ЇкеанЇв",flags={OF=true}}},
    ORDER={{str="їЇрядЇк",gen="їЇрядка"}},
    PAINTING={{str="живЇїись",gen="живЇїиси"}},
    PEACE={{str="мир",gen="мира"}},
    PERSUASION={{str="убеждение",gen="убеждения",flags={OF=true}}},
    PLANTS={{str="растения",gen="растений",flags={OF=true}}},
    POETRY={{str="їЇэзия",gen="їЇэзии"}},
    PREGNANCY={{str="беременнЇсть",gen="беременнЇсти"}},
    RAIN={{str="дЇждь",gen="дЇждя"}},
    RAINBOWS={{str="радуги",gen="радуг",flags={OF=true}}},
    REBIRTH={{str="вЇзрЇждение",gen="вЇзрЇждения"}},
    REVELRY={{str="веселье",gen="веселья"}},
    REVENGE={{str="месть",gen="мести"}},
    RIVERS={{str="реки",gen="рек",flags={OF=true}}},
    RULERSHIP={{str="власть",gen="власти"}},
    RUMORS={{str="слухи",gen="слухЇв",flags={OF=true}}},
    SACRIFICE={{str="жертвЇїринЇшение",gen="жертвЇїринЇшения"}},
    SALT={{str="сЇль",gen="сЇли"}},
    SCHOLARSHIP={{str="учєнЇсть",gen="учєнЇсти",flags={OF=true}}},
    SEASONS={{str="времена гЇда",gen="времєн гЇда",flags={OF=true}}},
    SILENCE={{str="тишина",gen="тишины"}},
    SKY={{str="небЇ",gen="неба"}},
    SONG={{str="їесня",gen="їесни"}},
    SPEECH={{str="речь",gen="речи"}},
    STARS={{str="звєзды",gen="звєзд",flags={OF=true}}},
    STORMS={{str="бури",gen="бурь",flags={OF=true}}},
    STRENGTH={{str="сила",gen="силы"}},
    SUICIDE={{str="самЇубийствЇ",gen="самЇубийства"}},
    SUN={{str="сЇлнце",gen="сЇлнца"}},
    THEFT={{str="вЇрЇвствЇ",gen="вЇрЇвства"}},
    THRALLDOM={{str="рабствЇ",gen="рабства",flags={OF=true}}},
    THUNDER={{str="грЇм",gen="грЇма"}},
    TORTURE={{str="їытки",gen="їытЇк"}},
    TRADE={{str="тЇргЇвля",gen="тЇргЇвли"}},
    TRAVELERS={{str="їутники",gen="їутникЇв",flags={OF=true}}},
    TREACHERY={{str="їредательствЇ",gen="їредательства"}},
    TREES={{str="деревья",gen="деревьев",flags={OF=true}}},
    TRICKERY={{str="Їбман",gen="Їбмана"}},
    TRUTH={{str="истина",gen="истины"}},
    TWILIGHT={{str="сумерки",gen="сумерек"}},
    VALOR={{str="дЇблесть",gen="дЇблести"}},
    VICTORY={{str="їЇбеда",gen="їЇбеды"}},
    VOLCANOS={{str="вулканы",gen="вулканЇв",flags={OF=true}}},
    WAR={{str="вЇйна",gen="вЇйны"}},
    WATER={{str="вЇда",gen="вЇды"}},
    WEALTH={{str="бЇгатствЇ",gen="бЇгатства"}},
    WEATHER={{str="їЇгЇда",gen="їЇгЇды"}},
    WIND={{str="ветер",gen="ветра"}},
    WISDOM={{str="мудрЇсть",gen="мудрЇсти"}},
    WRITING={{str="їисьменнЇсть",gen="їисьменнЇсти"}},
    YOUTH={{str="юнЇсть",gen="юнЇсти"}},
}

function get_random_sphere_noun(sph)
    local tbl = sph and pick_random(random_sphere_nouns[sph]) or {str="без сферы",gen="без сферы"}
    tbl.flags=tbl.flags or {OF=true,PREPOS=true,PRE=true}
    return tbl
end

function add_sphere_mpp(sphere_list, new_s, available_sphere, available_sphere_cur)
    sphere_list[new_s]=true

    available_sphere[new_s]=false
    available_sphere_cur[new_s]=false
    local total={}
    local l=get_debug_logger(2)
    local function merge_parents(s)
        l("Merging parents",s)
        for k,v in pairs(world.spheres[s].parents) do
            if not total[k] then
                total[k]=v
                merge_parents(k)
            end
        end
    end
    local function merge_children(s)
        l("Merging children",s)
        for k,v in pairs(world.spheres[s].children) do
            if not total[k] then
                total[k]=v
                merge_children(k)
            end
        end
    end
    merge_parents(new_s)
    merge_children(new_s)
    for k,v in pairs(total) do
        available_sphere[k]=false
        available_sphere_cur[k]=false
    end
    for k,v in pairs(world.spheres[new_s].enemies) do
        available_sphere_cur[k]=false
    end
    l("Done with MPP")
end