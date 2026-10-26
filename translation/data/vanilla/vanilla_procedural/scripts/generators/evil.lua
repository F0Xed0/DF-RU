-- global so that other mods can add to it with cloud_adjs[#cloud_adjs+1]="execrable" or whatever
cloud_adjs={
    "їрЇклятый",
    "злЇбный",
    "злЇй",
    "їЇлзучий",
    "їреследующий",
    "мерзЇстный",
    "дьявЇльский",
    "бесЇвский",
    "гнусный",
    "чудЇвищный",
    "злЇдейский",
    "нечистый",
    "мерзкий",
    "Їкаянный",
    "чумнЇй",
    "Їмерзительный",
    "адский",
    "нечестивый",
    "жуткий",
}


cloud_names={
    {"туман","GAS",g="m",gen="тумана"},
    {"їыль","SOLID_POWDER",g="f",gen="їыли"},
    {"їеїел","SOLID_POWDER",g="m",gen="їеїла"},
    {"сажа","SOLID_POWDER",g="f",gen="сажи"},
    {"мгла","GAS",g="f",gen="мглы"},
    {"сумрак","GAS",g="m",gen="сумрака"},
    {"мЇрЇк","GAS",g="m",gen="мЇрЇка"},
    {"дым","GAS",g="m",gen="дыма"},
    {"їар","LIQUID",g="m",gen="їара"},
}

cloud_zombie_names={
    {"ЇбЇлЇчка","ЇбЇлЇчки"},
    {"зЇмби","зЇмби"},
    {"раб","рабы"}
}

materials.clouds.default=function()
    local mat={}
    local name_pick=pick_random(cloud_names)
    local cloud_adj=pick_random(cloud_adjs)
    -- df-ru: оїрЇклятая мглап, рЇд. ї. оїрЇклятЇй мглып ─ для хвЇри и зЇмби
    local name_str=RU.adj(cloud_adj,name_pick.g).." "..name_pick[1]
    local name_gen=RU.adj(cloud_adj,name_pick.g,"gen").." "..name_pick.gen
    mat[#mat+1]= "[STATE_NAME_ADJ:ALL:"..name_str.."]"
    populate_monotone_color_pattern()
    local col_pat=pick_random(monotone_color_pattern)
    if col_pat then
        local col = world.descriptor.color[col_pat.color]
        mat[#mat+1]= "[STATE_COLOR:ALL:"..col.token.."]"
        mat[#mat+1]= "[DISPLAY_COLOR:"..col.col_f..":0:"..col.col_br
    else
        mat[#mat+1]="[DISPLAY_COLOR:1:0:1]"
    end
    mat[#mat+1]=[[
    [MATERIAL_VALUE:1]
    [SPEC_HEAT:4181]
    [IGNITE_POINT:NONE]
    [MELTING_POINT:NONE]
    [BOILING_POINT:NONE]
    [HEATDAM_POINT:NONE]
    [COLDDAM_POINT:NONE]
    [MAT_FIXED_TEMP:10000]
    [MOLAR_MASS:1]
    [TEMP_DIET_INFO:SLIME]
    [ENTERS_BLOOD]
    [SYNDROME]
        [SYN_CLASS:ZOMBIE]
        [SYN_NAME:хвЇрь ]]..name_gen..[[]
        [SYN_AFFECTED_CLASS:GENERAL_POISON]
        [SYN_INJECTED][SYN_CONTACT][SYN_INHALED][SYN_INGESTED]
        ]]
    -- maybe make less hardcoded? pick-one from a table of effects that mods can add to later?
    if one_in(2) then
        --LIVING DEATH EFFECT
        mat[#mat+1]="        [CE_FLASH_TILE:TILE:165:3:0:0:FREQUENCY:2000:1000:START:0:ABRUPT]"
        local zombie_name=pick_random(cloud_zombie_names)
        local zombie_name_sing = zombie_name[1].." "..name_gen
        local zombie_name_plur = zombie_name[2].." "..name_gen
        mat[#mat+1]="        [CE_DISPLAY_NAME:NAME:"..zombie_name_sing..":"..zombie_name_plur..":"..zombie_name_sing..":START:0:ABRUPT]"
        mat[#mat+1]=[[
        [CE_PHYS_ATT_CHANGE:STRENGTH:130:0:TOUGHNESS:300:1000:START:0:ABRUPT]
        [CE_ADD_TAG:NO_AGING:NOT_LIVING:OPPOSED_TO_LIFE:STERILE:EXTRAVISION:NOEXERT:NOPAIN:NOBREATHE:NOSTUN:NONAUSEA:NO_DIZZINESS:NO_FEVERS:NOEMOTION:PARALYZEIMMUNE:NOFEAR:NO_EAT:NO_DRINK:NO_SLEEP:NO_PHYS_ATT_GAIN:NO_PHYS_ATT_RUST:NOTHOUGHT:NO_THOUGHT_CENTER_FOR_MOVEMENT:NO_CONNECTIONS_FOR_MOVEMENT:START:0:ABRUPT]
        [CE_REMOVE_TAG:HAS_BLOOD:TRANCES:MISCHIEVOUS:START:0:ABRUPT]
        ]]
    else
        add_base_poison_effects(mat,{
            "CE_PAIN",
            "CE_SWELLING",
            "CE_OOZING",
            "CE_BRUISING",
            "CE_BLISTERS",
            "CE_NUMBNESS",
            "CE_PARALYSIS",
            "CE_FEVER",
            "CE_BLEEDING",
            "CE_COUGH_BLOOD",
            "CE_VOMIT_BLOOD",
            "CE_NAUSEA",
            "CE_UNCONSCIOUSNESS",
            "CE_NECROSIS",
            "CE_IMPAIR_FUNCTION",
            "CE_DROWSINESS",
            "CE_DIZZINESS",
        }, 100,5,0,0,200,0,1200,2400,30,0,0,0)
    end
    return {weight=1,mat=mat,state=name_pick[2]}
end

rain_adjs={
    "едкий",
    "жгучий",
    "гЇрький",
    "вЇнючий",
    "Їтвратный",
    "смрадный",
    "грязный",
    "чудЇвищный",
    "ужасный",
    "мерзЇстный",
    "злЇвЇнный",
    "тЇшнЇтвЇрный",
    "гнилЇй",
    "Їтталкивающий",
    "Їмерзительный",
    "гадкий",
    "тухлый",
    "мерзкий"
}

rain_names={
    {"слизь",g="f",gen="слизи"},
    {"жижа",g="f",gen="жижи"},
    {"мЇкрЇта",g="f",gen="мЇкрЇты"},
    {"тина",g="f",gen="тины"},
    {"ил",g="m",gen="ила"},
    {"грязь",g="f",gen="грязи"},
    {"муть",g="f",gen="мути"},
    {"слякЇть",g="f",gen="слякЇти"}
}

materials.rain.default=function()
    local mat={}
    -- df-ru: оедкая слизьп, окиїящая едкая слизьп, охвЇрь едкЇй слизип
    local rain_adj=pick_random(rain_adjs)
    local rain_noun=pick_random(rain_names)
    local name_str=RU.adj(rain_adj,rain_noun.g).." "..rain_noun[1]
    local name_gen=RU.adj(rain_adj,rain_noun.g,"gen").." "..rain_noun.gen
    mat[#mat+1]= "[STATE_NAME_ADJ:GAS:"..RU.adj("киїящий",rain_noun.g).." "..name_str.."]"
    mat[#mat+1]= "[STATE_NAME_ADJ:LIQUID:"..name_str.."]"
    mat[#mat+1]= "[STATE_NAME_ADJ:ALL_SOLID:"..RU.adj("замєрзший",rain_noun.g).." "..name_str.."]"
    populate_monotone_color_pattern()
    local col_pat=pick_random(monotone_color_pattern)
    if col_pat then
        mat[#mat+1]= "[STATE_COLOR:ALL:"..col.token.."]"
        local col = world.descriptor.color[col_pat.color]
        mat[#mat+1]= "[DISPLAY_COLOR:"..col.col_f..":0:"..col.col_br
    else
        mat[#mat+1]="[DISPLAY_COLOR:1:0:1]"
    end
    mat[#mat+1]=[[
    [MATERIAL_VALUE:1]
    [SPEC_HEAT:4181]
    [IGNITE_POINT:NONE]
    [MELTING_POINT:NONE]
    [BOILING_POINT:NONE]
    [HEATDAM_POINT:NONE]
    [COLDDAM_POINT:NONE]
    [MAT_FIXED_TEMP:10000]
    [MOLAR_MASS:1]
    [TEMP_DIET_INFO:SLIME]
    [ENTERS_BLOOD]
    [SYNDROME]
        [SYN_NAME:хвЇрь ]]..name_gen..[[]
        [SYN_AFFECTED_CLASS:GENERAL_POISON]
        [SYN_INJECTED][SYN_CONTACT][SYN_INHALED][SYN_INGESTED]
        ]]
    add_base_poison_effects(mat,{
        "CE_PAIN",
        "CE_OOZING",
        "CE_BRUISING",
        "CE_BLISTERS",
        "CE_FEVER",
        "CE_COUGH_BLOOD",
        "CE_NAUSEA",
        "CE_DIZZINESS",
    }, 10,3,0,1200,200,1200,1200,2400,30,2,2,2)
    return {weight=1,mat=mat}
end