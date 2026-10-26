mythical_remnant_adjectives={
    "їервЇзданный",
    "древний",
    "кЇсмический",
    "изначальный",
    "стихийный",
    "їервЇбытный"
}

mythical_remnant_spheres={}

mythical_remnant_spheres.MOUNTAINS={
    name="камень",g="m",
    color="4:0:1",
    state_color="GRAY"
}

mythical_remnant_spheres.MINERALS=mythical_remnant_spheres.MOUNTAINS
mythical_remnant_spheres.CAVERNS=mythical_remnant_spheres.MOUNTAINS
mythical_remnant_spheres.EARTH=mythical_remnant_spheres.MOUNTAINS

mythical_remnant_spheres.JEWELS={
    name="кристалл",g="m",
    color="7:0:1",
    state_color="WHITE"
}

mythical_remnant_spheres.CHAOS={
    name="хаЇс",g="m",
    color="4:0:1",
    state_color="RED"
}

mythical_remnant_spheres.DARKNESS={
    name="тьма",g="f",
    color="0:0:1",
    state_color="BLACK"
}

mythical_remnant_spheres.DEATH=mythical_remnant_spheres.DARKNESS
mythical_remnant_spheres.NIGHTMARES=mythical_remnant_spheres.DARKNESS

mythical_remnant_spheres.DREAMS={
    name="материя снЇв",g="f",
    color="2:0:1",
    state_color="GREEN"
}

mythical_remnant_spheres.FIRE={
    name="ЇгЇнь",g="m",
    color="4:0:1",
    state_color="RED"
}

mythical_remnant_spheres.LIGHT={
    name="свет",g="m",
    color="6:0:1",
    state_color="YELLOW"
}

mythical_remnant_spheres.LIGHTNING={
    name="мЇлния",g="f",
    color="6:0:1",
    state_color="YELLOW"
}

mythical_remnant_spheres.METALS={
    name="металл",g="m",
    color="7:0:1",
    state_color="SILVER"
}

mythical_remnant_spheres.MOON={
    name="лунный камень",g="m",
    color="7:0:1",
    state_color="WHITE"
}

mythical_remnant_spheres.MUCK={
    name="аргиллит",g="m",
    color="6:0:0",
    state_color="BROWN"
}

mythical_remnant_spheres.OCEANS={
    name="лєд",g="m",
    color="1:0:1",
    state_color="BLUE"
}

mythical_remnant_spheres.WATER=mythical_remnant_spheres.OCEANS

mythical_remnant_spheres.PLANTS={
    name="листва",g="f",
    color="2:0:1",
    state_color="GREEN"
}

mythical_remnant_spheres.SALT={
    name="сЇль",g="f",
    color="7:0:1",
    state_color="WHITE"
}

mythical_remnant_spheres.MIST={
    name="Їблачная материя",g="f",
    color="7:0:1",
    state_color="WHITE"
}

mythical_remnant_spheres.SKY=mythical_remnant_spheres.MIST
mythical_remnant_spheres.STORMS=mythical_remnant_spheres.MIST
mythical_remnant_spheres.WIND=mythical_remnant_spheres.MIST

mythical_remnant_spheres.STARS={
    name="звєздная їыль",g="f",
    color="6:0:1",
    state_color="YELLOW"
}

mythical_remnant_spheres.SUN={
    name="сЇлнечный камень",g="m",
    color="6:0:1",
    state_color="YELLOW"
}

mythical_remnant_spheres.TREES={
    name="древесина",g="f",
    color="6:0:0",
    state_color="BROWN"
}

mythical_remnant_spheres.VOLCANOS={
    name="Їбсидиан",g="m",
    color="4:0:1",
    state_color="RED"
}


materials.mythical_remnant.default=function(sph)
    local lines={}
    lines[#lines+1]="[USE_MATERIAL_TEMPLATE:METAL_TEMPLATE]"
    local sph_info = mythical_remnant_spheres[sph] or {name="сбЇйная материя", g="f", color="0:0:1", state_color="BLACK"}
    lines[#lines+1]="[DISPLAY_COLOR:"..sph_info.color.."]"
    lines[#lines+1]="[BUILD_COLOR:"..sph_info.color.."]"
    lines[#lines+1]="[STATE_COLOR:ALL:"..sph_info.state_color.."]"
    lines[#lines+1]="[STATE_NAME_ADJ:ALL_SOLID:"..RU.adj(pick_random(mythical_remnant_adjectives),sph_info.g or "m").." "..sph_info.name.."]"
    lines[#lines+1]="[MATERIAL_VALUE:200]"
    lines[#lines+1]="[SPEC_HEAT:7500]"
    lines[#lines+1]="[MELTING_POINT:NONE]"
    lines[#lines+1]="[BOILING_POINT:NONE]"
    lines[#lines+1]="[ITEMS_HARD]"
    if(sph=="METALS") then lines[#lines+1]="[ITEMS_METAL]" end
    lines[#lines+1]="[SOLID_DENSITY:1000]"
    lines[#lines+1]="[LIQUID_DENSITY:1000]"
    lines[#lines+1]="[MOLAR_MASS:20000]"
    lines[#lines+1]="[IMPACT_YIELD:1000000]"
    lines[#lines+1]="[IMPACT_FRACTURE:2000000]"
    lines[#lines+1]="[IMPACT_STRAIN_AT_YIELD:0]"
    lines[#lines+1]="[COMPRESSIVE_YIELD:1000000]"
    lines[#lines+1]="[COMPRESSIVE_FRACTURE:2000000]"
    lines[#lines+1]="[COMPRESSIVE_STRAIN_AT_YIELD:0]"
    lines[#lines+1]="[TENSILE_YIELD:1000000]"
    lines[#lines+1]="[TENSILE_FRACTURE:2000000]"
    lines[#lines+1]="[TENSILE_STRAIN_AT_YIELD:0]"
    lines[#lines+1]="[TORSION_YIELD:1000000]"
    lines[#lines+1]="[TORSION_FRACTURE:2000000]"
    lines[#lines+1]="[TORSION_STRAIN_AT_YIELD:0]"
    lines[#lines+1]="[SHEAR_YIELD:1000000]"
    lines[#lines+1]="[SHEAR_FRACTURE:2000000]"
    lines[#lines+1]="[SHEAR_STRAIN_AT_YIELD:0]"
    lines[#lines+1]="[BENDING_YIELD:1000000]"
    lines[#lines+1]="[BENDING_FRACTURE:2000000]"
    lines[#lines+1]="[BENDING_STRAIN_AT_YIELD:0]"
    lines[#lines+1]="[MAX_EDGE:12000]"
    return {raws=lines,weight=1}
end

mythical_healing_adjectives={
    "любЇїытный",
    "странный",
    "чуднЇй",
    "дикЇвинный",
    "неЇбычный",
    "свЇеЇбразный"
}

mythical_healing_liquids={
    {"жидкЇсть",g="f",gen="жидкЇсти"},
    {"влага",g="f",gen="влаги"},
    {"Їтвар",g="m",gen="Їтвара"},
    {"сЇк",g="m",gen="сЇка"},
    {"жижа",g="f",gen="жижи"},
    {"настЇйка",g="f",gen="настЇйки"},
    {"раствЇр",g="m",gen="раствЇра"}
}

mythical_healing_alcohols={
    ["настЇйка"]=true -- df-ru: ключ ─ русскЇе слЇвЇ (былЇ liquor)
}

mythical_healing_globs={
    {"желе",g="n",gen="желе"},
    {"мякЇть",g="f",gen="мякЇти"},
    {"вЇск",g="m",gen="вЇска"},
    {"варенье",g="n",gen="варенья"},
    {"тестЇ",g="n",gen="теста"}
}

materials.mythical_healing.default=function()
    -- df-ru: остранная жидкЇстьп, озамєрзшая странная жидкЇстьп, одействие страннЇй жидкЇстип
    local h_adj = pick_random(mythical_healing_adjectives)
    local name_str, name_gen, ng
    local noun=""
    local lines={}
    if one_in(2) then
        local n=pick_random(mythical_healing_liquids)
        noun,ng=n[1],n.g
        name_str=RU.adj(h_adj,ng).." "..noun
        name_gen=RU.adj(h_adj,ng,"gen").." "..n.gen
        lines[#lines+1]="[STATE_NAME_ADJ:LIQUID:"..name_str.."]"
        lines[#lines+1]="[STATE_NAME_ADJ:ALL_SOLID:"..RU.adj("замєрзший",ng).." "..name_str.."]"
        lines[#lines+1]="[MELTING_POINT:9900]"
    else
        local n=pick_random(mythical_healing_globs)
        noun,ng=n[1],n.g
        name_str=RU.adj(h_adj,ng).." "..noun
        name_gen=RU.adj(h_adj,ng,"gen").." "..n.gen
        lines[#lines+1]="[STATE_NAME_ADJ:LIQUID:"..RU.adj("расїлавленный",ng).." "..name_str.."]"
        lines[#lines+1]="[STATE_NAME_ADJ:ALL_SOLID:"..name_str.."]"
        lines[#lines+1]="[MELTING_POINT:10200]"
    end
    lines[#lines+1]="[STATE_NAME_ADJ:GAS:"..RU.adj("киїящий",ng).." "..name_str.."]"
    lines[#lines+1]="[BOILING_POINT:12000]"
    populate_monotone_color_pattern()
    local col_pat=pick_random(monotone_color_pattern)
    if col_pat then
        local col = world.descriptor.color[col_pat.color]
        lines[#lines+1]="[STATE_COLOR:ALL:"..col.token.."]"
        lines[#lines+1]="[DISPLAY_COLOR:"..col.col_f..":0:"..col.col_br
    else
        lines[#lines+1]="[DISPLAY_COLOR:1:0:1]"
    end
    lines[#lines+1]="[MATERIAL_VALUE:1]"
    lines[#lines+1]="[SPEC_HEAT:4181]"
    lines[#lines+1]="[IGNITE_POINT:NONE]"
    lines[#lines+1]="[HEATDAM_POINT:NONE]"
    lines[#lines+1]="[COLDDAM_POINT:NONE]"
    lines[#lines+1]="[MAT_FIXED_TEMP:NONE]"
    lines[#lines+1]="[MOLAR_MASS:1]"
    
    lines[#lines+1]="[EDIBLE_VERMIN]"
    lines[#lines+1]="[EDIBLE_RAW]"
    lines[#lines+1]="[EDIBLE_COOKED]"
    lines[#lines+1]="[DO_NOT_CLEAN_GLOB]"
    if mythical_healing_alcohols[noun] then -- i'm sure you can think of some alcoholic globs if you want
        lines[#lines+1]="[ALCOHOL]"
    end
    lines[#lines+1]="[ENTERS_BLOOD]"
    lines[#lines+1]="    [SYNDROME]"
    lines[#lines+1]="        [SYN_NAME:действие "..name_gen.."]"
    lines[#lines+1]="        [SYN_AFFECTED_CLASS:GENERAL_POISON]"
    lines[#lines+1]="        [SYN_INGESTED]"
    --[[ all of this was in a for loop with individual creature effects listed out but (I *think*) the design purpose for that is fulfilled
         by having it all out in Lua anyway, so I'm just going to hardcode it here and if users wanna mod it they can add their own function]]
    lines[#lines+1]="        [CE_REGROW_PARTS:SEV:100:PROB:100:START:0:PEAK:0:END:12:ABRUPT:BP:BY_CATEGORY:ALL:ALL]"
    lines[#lines+1]="        [CE_CLOSE_OPEN_WOUNDS:SEV:100:PROB:100:START:0:PEAK:0:END:12:ABRUPT:BP:BY_CATEGORY:ALL:ALL]"
    lines[#lines+1]="        [CE_HEAL_TISSUES:SEV:100:PROB:100:START:0:PEAK:0:END:12:ABRUPT:BP:BY_CATEGORY:ALL:ALL]"
    lines[#lines+1]="        [CE_HEAL_NERVES:SEV:100:PROB:100:START:0:PEAK:0:END:12:ABRUPT:BP:BY_CATEGORY:ALL:ALL]"
    lines[#lines+1]="        [CE_STOP_BLEEDING:SEV:100:PROB:100:START:0:PEAK:0:END:12:ABRUPT:BP:BY_CATEGORY:ALL:ALL]"
    lines[#lines+1]="        [CE_REDUCE_PAIN:SEV:100:PROB:100:START:0:PEAK:0:END:12:ABRUPT:BP:BY_CATEGORY:ALL:ALL]"
    lines[#lines+1]="        [CE_REDUCE_DIZZINESS:SEV:100:PROB:100:START:0:PEAK:0:END:12:ABRUPT]"
    lines[#lines+1]="        [CE_REDUCE_NAUSEA:SEV:100:PROB:100:START:0:PEAK:0:END:12:ABRUPT]"
    lines[#lines+1]="        [CE_REDUCE_SWELLING:SEV:100:PROB:100:START:0:PEAK:0:END:12:ABRUPT:BP:BY_CATEGORY:ALL:ALL]"
    lines[#lines+1]="        [CE_CURE_INFECTION:SEV:100:PROB:100:START:0:PEAK:0:END:12:ABRUPT:BP:BY_CATEGORY:ALL:ALL]"
    lines[#lines+1]="        [CE_REDUCE_PARALYSIS:SEV:100:PROB:100:START:0:PEAK:0:END:12:ABRUPT:BP:BY_CATEGORY:ALL:ALL]"
    lines[#lines+1]="        [CE_REDUCE_FEVER:SEV:100:PROB:100:START:0:PEAK:0:END:12:ABRUPT]"
    return {raws=lines,weight=1}
end