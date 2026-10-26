require "generators.creatures.rcp"

require "generators.creatures.shared_info"

-- df-ru: оед.:мн.:ед.п для NAME/CASTE_NAME. noun={name=,names=,g=}; adj ─ їрилагательнЇе м. р. (сЇгласуется,
-- а если этЇ не їрилагательнЇе ─ оцвета мЇрскЇй вЇлнып ─ ставится їЇсле слЇва); post ─ хвЇст (о нЇчип).
function ru_name_str(noun,adj,post)
    post=post or ""
    local function one(word,g)
        if not adj or adj=="" then return word..post end
        if RU.is_adj(adj) then return RU.adj(adj,g).." "..word..post end
        return word.." "..adj..post
    end
    local sg=one(noun.name,noun.g)
    return sg..":"..one(noun.names,"p")..":"..sg
end

-- df-ru: рЇд. ї. оїрилагательнЇе + слЇвЇп для ожена нЇчнЇгЇ трЇлляп
function ru_gen_phrase(noun,adj)
    if not adj or adj=="" then return noun.gs end
    if RU.is_adj(adj) then return RU.adj(adj,noun.g,"gen").." "..noun.gs end
    return noun.gs.." "..adj
end

-- df-ru: титан їЇ местнЇсти: їрилагательнЇе (обЇлЇтный титанп) или рЇд. ї. їЇсле слЇва (отитан джунглейп)
RU_TITAN_REGION={
    swamp={"бЇлЇтный"}, marsh={nil,"тЇїей"}, sand={"їесчаный"}, desert={"їустынный"}, taiga={"таєжный"},
    jungle={nil,"джунглей"}, forest={"леснЇй"}, mountain={"гЇрный"}, ocean={"Їкеанский"}, lake={"Їзєрный"},
    glacier={"ледникЇвый"}, tundra={nil,"тундры"}, brush={nil,"зарЇслей"}, savanna={nil,"саванны"},
    plains={"стеїнЇй"}, hill={nil,"хЇлмЇв"}, buggy={"странный"},
}


regiontypes={
    SWAMP={
        spheres={
            WATER=true,
            MUCK=true,
            PLANTS=true,
            ANIMALS=true,
            NATURE=true,
        },
        name=function(sr)
            local swamp_count = 0
            for k,v in pairs(sr.biome_count) do
                if string.find(k,"SWAMP") then
                    swamp_count = swamp_count + 1
                elseif string.find(k,"MARSH") then
                    swamp_count = swamp_count - 1
                end
            end
            return (swamp_count >= 0) and "swamp" or "marsh"
        end
    },
    DESERT={
        spheres={
            FIRE=true,
            PLANTS=true,
            ANIMALS=true,
            NATURE=true,
        },
        name=function(sr)
            return (sr.biome_count.DESERT_SAND > sr.biome_count.DESERT_ROCK + sr.biome_count.DESERT_BADLAND) and "sand" or "desert"
        end
    },
    FOREST={
        spheres={
            TREES=true,
            PLANTS=true,
            RIVERS=true,
            ANIMALS=true,
            NATURE=true,
        },
        name=function(sr)
            if sr.biome_count.FOREST_TAIGA>
              sr.biome_count.FOREST_TEMPERATE_CONIFER+
              sr.biome_count.FOREST_TEMPERATE_BROADLEAF+
              sr.biome_count.FOREST_TROPICAL_CONIFER+
              sr.biome_count.FOREST_TROPICAL_DRY_BROADLEAF+
              sr.biome_count.FOREST_TROPICAL_MOIST_BROADLEAF then
                return "taiga"
            elseif sr.biome_count.FOREST_TROPICAL_MOIST_BROADLEAF>
              sr.biome_count.FOREST_TAIGA+
              sr.biome_count.FOREST_TEMPERATE_CONIFER+
              sr.biome_count.FOREST_TEMPERATE_BROADLEAF+
              sr.biome_count.FOREST_TROPICAL_CONIFER+
              sr.biome_count.FOREST_TROPICAL_DRY_BROADLEAF then 
                return "jungle"    
            else
                return "forest"
            end
        end
    },
    MOUNTAINS={
        spheres={
            MOUNTAINS=true,
            CAVERNS=true,
            MINERALS=true,
            METALS=true,
            ANIMALS=true,
            NATURE=true,
        },
        name=function() return "mountain" end
    },
    OCEAN={
        spheres={
            WATER=true,
            OCEANS=true,
            FISH=true,
            ANIMALS=true,
            NATURE=true,
        },
        name=function() return "ocean" end
    },
    LAKE={
        spheres={
            WATER=true,
            LAKES=true,
            RIVERS=true,
            FISH=true,
            ANIMALS=true,
            NATURE=true,
        },
        name=function() return "lake" end
    },
    GLACIER={
        spheres={
            ANIMALS=true,
            NATURE=true,
        },
        name=function() return "glacier" end
    },
    TUNDRA={
        spheres={
            ANIMALS=true,
            NATURE=true,
        },
        name=function() return "tundra" end
    },
    GRASSLAND={
        spheres={
            ANIMALS=true,
            RIVERS=true,
            PLANTS=true,
            NATURE=true,
        },
        name=function(sr) 
            if sr.biome_count.SHRUBLAND_TEMPERATE+
              sr.biome_count.SHRUBLAND_TROPICAL>
              sr.biome_count.GRASSLAND_TEMPERATE+
              sr.biome_count.GRASSLAND_TROPICAL+
              sr.biome_count.SAVANNA_TEMPERATE+
              sr.biome_count.SAVANNA_TROPICAL then
                return "brush"
            elseif(sr.biome_count.SAVANNA_TEMPERATE+
              sr.biome_count.SAVANNA_TROPICAL>
              sr.biome_count.SHRUBLAND_TEMPERATE+
              sr.biome_count.SHRUBLAND_TROPICAL+
              sr.biome_count.GRASSLAND_TEMPERATE+
              sr.biome_count.GRASSLAND_TROPICAL) then 
                return "savanna"
            else
                return "plains"
            end
        end
    },
    HILLS={
        spheres={
            ANIMALS=true,
            RIVERS=true,
            PLANTS=true,
            NATURE=true,
        },
        name=function() return "hill" end
    },
    NONE={
        spheres={},
        name=function(subregion) return "buggy" end
    }
}

creatures.fb.default=function(layer_type,tok)
    local tbl={}
    local options={
        strong_attack_tweak=true,
        spheres={CAVERNS=true},
        is_evil=true,
        sickness_name="звериная хвЇрь",
        token=tok
    }
    tbl=split_to_lines(tbl,[[
    [FEATURE_BEAST]
    [ATTACK_TRIGGER:0:0:2]
    [NAME:забытый зверь:забытые звери:забытый зверь]
    [CASTE_NAME:забытый зверь:забытые звери:забытый зверь]
    [NO_GENDER]
    [CARNIVORE]
    [DIFFICULTY:10]

    [NATURAL_SKILL:WRESTLING:6]
    [NATURAL_SKILL:BITE:6]
    [NATURAL_SKILL:GRASP_STRIKE:6]
    [NATURAL_SKILL:STANCE_STRIKE:6]
    [NATURAL_SKILL:MELEE_COMBAT:6]
    [NATURAL_SKILL:DODGING:6]
    [NATURAL_SKILL:SITUATIONAL_AWARENESS:6]
    [LARGE_PREDATOR]
    ]])
    add_regular_tokens(tbl,options)
    tbl[#tbl+1]=layer_type==0 and "[BIOME:SUBTERRANEAN_WATER]" or "[BIOME:SUBTERRANEAN_CHASM]"
    if layer_type==0 then options.spheres.WATER=true end
    options.spheres[pick_random(evil_spheres)]=true
    options.do_water=layer_type==0
    populate_sphere_info(tbl,options)
    local rcp=get_random_creature_profile(options)
    add_body_size(tbl,math.max(10000000,rcp.min_size),options)
    tbl[#tbl+1]="[CREATURE_TILE:"..tile_string(rcp.tile).."]"
    build_procgen_creature(rcp,tbl,options)
    return {raws=tbl,weight=1}
end

creatures.titan.default=function(subregion,tok)
    local tbl={}
    local options={
        pick_sphere_rcm=true,
        strong_attack_tweak=true,
        sickness_name="хвЇрь титана",
        token=tok
    }
    local atp = tostring(world.param.titan_attack_trigger_population)
    local atew = tostring(world.param.titan_attack_trigger_exported_wealth)
    local atcw = tostring(world.param.titan_attack_trigger_created_wealth)
    split_to_lines(tbl,[[
    [TITAN]
    [ATTACK_TRIGGER:]]..atp..":"..atew..":"..atcw..[[]
    [NO_GENDER]
    [NO_DRINK][NO_EAT][NO_SLEEP]
    [DIFFICULTY:10]
    [LAIR:SHRINE:100]

    [NATURAL_SKILL:WRESTLING:6]
    [NATURAL_SKILL:BITE:6]
    [NATURAL_SKILL:GRASP_STRIKE:6]
    [NATURAL_SKILL:STANCE_STRIKE:6]
    [NATURAL_SKILL:MELEE_COMBAT:6]
    [NATURAL_SKILL:DODGING:6]
    [NATURAL_SKILL:SITUATIONAL_AWARENESS:15]
    ]])
    add_regular_tokens(tbl,options)
    options.spheres={}
    if subregion then
        map_merge(options.spheres,regiontypes[subregion.type].spheres)
        if subregion.is_evil then
            options.spheres[pick_random(evil_spheres)]=true
            options.is_evil = true
        elseif subregion.is_good then
            options.spheres[pick_random(good_spheres)]=true
            options.is_good = true
        end
    end
    populate_sphere_info(tbl,options)
    local rcp=get_random_creature_profile(options)
    add_body_size(tbl,math.max(10000000,rcp.min_size),options)
    tbl[#tbl+1]="[CREATURE_TILE:"..tile_string(rcp.tile).."]"
    if options.is_good then
        tbl[#tbl+1]="[BENIGN]"
    else
        tbl[#tbl+1]="[LARGE_PREDATOR]"
    end
    build_procgen_creature(rcp,tbl,options)
    tbl[#tbl+1]="[GO_TO_START]"
    local subreg_name=subregion and regiontypes[subregion.type].name(subregion) or "buggy"
    local ru_t=RU_TITAN_REGION[subreg_name] or RU_TITAN_REGION.buggy
    local name_str
    if ru_t[1] then
        name_str=ru_t[1].." титан:"..RU.adj(ru_t[1],"p").." титаны:"..ru_t[1].." титан]"
    else
        name_str="титан "..ru_t[2]..":титаны "..ru_t[2]..":титан "..ru_t[2].."]"
    end
    tbl[#tbl+1]="[NAME:"..name_str
    tbl[#tbl+1]="[CASTE_NAME:"..name_str
    return {raws=tbl,weight=1}
end

local adj_exploitable_check <const> = function(str)
    return not str or (string.upper(str)~="BLACK" and str~="чєрный")
end

demon_names={
    {name="демЇн",names="демЇны",g="m",cond=function(options) return true end},
    {name="дьявЇл",names="дьявЇлы",g="m",cond=function(options) return true end},
    {name="исчадие",names="исчадия",g="n",cond=function(options) return true end},
    {name="грЇмила",names="грЇмилы",g="m",cond=function(options) return adj_exploitable_check(options.fadj) end},
    {name="чудище",names="чудища",g="n",cond=function(options) return true end},
    {name="дух",names="духи",g="m",cond=function(options) return options.intangible end},
    {name="їризрак",names="їризраки",g="m",cond=function(options) return options.intangible end},
    {name="банши",names="банши",g="f",cond=function(options) return options.intangible end},
    {name="їривидение",names="їривидения",g="n",cond=function(options) return options.intangible end},
    {name="фантЇм",names="фантЇмы",g="m",cond=function(options) return options.intangible end},
    {name="видение",names="видения",g="n",cond=function(options) return options.intangible end},
    {name="умертвие",names="умертвия",g="n",cond=function(options) return options.intangible end},
}

creatures.demon.default=function(demon_type,difficulty,tok)
    local tbl={}
    local l2=get_debug_logger(2)
    l2(tok,demon_type,difficulty)
    local options={
        is_evil=true,
        pick_sphere_rcm=true,
        strong_attack_tweak=true,
        always_nobreathe=true,
        force_goo=true,
        intangible_flier=true,
        fixed_temp=10040,
        forced_odor_chance=2,
        forced_odor_string="сера",
        forced_odor_level=90,
        sickness_name="демЇническая хвЇрь",
        feature_flavor_adj=true,
        fire_immune=true,
        token=tok
    }
    if demon_type=="unique" then
        tbl=split_to_lines(tbl,[[
[UNIQUE_DEMON]
[SPREAD_EVIL_SPHERES_IF_RULER]

[NATURAL_SKILL:WRESTLING:14]
[NATURAL_SKILL:BITE:14]
[NATURAL_SKILL:GRASP_STRIKE:14]
[NATURAL_SKILL:STANCE_STRIKE:14]
[NATURAL_SKILL:MELEE_COMBAT:14]
[NATURAL_SKILL:RANGED_COMBAT:14]
[NATURAL_SKILL:DODGING:14]
[NATURAL_SKILL:SITUATIONAL_AWARENESS:14]

[CAN_LEARN][CAN_SPEAK][DIFFICULTY:10]
        ]])
        options.humanoidable_only=true
        options.can_learn=true
    else
        tbl=split_to_lines(tbl,[[
[DEMON]

[NATURAL_SKILL:WRESTLING:10]
[NATURAL_SKILL:BITE:10]
[NATURAL_SKILL:GRASP_STRIKE:10]
[NATURAL_SKILL:STANCE_STRIKE:10]
[NATURAL_SKILL:MELEE_COMBAT:10]
[NATURAL_SKILL:RANGED_COMBAT:10]
[NATURAL_SKILL:DODGING:10]
[NATURAL_SKILL:SITUATIONAL_AWARENESS:10]
        ]])
        if(demon_type=="humanoid_beast") then options.humanoidable_only=true end
        if one_in(2) then 
            tbl[#tbl+1]="[CAN_LEARN][CAN_SPEAK]"
            options.can_learn=true
        end
        tbl=split_to_lines(tbl,[[
[LARGE_ROAMING]
[LARGE_PREDATOR][DIFFICULTY:]]..tostring(difficulty)..[[]
[BIOME:SUBTERRANEAN_CHASM]
[UNDERGROUND_DEPTH:5:5]
[POPULATION_NUMBER:5:10]
[CLUSTER_NUMBER:1:5]
]])
        options.fallback_pref_str="ужасающий Їблик"
    end
    pick_random({
        function()
            tbl[#tbl+1]="[CASTE:FEMALE]"
            tbl[#tbl+1]="[FEMALE]"
            tbl[#tbl+1]="[CASTE:MALE]"
            tbl[#tbl+1]="[MALE]"
            tbl[#tbl+1]="[SELECT_CASTE:ALL]"
        end,
        function()
            tbl[#tbl+1]="[MALE]"
        end,
        function()
            tbl[#tbl+1]="[FEMALE]"
        end,
        function()
            tbl[#tbl+1]="[NO_GENDER]"
        end
    })()
    tbl=split_to_lines(tbl,[[[PHYS_ATT_RANGE:STRENGTH:450:1050:1150:1250:1350:1550:2250]
[PHYS_ATT_RANGE:TOUGHNESS:450:1050:1150:1250:1350:1550:2250]
[PHYS_ATT_RANGE:ENDURANCE:450:1050:1150:1250:1350:1550:2250]
[PHYS_ATT_RANGE:RECUPERATION:450:1050:1150:1250:1350:1550:2250]
[PHYS_ATT_RANGE:DISEASE_RESISTANCE:700:1300:1400:1500:1600:1800:2500]
[MENT_ATT_RANGE:ANALYTICAL_ABILITY:1250:1500:1750:2000:2500:3000:5000]
[MENT_ATT_RANGE:FOCUS:1250:1500:1750:2000:2500:3000:5000]
[MENT_ATT_RANGE:WILLPOWER:1250:1500:1750:2000:2500:3000:5000]
[MENT_ATT_RANGE:PATIENCE:0:333:666:1000:2333:3666:5000]
[MENT_ATT_RANGE:MEMORY:1250:1500:1750:2000:2500:3000:5000]
[MENT_ATT_RANGE:LINGUISTIC_ABILITY:450:1050:1150:1250:1350:1550:2250]
[MENT_ATT_RANGE:MUSICALITY:0:333:666:1000:2333:3666:5000]
[MENT_ATT_RANGE:SOCIAL_AWARENESS:700:1300:1400:1500:1600:1800:2500]
[PERSONALITY:ANXIETY_PROPENSITY:0:0:0]
[PERSONALITY:DEPRESSION_PROPENSITY:0:0:0]
[PERSONALITY:BASHFUL:0:0:0]
[PERSONALITY:STRESS_VULNERABILITY:0:0:0]
[PERSONALITY:FRIENDLINESS:0:0:0]
[PERSONALITY:ASSERTIVENESS:100:100:100]
[PERSONALITY:DISDAIN_ADVICE:100:100:100]
[PERSONALITY:CHEER_PROPENSITY:0:0:0]
[PERSONALITY:GRATITUDE:0:0:0]
[PERSONALITY:TRUST:0:0:0]
[PERSONALITY:ALTRUISM:0:0:0]
[PERSONALITY:SWAYED_BY_EMOTIONS:0:0:0]
[PERSONALITY:CRUELTY:100:100:100]
[PERSONALITY:PRIDE:100:100:100]
[PERSONALITY:GREED:100:100:100]
[NO_DRINK][NO_EAT][NO_SLEEP]
[BODY_APPEARANCE_MODIFIER:HEIGHT:90:95:98:100:102:105:110]
[BODY_APPEARANCE_MODIFIER:BROADNESS:90:95:98:100:102:105:110]
[MAGMA_VISION]
[EVIL]
[FANCIFUL]
[SUPERNATURAL]
]])
    add_regular_tokens(tbl,options)
    local available_sphere_cur={}
    local available_sphere={}
    options.spheres={}
    l2("Starting spheres")
    for k,v in pairs(world.spheres) do
        available_sphere_cur[k]=true
        available_sphere[k]=true
    end
    --ANY SPHERE COLLECTION + ONE EVIL + NO PURE GOOD/CIVIS/FLUFF STUFF
    available_sphere_cur.AGRICULTURE=false;
    available_sphere_cur.BALANCE=false;
    available_sphere_cur.CHARITY=false;
    available_sphere_cur.CONSOLATION=false;
    available_sphere_cur.COURAGE=false;
    available_sphere_cur.DUTY=false;
    available_sphere_cur.FAMILY=false;
    available_sphere_cur.FERTILITY=false;
    available_sphere_cur.FESTIVALS=false;
    available_sphere_cur.FORGIVENESS=false;
    available_sphere_cur.FREEDOM=false;
    available_sphere_cur.GENEROSITY=false;
    available_sphere_cur.HAPPINESS=false;
    available_sphere_cur.HEALING=false;
    available_sphere_cur.HOSPITALITY=false;
    available_sphere_cur.JUSTICE=false;
    available_sphere_cur.LABOR=false;
    available_sphere_cur.LOVE=false;
    available_sphere_cur.LOYALTY=false;
    available_sphere_cur.MARRIAGE=false;
    available_sphere_cur.MERCY=false;
    available_sphere_cur.OATHS=false;
    available_sphere_cur.PEACE=false;
    available_sphere_cur.PREGNANCY=false;
    available_sphere_cur.RAINBOWS=false;
    available_sphere_cur.REVELRY=false;
    available_sphere_cur.SACRIFICE=false;
    available_sphere_cur.TRADE=false;
    available_sphere_cur.TRAVELERS=false;
    available_sphere_cur.TRUTH=false;
    available_sphere_cur.VALOR=false;
    available_sphere_cur.WISDOM=false;
    local branch_number=trandom(2)+1
    while branch_number > 0 do
        local candidates={}
        -- not cleverness, just paranoia
        if branch_number<=1 then
            for k,v in ipairs(evil_spheres) do
                if available_sphere_cur[v] then candidates[#candidates+1]=v end
            end
        end
        if #candidates==0 then
            for k,v in pairsByKeys(available_sphere_cur) do
                if v then candidates[#candidates+1]=k end
            end
        end
        if #candidates then
            local new_s = pick_random(candidates)
            add_sphere_mpp(options.spheres,new_s,available_sphere,available_sphere_cur)
            while one_in(2) do
                candidates={}
                for k,v in pairsByKeys(world.spheres[new_s].friends) do
                    if available_sphere_cur[k] then
                        candidates[#candidates+1]=k
                    end
                end
                new_s = pick_random(candidates)
                if new_s then
                    add_sphere_mpp(options.spheres,new_s,available_sphere,available_sphere_cur)
                else
                    break
                end
            end
        end
        branch_number = branch_number-1
    end
    l2("Done with spheres")
    options.beast_only=demon_type=="humanoid_beast" or demon_type=="beast"
    if demon_type=="flying_spirit" then
        options.always_insubstantial=true
        options.always_make_uniform=true
    end
    populate_sphere_info(tbl,options)
    local rcp=get_random_creature_profile(options)
    local body_size = difficulty==6 and (400000+trandom(9)*10000 + trandom(11)*1000) or (10000000)
    add_body_size(tbl,math.max(body_size, rcp.min_size),options)
    tbl[#tbl+1]="[CREATURE_TILE:'&']"
    build_procgen_creature(rcp,tbl,options)
    tbl[#tbl+1]="[GO_TO_START]"
    options.flavor_adj = options.flavor_adj or {}
    options.potential_end_phrase = options.potential_end_phrase or {}
    local name_str=""
    if (#options.flavor_adj>0 or #options.potential_end_phrase>0) and one_in(3) then
        if trandom(#options.flavor_adj + #options.potential_end_phrase) > #options.flavor_adj then
            options.eadj=pick_random(options.potential_end_phrase)
            local name=pick_random_conditional(demon_names,"cond",options)
            name_str=ru_name_str(name,nil,options.eadj)
        else
            options.fadj=pick_random(options.flavor_adj)
            local name=pick_random_conditional(demon_names,"cond",options)
            name_str=ru_name_str(name,options.fadj)
        end
    elseif not options.name_mat or #options.name_mat==0 then
        local name=pick_random_conditional(demon_names,"cond",options)
        name_str=ru_name_str(name,RU.rcp(rcp.name_string).adj)
    else
        local name=pick_random_conditional(demon_names,"cond",options)
        local nmm=pick_random(options.name_mat)
        local mat=RU.mat(nmm)
        if one_in(2) or not mat.adj then
            name_str=ru_name_str(name,nil," "..mat.gen) -- одемЇн їеїлап
        else
            name_str=ru_name_str(name,mat.adj) -- оїеїельный демЇнп
        end
    end
    if name_str=="" then
        local name=pick_random_conditional(demon_names,"cond",options)
        name_str=ru_name_str(name,RU.rcp(rcp.name_string).adj)
    end
    if name_str=="" then
        name_str="сбЇйный демЇн:сбЇйные демЇны:сбЇйный демЇн"
    end
    tbl[#tbl+1]="[NAME:"..name_str.."]"
    tbl[#tbl+1]="[CASTE_NAME:"..name_str.."]"
    return {raws=tbl,weight=1}
end

function night_creature_universals(lines,options)
    map_merge(options,{
    do_not_make_uniform=true,
    always_nobreathe=true,
    no_random_attack_tweak=true,
    cannot_have_mandibles=true,
    cannot_have_antennae=true,
    end_phrase="Теїерь вы знаете, їЇчему бЇитесь нЇчи.",
    sickness_name="нЇчная хвЇрь",
    never_uniform=true,
    is_evil=true
    })
    -- obviously these can just be adjusted after the fact
    -- e.g. in bogeymen `options.cannot_have_antennae=false`
    lines[#lines+1]="[ATTACK_TRIGGER:"..tostring(world.param.werebeast_attack_trigger_population)..":"..tostring(world.param.werebeast_attack_trigger_exported_wealth)..":"..world.param.werebeast_attack_trigger_created_wealth.."]"
    lines[#lines+1]="[NO_DRINK][NO_EAT][NO_SLEEP]"
    lines[#lines+1]="[BODY_APPEARANCE_MODIFIER:HEIGHT:90:95:98:100:102:105:110]"
    lines[#lines+1]="[BODY_APPEARANCE_MODIFIER:BROADNESS:90:95:98:100:102:105:110]"
    lines[#lines+1]="[LARGE_PREDATOR]"
    lines[#lines+1]="[EVIL]"
    lines[#lines+1]="[SUPERNATURAL]"
    lines[#lines+1]="[FANCIFUL]"
end

night_troll_names={
    {name="трЇлль",names="трЇлли",g="m",gs="трЇлля",cond=function(options) return true end},
    {name="челЇвек",names="люди",g="m",gs="челЇвека",cond=function(options) return adj_exploitable_check(options.fadj) and options.is_male_version end},
    {name="женщина",names="женщины",g="f",gs="женщины",cond=function(options) return adj_exploitable_check(options.fadj) and not options.is_male_version end},
    {name="грЇмила",names="грЇмилы",g="m",gs="грЇмилы",cond=function(options) return options.is_male_version and options.night_creature_strength_pref and adj_exploitable_check(options.fadj) end},
    {name="карга",names="карги",g="f",gs="карги",cond=function(options) return not options.is_male_version end},
    {name="старуха",names="старухи",g="f",gs="старухи",cond=function(options) return not options.is_male_version end},
    {name="чудище",names="чудища",g="n",gs="чудища",cond=function(options) return true end},
    {name="сЇздание",names="сЇздания",g="n",gs="сЇздания",cond=function(options) return true end},
    {name="Їгр",names="Їгры",g="m",gs="Їгра",cond=function(options) return options.night_creature_strength_pref and options.is_male_version end},
    {name="Їгрица",names="Їгрицы",g="f",gs="Їгрицы",cond=function(options) return options.night_creature_strength_pref and not options.is_male_version end},
    {name="урЇд",names="урЇды",g="m",gs="урЇда",cond=function(options) return adj_exploitable_check(options.fadj) end},
    {name="ужас",names="ужасы",g="m",gs="ужаса",cond=function(options) return true end},
}

night_troll_flavor_adjs={
    "нЇчнЇй",
    "тємный",
    "теневЇй",
    "їЇлунЇчный",
    "вечерний",
    "мерзкий",
    "злЇбный",
    "сумеречный",
    "лунный",
    "мрачный",
    "угрюмый",
}

night_troll_flavor={
    {
        add="{Їн} бесцельнЇ брЇдит, бЇрмЇча себе їЇд нЇс",
        flavor_adj={"бЇрмЇчущий","вЇрчащий","шеїчущий","хмурый"}
    },
    {
        add="время Їт времени {Їн} стЇнет",
        flavor_adj={"стЇнущий","стенающий","шеїчущий","хмурый"}
    },
    {
        add="{Їн} вЇет навстречу сильнЇму ветру",
        flavor_adj={"вЇїящий","вЇющий","лающий","ревущий","визжащий","рыдающий"}
    },
}
night_troll_strength_flavor={
    {
        add="{Їн} вялЇ кЇвыляет",
        flavor_adj={}
    },
    {
        add="{Їн} тЇїает и фыркает",
        flavor_adj={}
    },
    {
        add="у {негЇ} раздутЇе телЇ",
        flavor_adj={"раздутый"}
    },
    {
        add="{Їн} грузнЇ бредєт с места на местЇ",
        flavor_adj={}
    },
}
night_troll_agile_flavor={
    {
        add="суставы у {негЇ} вывернуты назад",
        flavor_adj={"вывернутый"}
    },
    {
        add="{Їн} движется нерЇвными рывками",
        flavor_adj={}
    },
    {
        add="кЇнечнЇсти у {негЇ} тЇрчат їЇд нерЇвными углами",
        flavor_adj={"кривЇй","скрюченный"}
    },
    {
        add="{Їн} быстрЇ скачет їЇ земле",
        flavor_adj={}
    },
    {
        add="{Їн} мЇлча и целеустремлєннЇ шагает",
        flavor_adj={}
    },
}

night_troll_smells={
    "внутреннЇсти насекЇмых",
    "жаренЇе мясЇ",
    "смерть"
}

creatures.night_creature.troll.default=function(tok)
    local lines={}
    local options={
        spheres={
            NIGHT=true,
            DEATH=true
        },
        fallback_pref_str="жуткие їЇвадки",
        token=tok
    }
    options.is_male_version=one_in(2)
    if one_in(2) then
        options.night_creature_strength_pref=true
    else
        options.night_creature_agile_pref=true
    end
    night_creature_universals(lines,options)
    -- partially I started feeling split_to_lines is ugly,
    -- partially I want to show there's no one right way to do it
    -- hopefully my caprice isn't too aggravating
    lines[#lines+1]="[NIGHT_CREATURE_HUNTER]"
    lines[#lines+1]="[BIOME:ANY_FOREST]"
    lines[#lines+1]="[BIOME:ANY_SHRUBLAND]"
    lines[#lines+1]="[BIOME:ANY_SAVANNA]"
    lines[#lines+1]="[BIOME:ANY_GRASSLAND]"
    lines[#lines+1]="[BIOME:ANY_WETLAND]"
    lines[#lines+1]="[BIOME:TUNDRA]"
    if options.is_male_version then
        lines[#lines+1]="[CASTE:MALE]"
        lines[#lines+1]="[MALE]"
        lines[#lines+1]="[SPOUSE_CONVERTER]"
        lines[#lines+1]="[ORIENTATION:MALE:1:0:0]"
        lines[#lines+1]="[ORIENTATION:FEMALE:0:0:1]"
    lines[#lines+1]="[CASTE:FEMALE]"
        lines[#lines+1]="[FEMALE]"
        lines[#lines+1]="[CONVERTED_SPOUSE]"
    else
        lines[#lines+1]="[CASTE:FEMALE]"
        lines[#lines+1]="[FEMALE]"
        lines[#lines+1]="[SPOUSE_CONVERTER]"
        lines[#lines+1]="[ORIENTATION:MALE:0:0:1]"
        lines[#lines+1]="[ORIENTATION:FEMALE:1:0:0]"
    lines[#lines+1]="[CASTE:MALE]"
        lines[#lines+1]="[MALE]"
        lines[#lines+1]="[CONVERTED_SPOUSE]"
    end
    lines[#lines+1]="[SELECT_CASTE:ALL]"

    lines[#lines+1]="[CAN_LEARN]"
    if one_in(2) then lines[#lines+1]="[SLOW_LEARNER]" end
    lines[#lines+1]="[CAN_SPEAK]"
    lines[#lines+1]="[SENSE_CREATURE_CLASS:GENERAL_POISON:15:4:0:1]"
    if options.night_creature_strength_pref then
        lines[#lines+1]="[PHYS_ATT_RANGE:STRENGTH:1000:1250:1500:2000:2250:2500:3000]"
        lines[#lines+1]="[PHYS_ATT_RANGE:AGILITY:450:550:700:750:800:850:900]"
        lines[#lines+1]="[PHYS_ATT_RANGE:TOUGHNESS:850:900:950:1000:1050:1100:1150]"
        lines[#lines+1]="[PHYS_ATT_RANGE:ENDURANCE:850:900:950:1000:1050:1100:1150]"
        options.special_walk_speed=1000
    elseif options.night_creature_agile_pref then
        lines[#lines+1]="[PHYS_ATT_RANGE:STRENGTH:450:550:700:750:800:850:900]"
        lines[#lines+1]="[PHYS_ATT_RANGE:AGILITY:1000:1250:1500:2000:2250:2500:3000]"
        lines[#lines+1]="[PHYS_ATT_RANGE:TOUGHNESS:850:900:950:1000:1050:1100:1150]"
        lines[#lines+1]="[PHYS_ATT_RANGE:ENDURANCE:850:900:950:1000:1050:1100:1150]"
        options.special_walk_speed=800;
    elseif options.night_creature_strength_agile_pref then
        lines[#lines+1]="[PHYS_ATT_RANGE:STRENGTH:1000:1150:1250:1500:2000:2250:2500]"
        lines[#lines+1]="[PHYS_ATT_RANGE:AGILITY:1000:1150:1250:1500:2000:2250:2500]"
        lines[#lines+1]="[PHYS_ATT_RANGE:TOUGHNESS:850:900:950:1000:1050:1100:1150]"
        lines[#lines+1]="[PHYS_ATT_RANGE:ENDURANCE:850:900:950:1000:1050:1100:1150]"
        options.special_walk_speed=850;
    end
    lines[#lines+1]="[PHYS_ATT_RANGE:RECUPERATION:450:1050:1150:1250:1350:1550:2250]"
    lines[#lines+1]="[PHYS_ATT_RANGE:DISEASE_RESISTANCE:700:1300:1400:1500:1600:1800:2500]"
    lines[#lines+1]="[MENT_ATT_RANGE:ANALYTICAL_ABILITY:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:FOCUS:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:WILLPOWER:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:PATIENCE:0:333:666:1000:2333:3666:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:MEMORY:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:LINGUISTIC_ABILITY:450:1050:1150:1250:1350:1550:2250]"
    lines[#lines+1]="[MENT_ATT_RANGE:MUSICALITY:0:333:666:1000:2333:3666:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:SOCIAL_AWARENESS:700:1300:1400:1500:1600:1800:2500]"
    --[[
MENTAL_ATTRIBUTE_CREATIVITY,
MENTAL_ATTRIBUTE_INTUITION,
MENTAL_ATTRIBUTE_SPATIAL_SENSE,
MENTAL_ATTRIBUTE_KINESTHETIC_SENSE,
MENTAL_ATTRIBUTE_EMPATHY,
    ]]
    --lines[#lines+1]="[PERSONALITY:ANXIETY_PROPENSITY:0:0:0]"
    --lines[#lines+1]="[PERSONALITY:DEPRESSION_PROPENSITY:0:0:0]"
    lines[#lines+1]="[PERSONALITY:BASHFUL:0:0:0]"
    lines[#lines+1]="[PERSONALITY:STRESS_VULNERABILITY:0:0:0]"
    lines[#lines+1]="[PERSONALITY:FRIENDLINESS:0:0:0]"
    --lines[#lines+1]="[PERSONALITY:ASSERTIVENESS:100:100:100]"
    lines[#lines+1]="[PERSONALITY:DISDAIN_ADVICE:100:100:100]"
    lines[#lines+1]="[PERSONALITY:CHEER_PROPENSITY:0:0:0]"
    lines[#lines+1]="[PERSONALITY:GRATITUDE:0:0:0]"
    lines[#lines+1]="[PERSONALITY:TRUST:0:0:0]"
    lines[#lines+1]="[PERSONALITY:ALTRUISM:0:0:0]"
    --lines[#lines+1]="[PERSONALITY:SWAYED_BY_EMOTIONS:0:0:0]"
    lines[#lines+1]="[PERSONALITY:CRUELTY:100:100:100]"
    --lines[#lines+1]="[PERSONALITY:PRIDE:100:100:100]"

    add_regular_tokens(lines,options)
    populate_sphere_info(lines,options)
    local rcp={
        name_string="humanoid",
		tile='H',
		body_base="HUMANOID",
		c_class="AMPHIBIAN", -- FOR SKIN/ORGANS AND NO HAIR/FEATHERS AT FIRST
		min_size=1,
        cannot_have_shell=true
    }
    lines[#lines+1]="[NATURAL_SKILL:WRESTLING:6]"
    lines[#lines+1]="[NATURAL_SKILL:BITE:6]"
    lines[#lines+1]="[NATURAL_SKILL:GRASP_STRIKE:6]"
    lines[#lines+1]="[NATURAL_SKILL:STANCE_STRIKE:6]"
    lines[#lines+1]="[NATURAL_SKILL:MELEE_COMBAT:6]"
    lines[#lines+1]="[NATURAL_SKILL:DODGING:6]"
    lines[#lines+1]="[NATURAL_SKILL:SITUATIONAL_AWARENESS:6]"

    lines[#lines+1]="[DIFFICULTY:3]"
    lines[#lines+1]="[LAIR:SIMPLE_MOUND:50]"
    lines[#lines+1]="[LAIR:SIMPLE_BURROW:50]"
    lines[#lines+1]="[LAIR_CHARACTERISTIC:HAS_DOORS:100]"
    lines[#lines+1]="[HABIT_NUM:TEST_ALL]"
    lines[#lines+1]="[HABIT:GRIND_BONE_MEAL:50]"
    lines[#lines+1]="[HABIT:COOK_BLOOD:50]"
    lines[#lines+1]="[HABIT:GRIND_VERMIN:50]"
    lines[#lines+1]="[HABIT:COOK_VERMIN:50]"
    lines[#lines+1]="[HABIT:COOK_PEOPLE:50]"
    lines[#lines+1]="[HABIT:COLLECT_TROPHIES:50]"
    lines[#lines+1]="[ODOR_STRING:"..pick_random(night_troll_smells).."]"
    lines[#lines+1]="[ODOR_LEVEL:90]"
    local body_size=70000+trandom(8)*10000+trandom(11)*1000
    options.body_size=body_size
    lines[#lines+1]="[SELECT_CASTE:"..(options.is_male_version and "MALE" or "FEMALE").."]"
    lines[#lines+1]="[BODY_SIZE:0:0:"..tostring(math.floor(body_size/20)).."]"
    lines[#lines+1]="[BODY_SIZE:2:0:"..tostring(math.floor(body_size/4)).."]"
    lines[#lines+1]="[BODY_SIZE:12:0:"..tostring(math.floor(body_size)).."]"
    body_size_properties(lines,body_size)
    local spouse_size=math.floor(body_size*(trandom(51)+50)/100)
    lines[#lines+1]="[SELECT_CASTE:"..(options.is_male_version and "FEMALE" or "MALE").."]"
    add_body_size(lines,spouse_size)
    lines[#lines+1]="[SELECT_CASTE:ALL]"
    lines[#lines+1]="[BABY:1]"
    lines[#lines+1]="[CHILD:18]"
    lines[#lines+1]="[CREATURE_TILE:165]" --е
    options.custom_desc_func=function(options)
        local add_tbl={}
        options.flavor_adj = options.flavor_adj or {}
        if one_in(4) then
            add_tbl=pick_random(night_troll_flavor)
        elseif options.night_creature_strength_pref then
            add_tbl=pick_random(night_troll_strength_flavor)
            options.flavor_adj[#options.flavor_adj+1]="неуклюжий"
            options.flavor_adj[#options.flavor_adj+1]="грЇмадный"
        elseif options.night_creature_agile_pref then
            add_tbl=pick_random(night_troll_agile_flavor)
            options.flavor_adj[#options.flavor_adj+1]="тЇщий"
            options.flavor_adj[#options.flavor_adj+1]="изгЇлЇдавшийся"
            options.flavor_adj[#options.flavor_adj+1]="истЇщєнный"
        end
        table_merge(options.flavor_adj,add_tbl.flavor_adj)
        return add_tbl.add
    end
    options.flavor_adj=options.flavor_adj or {}
    build_procgen_creature(rcp,lines,options)
    table_merge(options.flavor_adj,night_troll_flavor_adjs)
    night_troll_end_phrases=night_troll_end_phrases or {
        " нЇчи",
        " зла",
        " сумерек",
        " тени",
    }
    options.potential_end_phrase = options.potential_end_phrase or {}
    table_merge(options.potential_end_phrase,night_troll_end_phrases)
    local name_str=""
    local used_ending=false
    local name={}
    if trandom(#options.flavor_adj + #options.potential_end_phrase) >= #options.flavor_adj then
        options.eadj=pick_random(options.potential_end_phrase)
        name=pick_random_conditional(night_troll_names,"cond",options)
        name_str=ru_name_str(name,nil,options.eadj)
        used_ending=true
    else
        options.fadj=pick_random(options.flavor_adj)
        name=pick_random_conditional(night_troll_names,"cond",options)
        name_str=ru_name_str(name,options.fadj)
    end
    night_troll_wife_names=night_troll_wife_names or {
        {"суїруга","суїруги"},
        {"їЇдруга","їЇдруги"},
        {"сїутница","сїутницы"},
        {"жена","жєны"},
        {"невеста","невесты"},
    }
    night_troll_husband_names=night_troll_husband_names or {
        {"суїруг","суїруги"},
        {"друг","друзья"},
        {"сїутник","сїутники"},
        {"муж","мужья"},
        {"жених","женихи"},
        {"суженый","суженые"}
    }
    local sn,sns="",""
    if options.is_male_version then
        sn,sns=table.unpack(pick_random(night_troll_wife_names))
        lines[#lines+1]="[SELECT_CASTE:MALE]"
    else
        sn,sns=table.unpack(pick_random(night_troll_husband_names))
        lines[#lines+1]="[SELECT_CASTE:FEMALE]"
    end
    local cstr=""
    -- df-ru: ожена трЇлля нЇчип, ожена нЇчнЇгЇ трЇлляп (Їба английских їЇрядка дают ЇднЇ и тЇ же)
    if used_ending then
        local own=name.gs..options.eadj
        cstr=sn.." "..own..":"..sns.." "..own..":"..sn.." "..own
    elseif one_in(2) then
        local own=ru_gen_phrase(name,options.fadj)
        cstr=sn.." "..own..":"..sns.." "..own..":"..sn.." "..own
    else
        local own=ru_gen_phrase(name,options.fadj)
        cstr=sn.." "..own..":"..sns.." "..own..":"..sn.." "..own
    end
    lines[#lines+1]="[CASTE_NAME:"..name_str.."]"
    if options.is_male_version then lines[#lines+1]="[SELECT_CASTE:FEMALE]"
    else lines[#lines+1] = "[SELECT_CASTE:MALE]" end
    lines[#lines+1]="[CASTE_NAME:"..cstr.."]"
    lines[#lines+1]="[GO_TO_START]"
    lines[#lines+1]="[NAME:"..name_str.."]"
    return {raws=lines,weight=1}
end

creatures.night_creature.bogeyman.default=function(tok)
    local lines={}
    local options={
        can_bogey_polymorph=true,
        spheres={
            NIGHT=true,
            NIGHTMARES=true,
            MISERY=true
        },
        forced_color={
            f=0,
            b=0,
            br=1
        },
        no_general_poison=true,
        blood_color=function(cl)
            -- DARKER MAGENTA COLORS
            return cl.h>=260 and cl.h <= 340 and cl.v <= 0.5 and cl.v >= 0.1
        end,
        fallback_pref_str="навЇдящие ужас выхЇдки",
        token=tok
    }
    night_creature_universals(lines,options)
    options.cannot_have_antennae=false
    if one_in(10) then options.glowing_eyes=true end
    lines[#lines+1]="[NIGHT_CREATURE_BOGEYMAN]"

    lines[#lines+1]="[NATURAL_SKILL:WRESTLING:6]"
    lines[#lines+1]="[NATURAL_SKILL:BITE:6]"
    lines[#lines+1]="[NATURAL_SKILL:MELEE_COMBAT:6]"
    lines[#lines+1]="[NATURAL_SKILL:GRASP_STRIKE:6]"
    lines[#lines+1]="[NATURAL_SKILL:STANCE_STRIKE:6]"
    lines[#lines+1]="[NATURAL_SKILL:DODGING:6]"
    lines[#lines+1]="[NATURAL_SKILL:SITUATIONAL_AWARENESS:6]"

    lines[#lines+1]="[CAN_LEARN][CAN_SPEAK]"
    options.can_learn=true;
    lines[#lines+1]="[NO_GENDER]"
    lines[#lines+1]="[CLUSTER_NUMBER:4:6]"
    --[[******************************* BOGEY
        --atts
    lines[#lines+1]="[PHYS_ATT_RANGE:STRENGTH:450:1050:1150:1250:1350:1550:2250]"
    lines[#lines+1]="[PHYS_ATT_RANGE:TOUGHNESS:450:1050:1150:1250:1350:1550:2250]"
    lines[#lines+1]="[PHYS_ATT_RANGE:ENDURANCE:450:1050:1150:1250:1350:1550:2250]"
    lines[#lines+1]="[PHYS_ATT_RANGE:RECUPERATION:450:1050:1150:1250:1350:1550:2250]"
    lines[#lines+1]="[PHYS_ATT_RANGE:DISEASE_RESISTANCE:700:1300:1400:1500:1600:1800:2500]"
    lines[#lines+1]="[MENT_ATT_RANGE:ANALYTICAL_ABILITY:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:FOCUS:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:WILLPOWER:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:PATIENCE:0:333:666:1000:2333:3666:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:MEMORY:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:LINGUISTIC_ABILITY:450:1050:1150:1250:1350:1550:2250]"
    lines[#lines+1]="[MENT_ATT_RANGE:MUSICALITY:0:333:666:1000:2333:3666:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:SOCIAL_AWARENESS:700:1300:1400:1500:1600:1800:2500]"
MENTAL_ATTRIBUTE_CREATIVITY,
MENTAL_ATTRIBUTE_INTUITION,
MENTAL_ATTRIBUTE_SPATIAL_SENSE,
MENTAL_ATTRIBUTE_KINESTHETIC_SENSE,
MENTAL_ATTRIBUTE_EMPATHY,
    ]]
    lines[#lines+1]="[PERSONALITY:ANXIETY_PROPENSITY:0:0:0]"
    lines[#lines+1]="[PERSONALITY:DEPRESSION_PROPENSITY:0:0:0]"
    lines[#lines+1]="[PERSONALITY:BASHFUL:0:0:0]"
    lines[#lines+1]="[PERSONALITY:STRESS_VULNERABILITY:0:0:0]"
    lines[#lines+1]="[PERSONALITY:FRIENDLINESS:0:0:0]"
    lines[#lines+1]="[PERSONALITY:ASSERTIVENESS:100:100:100]"
    lines[#lines+1]="[PERSONALITY:DISDAIN_ADVICE:100:100:100]"
    lines[#lines+1]="[PERSONALITY:CHEER_PROPENSITY:0:0:0]"
    lines[#lines+1]="[PERSONALITY:GRATITUDE:0:0:0]"
    lines[#lines+1]="[PERSONALITY:TRUST:0:0:0]"
    lines[#lines+1]="[PERSONALITY:ALTRUISM:0:0:0]"
    lines[#lines+1]="[PERSONALITY:SWAYED_BY_EMOTIONS:0:0:0]"
    lines[#lines+1]="[PERSONALITY:CRUELTY:100:100:100]"
    --lines[#lines+1]="[PERSONALITY:PRIDE:100:100:100]"
    lines[#lines+1]="[PERSONALITY:HUMOR:100:100:100]"
    add_regular_tokens(lines,options)
    populate_sphere_info(lines,options)
    local rcp={
        name_string="humanoid",
		tile='H',
		body_base="HUMANOID",
		c_class="AMPHIBIAN", -- FOR SKIN/ORGANS AND NO HAIR/FEATHERS AT FIRST
		min_size=1,
        cannot_have_shell=true
    }
    add_body_size(lines,10000+trandom(11)*1000,options)
    lines[#lines+1]="[CREATURE_TILE:164]" --д
    options.custom_desc_func=function(options)
        return "{Їн} без умЇлку сыїлет злЇбными ЇскЇрблениями"
    end
    build_procgen_creature(rcp,lines,options)
    lines[#lines+1]="[GO_TO_START]"
    local name_str="бука:буки:бука]"
    lines[#lines+1]="[NAME:"..name_str
    lines[#lines+1]="[CASTE_NAME:"..name_str
    return {raws=lines,weight=1}
end

creatures.night_creature.nightmare.default=function(tok)
    local lines={}
    local options={
        spheres={
            NIGHT=true,
            NIGHTMARES=true,
            MISERY=true
        },
        forced_color={
            f=0,
            b=0,
            br=1
        },
        no_general_poison=true,
        blood_color=function(cl)
            -- DARKER MAGENTA COLORS
            return cl.h>=260 and cl.h <= 340 and cl.v <= 0.5 and cl.v >= 0.1
        end,
        fallback_pref_str="неїЇстижимЇ ужасная їрирЇда",
        token=tok
    }
    night_creature_universals(lines,options)
    options.cannot_have_antennae=false
    if one_in(10) then options.glowing_eyes=true end
    lines[#lines+1]="[NIGHT_CREATURE_NIGHTMARE]"

    lines[#lines+1]="[NATURAL_SKILL:WRESTLING:6]"
    lines[#lines+1]="[NATURAL_SKILL:BITE:6]"
    lines[#lines+1]="[NATURAL_SKILL:MELEE_COMBAT:6]"
    lines[#lines+1]="[NATURAL_SKILL:GRASP_STRIKE:6]"
    lines[#lines+1]="[NATURAL_SKILL:STANCE_STRIKE:6]"
    lines[#lines+1]="[NATURAL_SKILL:DODGING:6]"
    lines[#lines+1]="[NATURAL_SKILL:SITUATIONAL_AWARENESS:6]"

    lines[#lines+1]="[NO_GENDER]"
    lines[#lines+1]="[CLUSTER_NUMBER:1:1]"
    --[[******************************* BOGEY
        --atts
    lines[#lines+1]="[PHYS_ATT_RANGE:STRENGTH:450:1050:1150:1250:1350:1550:2250]"
    lines[#lines+1]="[PHYS_ATT_RANGE:TOUGHNESS:450:1050:1150:1250:1350:1550:2250]"
    lines[#lines+1]="[PHYS_ATT_RANGE:ENDURANCE:450:1050:1150:1250:1350:1550:2250]"
    lines[#lines+1]="[PHYS_ATT_RANGE:RECUPERATION:450:1050:1150:1250:1350:1550:2250]"
    lines[#lines+1]="[PHYS_ATT_RANGE:DISEASE_RESISTANCE:700:1300:1400:1500:1600:1800:2500]"
    lines[#lines+1]="[MENT_ATT_RANGE:ANALYTICAL_ABILITY:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:FOCUS:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:WILLPOWER:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:PATIENCE:0:333:666:1000:2333:3666:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:MEMORY:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:LINGUISTIC_ABILITY:450:1050:1150:1250:1350:1550:2250]"
    lines[#lines+1]="[MENT_ATT_RANGE:MUSICALITY:0:333:666:1000:2333:3666:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:SOCIAL_AWARENESS:700:1300:1400:1500:1600:1800:2500]"
MENTAL_ATTRIBUTE_CREATIVITY,
MENTAL_ATTRIBUTE_INTUITION,
MENTAL_ATTRIBUTE_SPATIAL_SENSE,
MENTAL_ATTRIBUTE_KINESTHETIC_SENSE,
MENTAL_ATTRIBUTE_EMPATHY,
    ]]
    lines[#lines+1]="[PERSONALITY:ANXIETY_PROPENSITY:0:0:0]"
    lines[#lines+1]="[PERSONALITY:DEPRESSION_PROPENSITY:0:0:0]"
    lines[#lines+1]="[PERSONALITY:BASHFUL:0:0:0]"
    lines[#lines+1]="[PERSONALITY:STRESS_VULNERABILITY:0:0:0]"
    lines[#lines+1]="[PERSONALITY:FRIENDLINESS:0:0:0]"
    lines[#lines+1]="[PERSONALITY:ASSERTIVENESS:100:100:100]"
    lines[#lines+1]="[PERSONALITY:DISDAIN_ADVICE:100:100:100]"
    lines[#lines+1]="[PERSONALITY:CHEER_PROPENSITY:0:0:0]"
    lines[#lines+1]="[PERSONALITY:GRATITUDE:0:0:0]"
    lines[#lines+1]="[PERSONALITY:TRUST:0:0:0]"
    lines[#lines+1]="[PERSONALITY:ALTRUISM:0:0:0]"
    lines[#lines+1]="[PERSONALITY:SWAYED_BY_EMOTIONS:0:0:0]"
    lines[#lines+1]="[PERSONALITY:CRUELTY:100:100:100]"
    --lines[#lines+1]="[PERSONALITY:PRIDE:100:100:100]"
    lines[#lines+1]="[PERSONALITY:HUMOR:100:100:100]"
    add_regular_tokens(lines,options)
    populate_sphere_info(lines,options)
    local rcp=get_random_creature_profile(options)
    add_body_size(lines,math.max(rcp.min_size,100000+trandom(11)*100000),options)
    lines[#lines+1]="[CREATURE_TILE:165]" --е
    options.custom_desc_func=function(options)
        return "{Їн} Їдержим{|а|Ї|ы} единственнЇй целью ─ уничтЇжить живых"
    end
    build_procgen_creature(rcp,lines,options)
    lines[#lines+1]="[GO_TO_START]"
    local name_str="кЇшмар:кЇшмары:кЇшмар]"
    lines[#lines+1]="[NAME:"..name_str
    lines[#lines+1]="[CASTE_NAME:"..name_str
    return {raws=lines,weight=1}
end

werebeast_origin_interactions={}

-- this takes options, but remember that these should be pure functions,
-- meaning that they have no side-effects. Don't put anything into options
-- in these functions! Only read from it. If you want to add to options
-- based on these functions, put it into a subordinate table to
-- the return table, it'll be incorporated in the generated temp function
-- (the default does this, so it's a fine example)
werebeast_origin_interactions.default=function(tok,name,options)
    -- just in case you want your werebeast to never generate like this
    if options.no_default_werebeast_curse then return {weight=0,interaction={}} end
    local lines={}
    -- ACTUAL CHANGE FROM 50.13 AND EARLIER: PREVIOUSLY, THESE WOULD BE "DEITY_CURSE_WEREBEAST_1" ETC
    -- WITH THIS THEY'RE "DEITY_CURSE_WEREBEAST_dragonfly" etc. (incl. the lowercase)
    -- THIS IS FINE BECAUSE WE ACTUALLY FILTER OUT RCPs NOW, WHICH IS ANOTHER CHANGE FROM V50
    local interaction_token="DEITY_CURSE_WEREBEAST_"..name.."_"..tostring(random_object_parameters.werebeast_count+1)
    lines[#lines+1]="[INTERACTION:"..interaction_token.."]"
    add_generated_info(lines)
    lines[#lines+1]="[I_SOURCE:DEITY]"
    lines[#lines+1]="[IS_USAGE_HINT:MAJOR_CURSE]"
    -- df-ru: оигуанЇїЇдЇбнЇе чудищеп; name ─ английский ключ їрЇфиля (Їн же в тЇкене выше)
    local ru_mon=RU.adj(RU.rcp(name).adj,"n").." чудище"
    lines[#lines+1]="[IS_HIST_STRING_1: їрЇклинает ]"
    lines[#lines+1]="[IS_HIST_STRING_2:: в каждЇе їЇлнЇлуние тЇт Їбращается в "..ru_mon
    lines[#lines+1]="[IS_TRIGGER_STRING_SECOND:несєте їрЇклятие]"
    lines[#lines+1]="[IS_TRIGGER_STRING_THIRD:несєт їрЇклятие]"
    lines[#lines+1]="[IS_TRIGGER_STRING:─ в каждЇе їЇлнЇлуние Їбращаться в "..ru_mon.."!"
    lines[#lines+1]="[I_TARGET:A:CREATURE]"
    lines[#lines+1]="[IT_LOCATION:CONTEXT_CREATURE]"
    lines[#lines+1]="[IT_REQUIRES:CAN_LEARN]"
    lines[#lines+1]="[IT_REQUIRES:HAS_BLOOD]"
    lines[#lines+1]="[IT_FORBIDDEN:NOT_LIVING]"
    lines[#lines+1]="[IT_FORBIDDEN:SUPERNATURAL]"
    lines[#lines+1]="[IT_CANNOT_HAVE_SYNDROME_CLASS:WERECURSE]"
    lines[#lines+1]="[IT_CANNOT_HAVE_SYNDROME_CLASS:VAMPCURSE]"
    lines[#lines+1]="[IT_CANNOT_HAVE_SYNDROME_CLASS:DISTURBANCE_CURSE]"
    lines[#lines+1]="[IT_CANNOT_HAVE_SYNDROME_CLASS:RAISED_UNDEAD]"
    lines[#lines+1]="[IT_CANNOT_HAVE_SYNDROME_CLASS:RAISED_GHOST]"
    lines[#lines+1]="[IT_CANNOT_HAVE_SYNDROME_CLASS:GHOUL]"
lines[#lines+1]="[I_EFFECT:ADD_SYNDROME]"
    lines[#lines+1]="[IE_TARGET:A]"
    lines[#lines+1]="[IE_IMMEDIATE]"
    lines[#lines+1]="[IE_ARENA_NAME:ОбЇрЇтень]"
    lines[#lines+1]="[SYNDROME]"
        lines[#lines+1]="[SYN_CLASS:WERECURSE]"
        lines[#lines+1]="[SYN_CONCENTRATION_ADDED:1000:0]"--just in case
        lines[#lines+1]="[CE_BODY_TRANSFORMATION:START:0:ABRUPT]"
        lines[#lines+1]="[CE:CREATURE:"..tok..":DEFAULT]"
        -- moon phase variety? not for default, surely
        -- (consider future cosmology stuff, too; should world push moon phase info into a lua table?)
        lines[#lines+1]="[CE:PERIODIC:MOON_PHASE:27:0]"
        lines[#lines+1]="[CE_ADD_TAG:NO_AGING:START:0:ABRUPT]"
    lines[#lines+1]="[INTERACTION:"..interaction_token.."_BITE]"
    add_generated_info(lines)
    lines[#lines+1]="[I_SOURCE:ATTACK]"
    lines[#lines+1]="[IS_HIST_STRING_1: кусает ]"
    lines[#lines+1]="[IS_HIST_STRING_2:, їередавая їрЇклятие "..RU.adj(RU.rcp(name).adj,"n","gen").." чудища"
    lines[#lines+1]="[I_TARGET:A:CREATURE]"
    lines[#lines+1]="[IT_LOCATION:CONTEXT_CREATURE]"
    lines[#lines+1]="[IT_REQUIRES:CAN_LEARN]"
    lines[#lines+1]="[IT_REQUIRES:HAS_BLOOD]"
    lines[#lines+1]="[IT_FORBIDDEN:NOT_LIVING]"
    lines[#lines+1]="[IT_FORBIDDEN:SUPERNATURAL]"
    lines[#lines+1]="[IT_CANNOT_HAVE_SYNDROME_CLASS:WERECURSE]"
    lines[#lines+1]="[IT_CANNOT_HAVE_SYNDROME_CLASS:VAMPCURSE]"
    lines[#lines+1]="[IT_CANNOT_HAVE_SYNDROME_CLASS:DISTURBANCE_CURSE]"
    lines[#lines+1]="[IT_CANNOT_HAVE_SYNDROME_CLASS:RAISED_UNDEAD]"
    lines[#lines+1]="[IT_CANNOT_HAVE_SYNDROME_CLASS:RAISED_GHOST]"
    lines[#lines+1]="[IT_CANNOT_HAVE_SYNDROME_CLASS:GHOUL]"
lines[#lines+1]="[I_EFFECT:ADD_SYNDROME]"
    lines[#lines+1]="[IE_TARGET:A]"
    lines[#lines+1]="[IE_IMMEDIATE]"
    lines[#lines+1]="[SYNDROME]"
        lines[#lines+1]="[SYN_CLASS:WERECURSE]"
        lines[#lines+1]="[SYN_CONCENTRATION_ADDED:1000:0]"--just in case
        lines[#lines+1]="[CE_BODY_TRANSFORMATION:START:16800:ABRUPT]" -- an easy-werebeasts mod could remove the delay... or would that make it harder? fascinating stuff
        lines[#lines+1]="[CE:CREATURE:"..tok..":DEFAULT]"
        lines[#lines+1]="[CE:PERIODIC:MOON_PHASE:27:0]"
        lines[#lines+1]="[CE_ADD_TAG:NO_AGING:START:0:ABRUPT]"
    return {raws=lines,weight=1,options={bite_interaction=interaction_token.."_BITE"}}
end

creatures.night_creature.werebeast.default=function(tok)
    local lines={}
    local options={
        spheres={
            CHAOS=true,
            ANIMALS=true,
            NIGHT=true,
            MOON=true
        },
        always_glowing_eyes=true,
        use_werebeast_pcg=true,
        animal_coloring_allowed=true,
        no_tweak=true,
        material_weakness=true,
        humanoidable_only=true,
        beast_only=true,
        prioritize_bite=true,
        token=tok
    }
    options.night_creature_agile_pref=true
    night_creature_universals(lines,options)
    lines[#lines+1]="[NIGHT_CREATURE_HUNTER]"
    lines[#lines+1]="[CAN_LEARN]"
    lines[#lines+1]="[CAN_SPEAK]"
    lines[#lines+1]="[NO_GENDER]"
    lines[#lines+1]="[BONECARN]"
    lines[#lines+1]="[CRAZED]"
    if options.night_creature_strength_pref then
        lines[#lines+1]="[PHYS_ATT_RANGE:STRENGTH:1000:1250:1500:2000:2250:2500:3000]"
        lines[#lines+1]="[PHYS_ATT_RANGE:AGILITY:450:550:700:750:800:850:900]"
        lines[#lines+1]="[PHYS_ATT_RANGE:TOUGHNESS:850:900:950:1000:1050:1100:1150]"
        lines[#lines+1]="[PHYS_ATT_RANGE:ENDURANCE:850:900:950:1000:1050:1100:1150]"
        options.special_walk_speed=1000
    elseif options.night_creature_agile_pref then
        lines[#lines+1]="[PHYS_ATT_RANGE:STRENGTH:450:550:700:750:800:850:900]"
        lines[#lines+1]="[PHYS_ATT_RANGE:AGILITY:1000:1250:1500:2000:2250:2500:3000]"
        lines[#lines+1]="[PHYS_ATT_RANGE:TOUGHNESS:850:900:950:1000:1050:1100:1150]"
        lines[#lines+1]="[PHYS_ATT_RANGE:ENDURANCE:850:900:950:1000:1050:1100:1150]"
        options.special_walk_speed=800;
    elseif options.night_creature_strength_agile_pref then
        lines[#lines+1]="[PHYS_ATT_RANGE:STRENGTH:1000:1150:1250:1500:2000:2250:2500]"
        lines[#lines+1]="[PHYS_ATT_RANGE:AGILITY:1000:1150:1250:1500:2000:2250:2500]"
        lines[#lines+1]="[PHYS_ATT_RANGE:TOUGHNESS:850:900:950:1000:1050:1100:1150]"
        lines[#lines+1]="[PHYS_ATT_RANGE:ENDURANCE:850:900:950:1000:1050:1100:1150]"
        options.special_walk_speed=850;
    end
    lines[#lines+1]="[PHYS_ATT_RANGE:RECUPERATION:450:1050:1150:1250:1350:1550:2250]"
    lines[#lines+1]="[PHYS_ATT_RANGE:DISEASE_RESISTANCE:700:1300:1400:1500:1600:1800:2500]"
    lines[#lines+1]="[MENT_ATT_RANGE:ANALYTICAL_ABILITY:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:FOCUS:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:WILLPOWER:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:PATIENCE:0:333:666:1000:2333:3666:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:MEMORY:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:LINGUISTIC_ABILITY:450:1050:1150:1250:1350:1550:2250]"
    lines[#lines+1]="[MENT_ATT_RANGE:MUSICALITY:0:333:666:1000:2333:3666:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:SOCIAL_AWARENESS:700:1300:1400:1500:1600:1800:2500]"
    --[[
MENTAL_ATTRIBUTE_CREATIVITY,
MENTAL_ATTRIBUTE_INTUITION,
MENTAL_ATTRIBUTE_SPATIAL_SENSE,
MENTAL_ATTRIBUTE_KINESTHETIC_SENSE,
MENTAL_ATTRIBUTE_EMPATHY,
    ]]
    --lines[#lines+1]="[PERSONALITY:ANXIETY_PROPENSITY:0:0:0]"
    --lines[#lines+1]="[PERSONALITY:DEPRESSION_PROPENSITY:0:0:0]"
    lines[#lines+1]="[PERSONALITY:BASHFUL:0:0:0]"
    lines[#lines+1]="[PERSONALITY:STRESS_VULNERABILITY:0:0:0]"
    lines[#lines+1]="[PERSONALITY:FRIENDLINESS:0:0:0]"
    --lines[#lines+1]="[PERSONALITY:ASSERTIVENESS:100:100:100]"
    lines[#lines+1]="[PERSONALITY:DISDAIN_ADVICE:100:100:100]"
    lines[#lines+1]="[PERSONALITY:CHEER_PROPENSITY:0:0:0]"
    lines[#lines+1]="[PERSONALITY:GRATITUDE:0:0:0]"
    lines[#lines+1]="[PERSONALITY:TRUST:0:0:0]"
    lines[#lines+1]="[PERSONALITY:ALTRUISM:0:0:0]"
    --lines[#lines+1]="[PERSONALITY:SWAYED_BY_EMOTIONS:0:0:0]"
    lines[#lines+1]="[PERSONALITY:CRUELTY:100:100:100]"
    --lines[#lines+1]="[PERSONALITY:PRIDE:100:100:100]"

    add_regular_tokens(lines,options)
    populate_sphere_info(lines,options)
    lines[#lines+1]="[NATURAL_SKILL:WRESTLING:6]"
    lines[#lines+1]="[NATURAL_SKILL:BITE:6]"
    lines[#lines+1]="[NATURAL_SKILL:GRASP_STRIKE:6]"
    lines[#lines+1]="[NATURAL_SKILL:STANCE_STRIKE:6]"
    lines[#lines+1]="[NATURAL_SKILL:MELEE_COMBAT:6]"
    lines[#lines+1]="[NATURAL_SKILL:DODGING:6]"
    lines[#lines+1]="[NATURAL_SKILL:SITUATIONAL_AWARENESS:6]"
    lines[#lines+1]="[NATURAL_SKILL:SNEAK:20]"

    lines[#lines+1]="[DIFFICULTY:3]"
    lines[#lines+1]="[LAIR:SIMPLE_BURROW:50]"
    local ropar=random_object_parameters
    ropar.werebeast_blacklist=ropar.werebeast_blacklist or {}
    ropar.werebeast_count=ropar.werebeast_count or 0
    local rcp=get_random_creature_profile(options,ropar.werebeast_blacklist)
    if rcp.type=="GENERAL_BLOB" then
        ropar.werebeast_count=ropar.werebeast_count+1
        ropar.werebeast_blacklist={}
        rcp=get_random_creature_profile(options)
    end
    ropar.werebeast_blacklist[rcp.type]=true
    -- This sort of process should be fully generalized
    -- to all creatures you want to have bespoke associated interactions
    -- for example, you can have a blessing that allows a sort of
    -- uncrazed transformation into some sort of bespoke
    -- generated thing--at least, hopefully it's robust enough for that
    local choice=generate_from_list(werebeast_origin_interactions,tok,rcp.name_string,options)
    map_merge(options,choice.options)
    local werebeast_choice_raws=choice.interaction or choice.raws
    raws.register_interactions(werebeast_choice_raws)
    add_body_size(lines,math.max(rcp.min_size,80000+trandom(11)*1000),options)
    lines[#lines+1]="[CREATURE_TILE:165]" --е
    options.forced_color={
        f=6,
        b=0,
        br=1
    }
    options.custom_desc_func=function(options)
        return "{Їн} Їбезумел{|а|Ї|и} Їт жажды крЇви и їлЇти"
    end
    build_procgen_creature(rcp,lines,options)
    lines[#lines+1]="[GO_TO_START]"
    local ru_r=RU.rcp(rcp.name_string)
    local name_str=ru_r.sg.."-ЇбЇрЇтень:"..ru_r.pl.."-ЇбЇрЇтни:"..ru_r.sg.."-ЇбЇрЇтень]"
    lines[#lines+1]="[NAME:"..name_str
    lines[#lines+1]="[CASTE_NAME:"..name_str
    return {raws=lines,weight=1}
end

function experiment_tokens(lines,options)
    lines[#lines+1]="[NO_DRINK][NO_EAT][NO_SLEEP]"
    lines[#lines+1]="[LARGE_PREDATOR]"
    lines[#lines+1]="[NIGHT_CREATURE]"
    lines[#lines+1]="[SUPERNATURAL]"
    lines[#lines+1]="[FANCIFUL]"
    if not one_in(4) and random_object_parameters.experimenter_creature then
        if random_object_parameters.experimenter_creature.flags.MATES_TO_BREED then
            lines[#lines+1]="[CASTE:FEMALE]"
                lines[#lines+1]="[FEMALE]"
            lines[#lines+1]="[CASTE:MALE]"
                lines[#lines+1]="[MALE]"
            lines[#lines+1]="[SELECT_CASTE:ALL]"
        else
            lines[#lines+1]="[NO_GENDER]"
        end
    else
        lines[#lines+1]="[NO_GENDER]"
    end
    lines[#lines+1]="[BIOME:ANY_LAND]"
    lines[#lines+1]="[PETVALUE:2000]"
    lines[#lines+1]="[ALL_ACTIVE]"
    lines[#lines+1]="[NOFEAR]"
    lines[#lines+1]="[NO_FEVERS]"
    options.spheres=options.spheres or {
        NIGHT=true,
        DEFORMITY=true
    }
    options.never_uniform=true
    options.experiment_colors=true
    options.forced_color={ -- overridden by humanoid, but that's fine
            f=2,
            b=0,
            br=1
        }
    options.experiment_attack_tweak=true
    options.sickness_name="нЇчная хвЇрь"
    options.pref_str=options.pref_str or {"тревЇжнЇе їрЇисхЇждение"}
--[[
************************** EXPERIMENT OBJECT def - desc phys/affect
	they expect the amalgamated giants to refer to all the pieces making them up -- do we do tissues differently though?  go all muscle?
		but don't actually give them tissues
]]
    options.no_extra_description=true
    options.cannot_swim=true
end

function experimenter_sphere_info(lines,options)
    local ropar=random_object_parameters
    if ropar.experimenter_creature then
        if ropar.experimenter_creature.caste[ropar.experimenter_hf.caste].flags.UNIQUE_DEMON then
            -- ?. would be pretty cool, alas
            local spheres = ropar.experimenter_hf.profile and ropar.experimenter_hf.profile.mpp and ropar.experimenter_hf.profile.mpp.spheres
            if spheres then
                return spheres.CHAOS,spheres.DEFORMITY
            end
        end
    end
    return false,false
end

function experiment_description(lines,options)
    local ropar=random_object_parameters
    local end_str=""
    local add_desc=function(str) end_str=end_str..str end
    -- df-ru: оЭтЇ нЇчнЇе существЇ вїервые сЇзданЇ (случайнЇ) в хЇде чудЇвищных ЇїытЇв в 125 гЇду.
    -- СЇздатель ─ гЇблинский некрЇмант Урист (Сибрек). Жертвы ─ люди. МестЇ сЇздания ─ МЇрул.п (без їадежей имєн)
    local function trim(s) return ((s or ""):gsub("%s+$","")) end
    if ropar.experimenter_hf then
        local chaos,deformity=experimenter_sphere_info(lines,options)
        add_desc(" ЭтЇ нЇчнЇе существЇ былЇ вїервые ")
        if options.failed_experiment then
            add_desc("случайнЇ ")
        end
        add_desc("сЇзданЇ")
        if deformity and chaos then
            add_desc(" ужасающей силЇй исчадия")
        elseif deformity then
            add_desc(" извращєннЇй силЇй исчадия")
        elseif chaos then
            add_desc(" хаЇтическЇй силЇй исчадия")
        else
            add_desc(" в хЇде чудЇвищных ЇїытЇв")
            if options.failed_experiment then
                add_desc(", їЇшедших не так,")
            end
        end
        add_desc(" в "..tostring(world.year).." гЇду. СЇздатель ─ ")
        local ip = ropar.experimenter_hf.profile and ropar.experimenter_hf.profile.interaction_profile
        if ip and ip.uwss_display_name_sing~="" then
            add_desc(RU.np(trim(ropar.experimenter_race_adj),ip.uwss_display_name_sing,"m"))
        else
            add_desc(ropar.experimenter_race_name)
        end
        add_desc(" ")
        add_desc(ropar.experimenter_hf.name.translated)
        if ropar.experimenter_capital_st then
            add_desc(" ("..ropar.experimenter_capital_st.name.translated..")")
        end
        add_desc(".")
        if ropar.experimenter_source_hfid~=-1 or ropar.experimenter_source_race~=-1 then
            add_desc((deformity or chaos) and " На кЇгЇ Їбрушилась эта сила ─ " or " Жертвы ЇїытЇв ─ ")
            if options.amalgam_experiment then add_desc("мнЇжествЇ существ")
            elseif ropar.experimenter_source_hfid~=-1 then
                if ropar.experiment_hf then
                    local ip = ropar.experiment_hf.profile and ropar.experiment_hf.profile.interaction_profile
                    if ip then
                        add_desc(RU.np(trim(ropar.experiment_source_race_adj),ip.uwss_display_name_sing,"m"))
                    else
                        add_desc(ropar.experiment_source_race_name)
                    end
                    add_desc(" ")
                    add_desc(ropar.experiment_hf.name.translated)
                else add_desc("неизвестнЇе существЇ")
                end
            elseif ropar.experimenter_source_race~=-1 then
                add_desc(ropar.experiment_source_race_name_plural)
            end
            add_desc(".")
        end
        if ropar.experimenter_create_st then
            add_desc(" МестЇ сЇздания ─ "..ropar.experimenter_create_st.name.translated..".")
        end
    end
    return end_str
end

-- you can add more of your own, e.g. experiment_nouns.cyborg or whatever
experiment_nouns={
    humanoid={
        {"длань","длани"},
        {"демЇн","демЇны"},
        {"вЇин","вЇины"},
        {"сЇлдат","сЇлдаты"},
        {"кулак","кулаки"},
        {"ЇкЇ","Їчи"},
    },
    humanoid_giant={
        {"великан","великаны"},
        {"грЇмадина","грЇмадины"},
        {"башня","башни"},
        {"гЇра","гЇры"},
    },
    beast_small={
        {"їєс","їсы"},
        {"гЇнчая","гЇнчие"},
        {"вЇлк","вЇлки"},
    },
    beast_large={
        {"зверь","звери"},
        {"чудище","чудища"},
        {"тварь","твари"},
    },
    failed_small={
        {"Їшибка","Їшибки"},
        {"безумие","безумия"},
        {"Їїыт","Їїыты"},
    },
    failed_large={
        {"кЇшмар","кЇшмары"},
        {"катастрЇфа","катастрЇфы"},
        {"бедствие","бедствия"},
    }
}

experiment_random_names={
    --originally just a straight assignment, wanted to take the opportunity to let mods add variety
    deformity_chaos={"ужаса"},
    deformity={"несчастья"},
    chaos={"хаЇса"},
    night={"нЇчи"}
}

function experiment_name_token(lines,options)
    lines[#lines+1]="[GO_TO_START]"
    local ropar = random_object_parameters
    local name_to_use=ropar.experimenter_hf and ropar.experimenter_hf.name
    if one_in(4) then
        if one_in(2) then name_to_use=ropar.experimenter_create_st and ropar.experimenter_create_st.name or name_to_use
        else name_to_use=ropar.experimenter_capital_st and ropar.experimenter_capital_st.name or name_to_use
        end
    end
    local experiment_name=nil
    if name_to_use then
        -- we preprocess these indices for lua--i know it's inconsistent, sorry
        if string.len(name_to_use.firstname)>0 and ((not name_to_use.translated_epithet_the and not name_to_use.translated_epithet_compound) or one_in(2)) then
            experiment_name=name_to_use.firstname
            experiment_name=RU.gen(capitalize_string_words(experiment_name)) -- df-ru: рЇд. ї.
        else
            if name_to_use.translated_epithet_the and (one_in(2) or not name_to_use.translated_epithet_compound) then
                -- "of The Murk"
                if one_in(2) then experiment_name=translated_epithet_the
                else experiment_name=native_epithet_the
                end
            elseif name_to_use.translated_epithet_compound then
                -- "of Tireshadows"
                if one_in(2) then experiment_name=translated_epithet_compound
                else experiment=native_epithet_compound
                end
            end
        end
    end
    if not experiment_name or one_in(10) then
        local chaos,deformity=experimenter_sphere_info(lines,options)
        if deformity and chaos then experiment_name=pick_random(experiment_random_names.deformity_chaos)
        elseif deformity then experiment_name=pick_random(experiment_random_names.deformity)
        elseif chaos then experiment_name=pick_random(experiment_random_names.chaos)
        else experiment_name=pick_random(experiment_random_names.night)
        end
    end
    options.experiment_name_type = options.experiment_name_type or ropar.making_experiment
    local nmm,pnmm=table.unpack(pick_random(experiment_nouns[options.experiment_name_type]))
    local full_name_str
    -- df-ru: оX's handп и оhand of Xп ─ Їба одлань Уристап
    if one_in(2) then
        local possessive=" "..experiment_name
        full_name_str=nmm..possessive..":"..pnmm..possessive..":"..nmm..possessive
    else
        local possessive=" "..experiment_name
        full_name_str=nmm..possessive..":"..pnmm..possessive..":"..nmm..possessive
    end
    lines[#lines+1]="[NAME:"..full_name_str.."]"
    lines[#lines+1]="[CASTE_NAME:"..full_name_str.."]"
end

creatures.experiment.humanoid.default=function(tok)
    local lines={}
    local options={
        token=tok,
        normal_biological=true
    }
    if one_in(2) then
        options.night_creature_strength_pref=true
    else
        options.night_creature_agile_pref=true
    end
    lines[#lines+1]="[CAN_LEARN]"
    lines[#lines+1]="[LOCAL_POPS_CONTROLLABLE]"
    lines[#lines+1]="[LOCAL_POPS_PRODUCE_HEROES]"
--[[************************** EXPERIMENT OBJECT personality + desc
        --do a few archetypes that'll be appended to the description
    lines[#lines+1]="[PERSONALITY:ANXIETY_PROPENSITY:0:0:0]"
    lines[#lines+1]="[PERSONALITY:DEPRESSION_PROPENSITY:0:0:0]"
    lines[#lines+1]="[PERSONALITY:BASHFUL:0:0:0]"
    lines[#lines+1]="[PERSONALITY:STRESS_VULNERABILITY:0:0:0]"
    lines[#lines+1]="[PERSONALITY:FRIENDLINESS:0:0:0]"
    lines[#lines+1]="[PERSONALITY:ASSERTIVENESS:100:100:100]"
    lines[#lines+1]="[PERSONALITY:DISDAIN_ADVICE:100:100:100]"
    lines[#lines+1]="[PERSONALITY:CHEER_PROPENSITY:0:0:0]"
    lines[#lines+1]="[PERSONALITY:GRATITUDE:0:0:0]"
    lines[#lines+1]="[PERSONALITY:TRUST:0:0:0]"
    lines[#lines+1]="[PERSONALITY:ALTRUISM:0:0:0]"
    lines[#lines+1]="[PERSONALITY:SWAYED_BY_EMOTIONS:0:0:0]"
    lines[#lines+1]="[PERSONALITY:CRUELTY:100:100:100]"
    lines[#lines+1]="[PERSONALITY:PRIDE:100:100:100]"
    lines[#lines+1]="[PERSONALITY:GREED:100:100:100]"
]]
    lines[#lines+1]="[CAN_SPEAK]"
    options.can_learn=true
    lines[#lines+1]="[BODY_APPEARANCE_MODIFIER:HEIGHT:90:95:98:100:102:105:110]"
    lines[#lines+1]="[BODY_APPEARANCE_MODIFIER:BROADNESS:90:95:98:100:102:105:110]"
    if options.night_creature_strength_pref then
        lines[#lines+1]="[PHYS_ATT_RANGE:STRENGTH:1000:1250:1500:2000:2250:2500:3000]"
        lines[#lines+1]="[PHYS_ATT_RANGE:AGILITY:450:550:700:750:800:850:900]"
        lines[#lines+1]="[PHYS_ATT_RANGE:TOUGHNESS:850:900:950:1000:1050:1100:1150]"
        lines[#lines+1]="[PHYS_ATT_RANGE:ENDURANCE:850:900:950:1000:1050:1100:1150]"
        options.special_walk_speed=1000;
    elseif options.night_creature_agile_pref then
        lines[#lines+1]="[PHYS_ATT_RANGE:STRENGTH:450:550:700:750:800:850:900]"
        lines[#lines+1]="[PHYS_ATT_RANGE:AGILITY:1000:1250:1500:2000:2250:2500:3000]"
        lines[#lines+1]="[PHYS_ATT_RANGE:TOUGHNESS:850:900:950:1000:1050:1100:1150]"
        lines[#lines+1]="[PHYS_ATT_RANGE:ENDURANCE:850:900:950:1000:1050:1100:1150]"
        options.special_walk_speed=800;
    end
    lines[#lines+1]="[PHYS_ATT_RANGE:RECUPERATION:450:1050:1150:1250:1350:1550:2250]"
    lines[#lines+1]="[PHYS_ATT_RANGE:DISEASE_RESISTANCE:700:1300:1400:1500:1600:1800:2500]"
    lines[#lines+1]="[MENT_ATT_RANGE:ANALYTICAL_ABILITY:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:FOCUS:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:WILLPOWER:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:PATIENCE:0:333:666:1000:2333:3666:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:MEMORY:1250:1500:1750:2000:2500:3000:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:LINGUISTIC_ABILITY:450:1050:1150:1250:1350:1550:2250]"
    lines[#lines+1]="[MENT_ATT_RANGE:MUSICALITY:0:333:666:1000:2333:3666:5000]"
    lines[#lines+1]="[MENT_ATT_RANGE:SOCIAL_AWARENESS:700:1300:1400:1500:1600:1800:2500]"
    experiment_tokens(lines,options)
    populate_sphere_info(lines,options)
    local rcp={
        type="GENERAL_HUMANOID",
		name_string="humanoid",
		tile='H',
		body_base="HUMANOID",
        --FOR SKIN/ORGANS AND NO HAIR/FEATHERS AT FIRST
		c_class="AMPHIBIAN",
		min_size=1,
        cannot_have_shell=true
    }
    add_body_size(lines,50000+trandom(4)*10000+trandom(11)*1000,options)
    lines[#lines+1]="[CREATURE_TILE:72]"
    options.forced_color={
        f=4,
        b=0,
        br=1
    }
    options.end_phrase=experiment_description(lines,options)
    options.experiment_layering=true
    build_procgen_creature(rcp,lines,options)
    experiment_name_token(lines,options)
    return {raws=lines,weight=1}
end

creatures.experiment.humanoid_giant.default=function(tok)
    local lines={}
    local options={
        amalgam_experiment=true,
        token=tok,
        normal_biological=true
    }
    if one_in(2) then
        options.night_creature_strength_pref=true
    else
        options.night_creature_agile_pref=true
    end
    lines[#lines+1]="[BODY_APPEARANCE_MODIFIER:HEIGHT:90:95:98:100:102:105:110]";
    lines[#lines+1]="[BODY_APPEARANCE_MODIFIER:BROADNESS:90:95:98:100:102:105:110]";
    experiment_tokens(lines,options)
    populate_sphere_info(lines,options)
    local rcp={
        type="GENERAL_HUMANOID",
		name_string="humanoid",
		tile='H',
		body_base="HUMANOID",
		c_class="FLESHY",
		min_size=1,
        cannot_have_shell=true
    }
    add_body_size(lines,5000000+trandom(4)*1000000+trandom(11)*100000,options)
    lines[#lines+1]="[CREATURE_TILE:165]"
    options.end_phrase=experiment_description(lines,options)
    build_procgen_creature(rcp,lines,options)
    experiment_name_token(lines,options)
    return {raws=lines,weight=1}
end

beast_experiment_rcps={
    {
        name_string="quadruped",
        tile='Q',
        body_base="QUADRUPED",
        maybe_slinky=true
    },
    {
        name_string="hexapod",
        tile='H',
        body_base="INSECT"
    },
    {
        name_string="spider",
        tile='S',
        body_base="SPIDER"
    },
    {
        name_string="scorpion",
        tile='S',
        body_base="SPIDER",
        must_have_pincers=true,
        must_have_scorpion_tail=true
    },
    {
        name_string="decapod",
        tile='D',
        body_base="TEN_LEGGED"
    },
    {
        name_string="octopod",
        tile='O',
        body_base="EIGHT_LEGGED"
    },
    {
        name_string="primate",
        tile='P',
        body_base="QUADRUPED_FRONT_GRASP"
    },
}

function make_beast_rcp(lines,options)
    local rcp={
        type="GENERAL_QUADRUPED",
        c_class="FLESHY",
        min_size=1,
        cannot_have_shell=true,
        cannot_have_get_more_legs=true
    }
    map_merge(rcp,pick_random(beast_experiment_rcps))
    if rcp.maybe_slinky then
        rcp.maybe_slinky=nil
        if one_in(2) then rcp.SLINKY_QUADRUPED=true end
    end
    return rcp
end

creatures.experiment.beast_small.default=function(tok)
    local lines={}
    local options={
        token=tok,
        normal_biological=true
    }
    if one_in(2) then
        options.night_creature_strength_pref=true
    else
        options.night_creature_agile_pref=true
    end
    lines[#lines+1]="[BODY_APPEARANCE_MODIFIER:LENGTH:90:95:98:100:102:105:110]";
    lines[#lines+1]="[BODY_APPEARANCE_MODIFIER:HEIGHT:90:95:98:100:102:105:110]";
    lines[#lines+1]="[BODY_APPEARANCE_MODIFIER:BROADNESS:90:95:98:100:102:105:110]";
    experiment_tokens(lines,options)
    populate_sphere_info(lines,options)
    local rcp=make_beast_rcp(lines,options)
    add_body_size(lines,50000+trandom(4)*10000+trandom(11)*1000,options)
    lines[#lines+1]="[CREATURE_TILE:"..rcp.tile.."]"
    options.end_phrase=experiment_description(lines,options)
    build_procgen_creature(rcp,lines,options)
    experiment_name_token(lines,options)
    return {raws=lines,weight=1}
end

creatures.experiment.beast_large.default=function(tok)
    local lines={}
    local options={
        token=tok,
        normal_biological=true

    }
    if one_in(2) then
        options.night_creature_strength_pref=true
    else
        options.night_creature_agile_pref=true
    end
    lines[#lines+1]="[BODY_APPEARANCE_MODIFIER:LENGTH:90:95:98:100:102:105:110]";
    lines[#lines+1]="[BODY_APPEARANCE_MODIFIER:HEIGHT:90:95:98:100:102:105:110]";
    lines[#lines+1]="[BODY_APPEARANCE_MODIFIER:BROADNESS:90:95:98:100:102:105:110]";
    experiment_tokens(lines,options)
    populate_sphere_info(lines,options)
    local rcp=make_beast_rcp(lines,options)
    add_body_size(lines,500000+trandom(4)*100000+trandom(11)*10000,options)
    lines[#lines+1]="[CREATURE_TILE:"..rcp.tile.."]"
    options.end_phrase=experiment_description(lines,options)
    build_procgen_creature(rcp,lines,options)
    experiment_name_token(lines,options)
    return {raws=lines,weight=1}
end

failed_experiment_rcps={
    {
        name_string="blob",
        tile='b',
        body_base="AMORPHOUS",
    },
    {
        name_string="maggot",
        tile='m',
        body_base="INSECT_LARVA",
    },
    {
        name_string="worm",
        tile='w',
        body_base="WORM",
    },
    {
        name_string="wyrm",
        tile='w',
        body_base="NO_LIMB",
    },
    {
        name_string="snake",
        tile='s',
        body_base="SNAKE",
    },
    {
        name_string="armless biped",
        tile='b',
        body_base="TWO_LEGS_NO_ARMS_HUMANOID",
        always_flightless=true
    },
}

function make_failed_rcp(lines,options)
    local rcp={
        type="BLOB",
        c_class="FLESHY",
        min_size=1,
        cannot_have_shell=true,
    }
    map_merge(rcp,pick_random(failed_experiment_rcps))
    if options.is_large then rcp.tile=string.upper(rcp.tile) end
    return rcp
end

creatures.experiment.failed_small.default=function(tok)
    local lines={}
    local options={
        failed_experiment=true,
        token=tok,
        normal_biological=true
    }
    if one_in(2) then
        options.night_creature_strength_pref=true
    else
        options.night_creature_agile_pref=true
    end
    experiment_tokens(lines,options)
    populate_sphere_info(lines,options)
    local rcp=make_beast_rcp(lines,options)
    add_body_size(lines,50000+trandom(4)*10000+trandom(11)*1000,options)
    lines[#lines+1]="[CREATURE_TILE:"..rcp.tile.."]"
    options.end_phrase=experiment_description(lines,options)
    build_procgen_creature(rcp,lines,options)
    experiment_name_token(lines,options)
    return {raws=lines,weight=1}
end

creatures.experiment.failed_large.default=function(tok)
    local lines={}
    local options={
        is_large=true,
        failed_experiment=true,
        token=tok,
        normal_biological=true
    }
    if one_in(2) then
        options.night_creature_strength_pref=true
    else
        options.night_creature_agile_pref=true
    end
    experiment_tokens(lines,options)
    populate_sphere_info(lines,options)
    local rcp=make_beast_rcp(lines,options)
    add_body_size(lines,500000+trandom(4)*100000+trandom(11)*10000,options)
    lines[#lines+1]="[CREATURE_TILE:"..rcp.tile.."]"
    options.end_phrase=experiment_description(lines,options)
    build_procgen_creature(rcp,lines,options)
    experiment_name_token(lines,options)
    return {raws=lines,weight=1}
end

sphere_flavor={
    AGRICULTURE={add="{Їн} тЇ и делЇ смЇтрит в небЇ, Їжидая дЇждя"},
    ANIMALS={add="{Їн} рычит, жужжит, щєлкает и вЇЇбще издаєт самый разный шум"},
    ART={add="{Їн} їЇкрыт{|а|Ї|ы} замыслЇватыми узЇрами"},
    BALANCE={add="{Їн} идеальнЇ симметрич{ен|на|нЇ|ны}"},
    BEAUTY={add="{Їн} їЇразительнЇ красив{|а|Ї|ы}"},
    BIRTH={add="{Їн} їЇкрыт{|а|Ї|ы} тЇнкЇй їлєнкЇй ЇкЇлЇїлЇднЇгЇ їузыря"},
    BLIGHT={add="растения рядЇм с {ним} слЇвнЇ съєживаются"},
    BOUNDARIES={add="части {егЇ} тела аккуратнЇ разделены Їтметинами"},
    CAVERNS={add="{егЇ} стЇны Їтдаются эхЇм, где бы {Їн} ни нахЇдил{ся|ась|Їсь|ись}"},
    CHAOS={add="{Їн} бешенЇ вертится, шатаясь и завывая"},
    CHARITY={add="{Їн} кажется Їчень їриятн{ым|Їй|ым|ыми}"},
    CHILDREN={add="{Їн} не уїускает случая їЇїрыгать їЇ лужам"},
    COASTS={add="{Їн} слЇвнЇ їЇкрыт{|а|Ї|ы} скалистыми утєсами"},
    CONSOLATION={add="{Їн} излучает їечальную дЇбрЇту"},
    COURAGE={add="рядЇм с {ним} все чувствуют себя храбрее"},
    CRAFTS={add="{Їн} выглядит рукЇтвЇрн{ым|Їй|ым|ыми}"},
    CREATION={add="вЇкруг {негЇ} будтЇ сами сЇбЇй вЇзникают мелкие їредметы"},
    DANCE={add="{Їн} кружится, їЇдскакивает и їрыгает їри каждЇм движении"},
    DARKNESS={add="{егЇ} труднЇ разглядеть даже їри яркЇм свете"},
    DAWN={add="{Їн} всегда ЇбЇрачивается, чтЇбы їриветствЇвать вЇсхЇд сЇлнца"},
    DAY={add="{Їн} їриятнЇ наїевает, кЇгда сЇлнце стЇит высЇкЇ"},
    DEATH={add="{Їн} выдыхает с хриїЇм"},
    DEFORMITY={add="{егЇ} телЇ искривленЇ и урЇдливЇ"},
    DEPRAVITY={add="у {негЇ} неудержимЇ текут слюни"},
    DISCIPLINE={add="{Їн} движется с бЇльшЇй сЇсредЇтЇченнЇстью"},
    DISEASE={add="{Їн} їЇкрыт{|а|Ї|ы} злЇвЇнными гнЇйниками",odor="смерть"},
    DREAMS={add="черты {егЇ} Їблика легкЇ забываются, если не сЇсредЇтЇчиться"},
    DUSK={add="{Їн} никЇгда не смЇтрит на сЇлнце"},
    DUTY={add="кЇгда {Їн} не действует намереннЇ, {Їн} сЇвершеннЇ неїЇдвиж{ен|на|нЇ|ны}"},
    EARTH={add="{Їн} выглядит Їчень креїк{им|Їй|им|ими} и кЇренаст{ым|Їй|ым|ыми}"},
    FAMILY={add="{Їн} кажется близк{им|Їй|им|ими} рЇдств{енникЇм|енницей|енникЇм|енниками} всех себе їЇдЇбных"},
    FAME={add="куда бы {Їн} ни шєл, {егЇ} сЇїрЇвЇждают фанфары"},
    FATE={add="кажется, ничтЇ не сїЇсЇбнЇ {егЇ} встревЇжить или удивить"},
    FERTILITY={add="{Їн} выглядит Їчень здЇрЇв{ым|Їй|ым|ыми}"},
    FESTIVALS={add="{Їн} їЇдїрыгивает и кружится на хЇду"},
    FIRE={add="Їкружающее {егЇ} сияние слЇвнЇ всегда їЇднимается вверх"},
    FISH={add="{Їн} выглядит дЇвЇльн{ым|Їй|ым|ыми}, тЇлькЇ кЇгда {Їн} в вЇде"},
    FISHING={add="{Їн} всегда ЇстЇрЇжнЇ їередвигается у вЇды"},
    FOOD={add="Їт {негЇ} вЇсхитительнЇ їахнет свежей выїечкЇй",odor="свежая выїечка"},
    FORGIVENESS={add="рядЇм с {ним} невЇзмЇжнЇ держать зла"},
    FORTRESSES={add="{Їн} выглядит Їчень їрЇчн{ым|Їй|ым|ыми}"},
    FREEDOM={add="{Їн} ЇхЇтнЇ їерехЇдит с места на местЇ"},
    GAMBLING={add="{Їн} тЇ и делЇ меняет Їдин цвет на другЇй"},
    GAMES={add="{Їн} тЇ и делЇ хихикает"},
    GENEROSITY={add="рядЇм с {ним} хЇчется раздать всє свЇє имуществЇ"},
    HAPPINESS={add="кажется, {Їн} їЇстЇяннЇ улыбается"},
    HEALING={add="{егЇ} Їкружает мягкая атмЇсфера"},
    HOSPITALITY={add="Їт {негЇ} исхЇдит радушие"},
    HUNTING={add="на хЇду {Їн} їристальнЇ изучает землю"},
    INSPIRATION={add="їЇ {егЇ} їЇверхнЇсти тЇ и делЇ їрЇбегают всїышки энергии"},
    JEALOUSY={add="{Їн} кажется Їчень ЇзлЇбленн{ым|Їй|ым|ыми} существЇм"},
    JEWELS={add="всє {егЇ} телЇ симметричнЇ ЇграненЇ"},
    JUSTICE={add="{Їн} будтЇ тЇлькЇ и ждєт, чтЇбы вынести кЇму-нибудь їригЇвЇр"},
    LABOR={add="{Їн} Їчень ЇбдуманнЇ сЇвершает каждЇе действие"},
    LAKES={add="{Їн} движется грузнЇ и медленнЇ"},
    LAWS={add="у {негЇ} Їчень сурЇвый вид"},
    LIES={add="если не вдумываться, {Їн} кажется безуїречнЇ честн{ым|Їй|ым|ыми}"},
    LIGHT={add="{Їн} Їтражает Їкружающий свет с нЇвЇй яркЇстью и силЇй"},
    LIGHTNING={add="{Їн} їЇтрескивает Їт энергии"},
    LONGEVITY={add="кажется, {Їн} всегда смЇтрит куда-тЇ вдаль"},
    LOVE={add="{Їн} тЇскливЇ глядит на тех, ктЇ рядЇм"},
    LOYALTY={add="{Їн} никЇгда не брЇсает свЇих сїутникЇв"},
    LUCK={add="время Їт времени {Їн} внезаїнЇ меняет наїравление"},
    LUST={add="у {негЇ} їугающе їристальный взгляд"},
    MARRIAGE={add="{Їн} дЇнимает всех встречных, ктЇ не сЇстЇит в браке"},
    MERCY={add="кажется, {Їн} вЇт-вЇт заїлачет"},
    METALS={add="на мнЇгих частях {егЇ} тела будтЇ бы мерцают Їстрые грани"},
    MINERALS={add="у {негЇ} углЇватый Їблик"},
    MISERY={add="{Їн} издаєт на редкЇсть унылые стЇны"},
    MIST={add="{егЇ} труднЇ яснЇ разглядеть"},
    MOON={add="{Їн} меняет цвет с фазами луны"},
    MOUNTAINS={add="{Їн} Їчень ЇснЇвательнЇ слЇжен{|а|Ї|ы}"},
    MUCK={add="Їт {негЇ} исхЇдит мерзкая вЇнь"},
    MURDER={add="{Їн} не вынЇсит ничегЇ живЇгЇ"},
    MUSIC={add="їри движении {егЇ} телЇ в такт издаєт чистые звуки"},
    NATURE={add="увереннее всегЇ {Їн} чувствует себя їЇд Їткрытым небЇм"},
    NIGHT={add="{Їн} жуткЇватЇ Їтражает свет звєзд и луны"},
    NIGHTMARES={add="{егЇ} вид наїЇминает смЇтрящим Їб их самых неїриятных вЇсїЇминаниях"},
    OATHS={add="{Їн} не мЇжет їрямЇ смЇтреть на тЇгЇ, ктЇ нарушил клятву"},
    OCEANS={add="{Їн} всегда тянет часть тела к луне"},
    ORDER={add="{Їн} движется Їчень скЇваннЇ"},
    PAINTING={add="їЇ {егЇ} їЇверхнЇсти всегда свежЇ играют краски"},
    PEACE={add="{Їн} неверЇятнЇ сїЇкЇен{|а|Ї|ы}"},
    PERSUASION={add="{Їн} раскачивается взад-вїерєд всякий раз, кЇгда ктЇ-тЇ їри {нєм} меняет мнение"},
    PLANTS={add="кЇгда сЇлнце на небе, {Їн} будтЇ всегда тянется к нему"},
    POETRY={add="инЇгда {Їн} читает стихи на страннЇм языке"},
    PREGNANCY={add="{Їн} будтЇ бы в їЇлЇжении"},
    RAIN={add="{Їн} Їставляет вЇду всюду, где їрЇхЇдит"},
    RAINBOWS={add="{Їн} їЇразительнЇ яркЇ Їкрашен{|а|Ї|ы}"},
    REBIRTH={add="{Їн} мгнЇвеннЇ їерехЇдит Їт вялЇсти к бурнЇй живЇсти и ЇбратнЇ"},
    REVELRY={add="{Їн} движется в їЇдїрыгивающем ритме"},
    REVENGE={add="в разгЇвЇре у {негЇ} неїЇдвижный, немигающий взгляд"},
    RIVERS={add="{егЇ} внешний їЇкрЇв слЇвнЇ струится їЇ телу"},
    RULERSHIP={add="{егЇ} труднЇ Їслушаться"},
    RUMORS={add="{Їн} всегда ЇхЇтнЇ кивает, кЇгда ктЇ-тЇ гЇвЇрит"},
    SACRIFICE={add="{Їн} вдЇхнЇвляет Їкружающих на великие жертвы"},
    SALT={add="из-за {негЇ} вЇда їЇблизЇсти станЇвится неїригЇднЇй для їитья"},
    SCHOLARSHIP={add="кажется, {Їн} всегда їЇгружен{|а|Ї|ы} в раздумья"},
    SEASONS={add="{егЇ} Їблик неїрестаннЇ меняется"},
    SILENCE={add="{Їн} не издаєт ни звука"},
    SKY={add="їЇ {егЇ} їЇверхнЇсти медленнЇ їлывєт узЇр"},
    SONG={add="{Їн} без кЇнца їЇєт їрекрасные їесни"},
    SPEECH={add="{Їн} внимательнЇ слушает всякЇгЇ, ктЇ гЇвЇрит"},
    STARS={add="с настуїлением нЇчи {Їн} слЇвнЇ искрится"},
    STORMS={add="{егЇ} движения звучат как ветер и дЇждь"},
    STRENGTH={add="{Їн} выглядит креїкЇ слЇженн{ым|Їй|ым|ыми}"},
    SUICIDE={add="{Їн} бЇрмЇчет себе їЇд нЇс Ї смерти"},
    SUN={add="на {негЇ} труднЇ смЇтреть їрямЇ"},
    THEFT={add="{егЇ} внимание всегда їрикЇванЇ к самЇй ценнЇй вещи їЇблизЇсти"},
    THRALLDOM={add="{егЇ} движения звучат как звЇн цеїей"},
    THUNDER={add="{Їн} неверЇятнЇ шумн{ый|ая|Їе|ые}"},
    TORTURE={add="{Їн} будтЇ весь їЇкрыт{|а|Ї|ы} Їстрыми крючьями и шиїами"},
    TRADE={add="{Їн} дЇвЇлен{|а|Ї|ы} бЇльше всегЇ, кЇгда дует їЇїутный ветер"},
    TRAVELERS={add="{Їн} никЇгда їЇлнЇстью не Їстанавливается"},
    TREACHERY={add="рядЇм с {ним} не їЇ себе"},
    TREES={add="{Їн} тяжєл{|а|Ї|ы} сверху"},
    TRICKERY={add="время Їт времени {Їн} тихЇнькЇ їЇсмеивается їрЇ себя"},
    TRUTH={add="всє {егЇ} телЇ наїрягается, кЇгда їри {нєм} ктЇ-тЇ лжєт"},
    TWILIGHT={add="{Їн} кЇрЇткЇ стрекЇчет їеред рассветЇм и сразу їЇсле заката"},
    VALOR={add="{Їн} всегда їЇдбадривает любЇгЇ, ктЇ сражается рядЇм, їризывами к храбрЇсти ─ даже врагЇв"},
    VICTORY={add="{Їн} выглядит Їчень гЇрдым сЇбЇй"},
    VOLCANOS={add="{Їн} будтЇ яркЇ светится изнутри"},
    WAR={add="{Їн} без умЇлку ревєт и ликует"},
    WATER={add="кажется, на хЇду {Їн} струится"},
    WEALTH={add="кажется, {Їн} всє время чтЇ-тЇ считает"},
    WEATHER={add="{егЇ} Їблик меняется вместе с Їблаками и Їсадками"},
    WIND={add="{егЇ} всегда Їкружает їЇрыв ветра"},
    WISDOM={add="{Їн} действует с неїЇкЇлебимым сїЇкЇйствием"},
    WRITING={add="{Їн} їЇкрыт{|а|Ї|ы} бЇжественными їисьменами"},
    YOUTH={add="{Їн} выглядит бЇдр{ым|Їй|ым|ыми} и їЇлн{ым|Їй|ым|ыми} сил"},
}

function angel_description(lines,options)
    local ropar=random_object_parameters
    -- df-ru: о{ЕгЇ} сЇздала дварфийская бЇгиня Урист. {ЕгЇ} сферы ─ вЇйна, ЇгЇнь и смерть.п
    local end_str=" {ЕгЇ} "
    local add_desc=function(str) end_str=end_str..str end
    local hf=ropar.source_hf
    if hf then
        local noun,g="бЇжествЇ","n"
        if hf.gender==1 then noun,g="бЇгиня","f"
        elseif hf.gender==0 then noun,g="бЇг","m" end
        add_desc(({m="сЇздал ",f="сЇздала ",n="сЇздалЇ "})[g])
        add_desc(RU.np(ropar.source_hf_race_adj,noun,g))
        add_desc(" ")
        add_desc(hf.name.translated)
    else
        add_desc("сЇздалЇ неизвестнЇе бЇжествЇ")
    end
    local sch=0
    for k,v in pairs(options.spheres) do
        if v then sch = sch+1 end
    end
    if sch>0 then
        add_desc(". {ЕгЇ} "..(sch>1 and "сферы ─ " or "сфера ─ "))
        for k,v in pairs(options.spheres) do
            local n=random_sphere_nouns[k] and random_sphere_nouns[k][1]
            add_desc(n and n.str or world.spheres[k].definite_name)
            sch=sch-1
            if sch>=2 then add_desc(", ")
            elseif sch == 1 then add_desc(" и ")
            end
        end
    end
    add_desc(".")
    return end_str
end

angel_names_humanoid_warrior={
    {"Ангел","Ангелы","m"},
    {"СЇлдат","СЇлдаты","m"},
    {"ВЇин","ВЇины","m"},
    {"ПЇбЇрник","ПЇбЇрники","m"},
    {"БЇец","БЇйцы","m"},
    {"Страж","Стражи","m"},
    {"Дух","Духи","m"},
    {"Вестник","Вестники","m"},
    {"Истребитель","Истребители","m"},
    {"Каратель","Каратели","m"},
}

angel_names_great_beast={
    {"Зверь","Звери","m"},
    {"ЧудЇвище","ЧудЇвища","n"},
    {"Предвестник","Предвестники","m"},
    {"Чудище","Чудища","n"},
    {"Разрушитель","Разрушители","m"},
    {"РЇк","РЇки","m"},
    {"ПЇгибель","ПЇгибели","f"},
    {"КатастрЇфа","КатастрЇфы","f"},
    {"РазЇрение","РазЇрения","n"},
    {"Суд","Суды","m"},
}

angel_names_humanoid_generic={
    {"Слуга","Слуги","m"},
    {"ПЇмЇщник","ПЇмЇщники","m"},
    {"Прислужник","Прислужники","m"},
    {"Присїешник","Присїешники","m"},
    {"ПЇдручный","ПЇдручные","m"},
    {"РабЇтник","РабЇтники","m"},
    {"Длань","Длани","f"},
    {"СуществЇ","Существа","n"},
    {"МариЇнетка","МариЇнетки","f"},
    {"Пешка","Пешки","f"},
    {"Вассал","Вассалы","m"},
}

function angel_end_tokens(lines,options,names_tbl)
    lines[#lines+1]="[GO_TO_START]"
    local hf = random_object_parameters.source_hf
    local cand={}
    if hf.name.translated_epithet_compound then 
        cand[#cand+1]={
            hf.name.translated_epithet_compound,
            hf.name.native_epithet_compound,
            false}
    end
    if hf.name.translated_epithet_the then
        cand[#cand+1]={
            hf.name.translated_epithet_the,
            hf.name.native_epithet_the,
            false}
    end
    if hf.name.translated_epithet_the_adj1 then
        cand[#cand+1]={
            hf.name.translated_epithet_the_adj1,
            hf.name.native_epithet_the_adj1,
            false}
    end
    if string.len(hf.name.firstname) then
        cand[#cand+1]={hf.name.firstname,hf.name.firstname,true}
    end
    local god_name = pick_random(cand)
    local add_name,proper_name="",false
    local add_gen=nil -- df-ru: рЇд. ї. существительнЇгЇ сферы
    if god_name then
        add_name=god_name[trandom(2)+1]
        proper_name=god_name[3]
    end
    local using_god_name=false
    local name_flags={}
    local have_adjective=false
    cand={}
    for k,v in pairs(options.spheres) do
        if v then cand[#cand+1]=k end
    end
    if #cand>0 and (string.len(add_name)==0 or one_in(2)) then
        proper_name=false
        if one_in(2) then
            have_adjective=true
            add_name=get_random_sphere_adjective(pick_random(cand))
        else
            local ret=get_random_sphere_noun(pick_random(cand))
            name_flags=ret.flags
            add_name=ret.str
            add_gen=ret.gen
        end
    else using_god_name=true
    end
    local name,names,name_g=table.unpack(pick_random(names_tbl))
    local ntype
    if using_god_name and proper_name then ntype=trandom(2)+1
    elseif using_god_name then ntype=2
    elseif have_adjective or #name_flags==0 then ntype=0
    else 
        local cand={}
        if name_flags.PRE then cand[#cand+1]=0 end
        if name_flags.PREPOS then cand[#cand+1]=1 end
        if name_flags.OF then cand[#cand+1]=2 end
        ntype=pick_random(cand) or 0
    end
    -- df-ru: оВЇинственный Стражп (їрилагательнЇе сферы) или оСтраж вЇйнып, оСтраж Уристап (рЇд. ї.)
    local str
    if have_adjective then
        str=RU.adj(add_name,name_g).." "..name..":"..RU.adj(add_name,"p").." "..names..":"..RU.adj(add_name,name_g).." "..name
    else
        local own=add_gen or RU.gen(add_name)
        local tail=(own~="" and (" "..own) or "")
        str=name..tail..":"..names..tail..":"..name..tail
    end
    lines[#lines+1]="[NAME:"..str.."]"
    lines[#lines+1]="[CASTE_NAME:"..str.."]"
end

creatures.angel.humanoid_warrior.default=function(tok)
    local lines={}
    local options={
        can_learn=true,
        do_sphere_rcm=true,
        pick_sphere_rcm=true,
        force_ichor=true,
        sickness_name="бЇжественная хвЇрь",
        forced_color={
            f=3,
            b=0,
            br=1
        },
        token=tok,
    }
    lines[#lines+1]="[DIFFICULTY:6]"
    lines[#lines+1]="[CAN_LEARN]"
    if one_in(2) then lines[#lines+1]="[CAN_SPEAK]" end
    add_regular_tokens(lines,options)
    options.spheres=options.spheres or {}
    local hf=random_object_parameters.source_hf
    if hf then
        if hf.profile and hf.profile.mpp then
            map_merge(options.spheres,hf.profile.mpp.sphere)
        end
    end
    local skill_amount = (options.spheres.WAR or options.spheres.VALOR or options.spheres.FORTRESSES) and "10" or "6"
    for k,v in ipairs({
    "WRESTLING","BITE","GRASP_STRIKE","STANCE_STRIKE",
    "MELEE_COMBAT","RANGED_COMBAT","DODGING","SITUATIONAL_AWARENESS",
    "AXE","SWORD","DAGGER","PIKE",
    "MACE","HAMMER","WHIP","SPEAR",}) do
        lines[#lines+1]="[NATURAL_SKILL:"..v..":"..skill_amount.."]"
    end
    populate_sphere_info(lines,options)
    local rcm
    if one_in(4) then
        options.humanoidable_only=true
        rcp=get_random_creature_profile(options)
    else
        rcp={
            type="GENERAL_HUMANOID",
            name_string="humanoid",
            tile='H',
            body_base="HUMANOID",
            min_size=1,
        }
        if options.sphere_rcm then
            rcp.c_class="UNIFORM"
        else
            --FOR SKIN/ORGANS AND NO HAIR/FEATHERS AT FIRST
            rcp.c_class="AMPHIBIAN"
            rcp.cannot_have_shell=true
        end
    end
    add_body_size(lines,math.max(rcp.min_size,50000+trandom(4)*10000+trandom(11)*1000),options)
    lines[#lines+1]="[CREATURE_TILE:"..((options.body_size<=60000) and "132]" or "142]") -- Д or О
    options.custom_desc_func=function(options)
        local add_tbl=sphere_flavor[pick_random_conditional_pairs(sphere_flavor,function(sphere,_,options) 
            return options.spheres[sphere] 
        end,options)]
        if not add_tbl then add_tbl={add="{Їн} ─ бЇжественнЇе существЇ"} end
        if add_tbl.odor then
            options.always_odor=true
            options.forced_odor_string=add_tbl.odor
            options.forced_odor_level=100
        end
        return add_tbl.add
    end
    options.end_phrase=angel_description(lines,options)
    build_procgen_creature(rcp,lines,options)
    angel_end_tokens(lines,options,angel_names_humanoid_warrior)
    return {raws=lines,weight=1}
end

creatures.angel.humanoid_generic.default=function(tok)
    local lines={}
    local options={
        do_sphere_rcm=true,
        pick_sphere_rcm=true,
        force_ichor=true,
        sickness_name="бЇжественная хвЇрь",
        forced_color={
            f=6,
            b=0,
            br=0
        },
        token=tok,
    }
    lines[#lines+1]="[LARGE_PREDATOR]"
    lines[#lines+1]="[DIFFICULTY:2]"
    lines[#lines+1]="[NATURAL_SKILL:WRESTLING:4]"
    lines[#lines+1]="[NATURAL_SKILL:BITE:4]"
    lines[#lines+1]="[NATURAL_SKILL:GRASP_STRIKE:4]"
    lines[#lines+1]="[NATURAL_SKILL:STANCE_STRIKE:4]"
    lines[#lines+1]="[NATURAL_SKILL:MELEE_COMBAT:4]"
    lines[#lines+1]="[NATURAL_SKILL:RANGED_COMBAT:4]"
    lines[#lines+1]="[NATURAL_SKILL:DODGING:4]"
    lines[#lines+1]="[NATURAL_SKILL:SITUATIONAL_AWARENESS:4]"
    add_regular_tokens(lines,options)
    options.spheres=options.spheres or {}
    local hf=random_object_parameters.source_hf
    if hf then
        if hf.profile and hf.profile.mpp then
            map_merge(options.spheres,hf.profile.mpp.sphere)
        end
    end
    populate_sphere_info(lines,options)
    local rcm
    if one_in(4) then
        options.humanoidable_only=true
        rcp=get_random_creature_profile(options)
    else
        rcp={
            type="GENERAL_HUMANOID",
            name_string="humanoid",
            tile='H',
            body_base="HUMANOID",
            min_size=1,
        }
        if options.sphere_rcm then
            rcp.c_class="UNIFORM"
        else
            --FOR SKIN/ORGANS AND NO HAIR/FEATHERS AT FIRST
            rcp.c_class="AMPHIBIAN"
            rcp.cannot_have_shell=true
        end
    end
    add_body_size(lines,math.max(rcp.min_size,50000+trandom(4)*10000+trandom(11)*1000),options)
    lines[#lines+1]="[CREATURE_TILE:"..((options.body_size<=60000) and "132]" or "142]") -- Д or О
    options.custom_desc_func=function(options)
        local add_tbl=sphere_flavor[pick_random_conditional_pairs(sphere_flavor,function(sphere,_,options) 
            return options.spheres[sphere] 
        end,options)]
        if not add_tbl then add_tbl={add="{Їн} ─ бЇжественнЇе существЇ"} end
        if add_tbl.odor then
            options.always_odor=true
            options.forced_odor_string=add_tbl.odor
            options.forced_odor_level=100
        end
        return add_tbl.add
    end
    options.end_phrase=angel_description(lines,options)
    build_procgen_creature(rcp,lines,options)
    angel_end_tokens(lines,options,angel_names_humanoid_generic)
    return {raws=lines,weight=1}
end

creatures.angel.great_beast.default=function(tok)
    local lines={}
    local l=get_debug_logger()
    local options={
        can_learn=true,
        do_sphere_rcm=true,
        pick_sphere_rcm=true,
        force_ichor=true,
        beast_only=true,
        sickness_name="бЇжественная хвЇрь",
        forced_color={
            f=4,
            b=0,
            br=1
        },
        token=tok,
    }
    lines[#lines+1]="[LARGE_PREDATOR]"
    lines[#lines+1]="[DIFFICULTY:10]"
    lines[#lines+1]="[NATURAL_SKILL:WRESTLING:14]"
    lines[#lines+1]="[NATURAL_SKILL:BITE:14]"
    lines[#lines+1]="[NATURAL_SKILL:GRASP_STRIKE:14]"
    lines[#lines+1]="[NATURAL_SKILL:STANCE_STRIKE:14]"
    lines[#lines+1]="[NATURAL_SKILL:MELEE_COMBAT:14]"
    lines[#lines+1]="[NATURAL_SKILL:RANGED_COMBAT:14]"
    lines[#lines+1]="[NATURAL_SKILL:DODGING:14]"
    lines[#lines+1]="[NATURAL_SKILL:SITUATIONAL_AWARENESS:14]"
    add_regular_tokens(lines,options)
    options.spheres=options.spheres or {}
    local hf=random_object_parameters.source_hf
    if hf then
        if hf.profile and hf.profile.mpp then
            map_merge(options.spheres,hf.profile.mpp.sphere)
        end
    end
    local skill_amount = (options.spheres.WAR or options.spheres.VALOR or options.spheres.FORTRESSES) and "10" or "6"
    for k,v in ipairs({
    "WRESTLING","BITE","GRASP_STRIKE","STANCE_STRIKE",
    "MELEE_COMBAT","RANGED_COMBAT","DODGING","SITUATIONAL_AWARENESS",
    "AXE","SWORD","DAGGER","PIKE",
    "MACE","HAMMER","WHIP","SPEAR"}) do
        lines[#lines+1]="[NATURAL_SKILL:"..v..":"..skill_amount.."]"
    end
    populate_sphere_info(lines,options)
    local rcm
    rcp=get_random_creature_profile(options)
    add_body_size(lines,math.max(rcp.min_size,10000000),options)
    lines[#lines+1]="[CREATURE_TILE:"..((options.body_size<=60000) and "132]" or "142]") -- Д or О
    options.custom_desc_func=function(options)
        local add_tbl=sphere_flavor[pick_random_conditional_pairs(sphere_flavor,function(sphere,_,options) 
            return options.spheres[sphere] 
        end,options)]
        if not add_tbl then add_tbl={add="{Їн} ─ бЇжественнЇе существЇ"} end
        if add_tbl.odor then
            options.always_odor=true
            options.forced_odor_string=add_tbl.odor
            options.forced_odor_level=100
        end
        return add_tbl.add
    end
    options.end_phrase=angel_description(lines,options)
    build_procgen_creature(rcp,lines,options)
    angel_end_tokens(lines,options,angel_names_great_beast)
    return {raws=lines,weight=1}
end