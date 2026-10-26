metal_by_sphere={ -- global on purpose so mods can adjust these
    LIGHT={
        name="сияющий металл",
        col="7:0:1",
        color="WHITE"
    },
    LIGHTNING={
        name="сверкающий металл",
        col="6:0:1",
        color="YELLOW"
    },
    BLIGHT={
        name="ржавый металл",
        col="4:0:0",
        color="RUST"
    },
    CHAOS={
        name="извивающийся металл",
        col="4:0:1",    
        color="RED"
    },
    DARKNESS={
        name="тємный металл",
        col="0:0:1",
        color="BLACK"
    },
    DAWN={
        name="светящийся металл",
        col="6:0:1",
        color="YELLOW"
    },
    DAY={
        name="яркий металл",
        col="7:0:1",
        color="WHITE"
    },
    DEATH={
        name="бледный металл",
        col="3:0:1",
        color="PALE_BLUE"
    },
    DEFORMITY={
        name="рябЇй металл",
        col="0:0:1",
        color="BLACK"
    },
    DISEASE={
        name="їузырчатый металл",
        col="0:0:1",
        color="BLACK"
    },
    EARTH={
        name="рдеющий металл",
        col="6:0:0",
        color="BURNT_SIENNA"
    },
    FIRE={
        name="мерцающий металл",
        col="6:0:1",
        color="YELLOW"
    },
    JEWELS={
        name="гранєный металл",
        col="2:0:1",
        color="GREEN"
    },
    MOON={
        name="їЇлуїрЇзрачный металл",
        col="3:0:1",
        color="CLEAR"
    },
    MOUNTAINS={
        name="инистый металл",
        col="7:0:1",
        color="WHITE"
    },
    MUCK={
        name="скЇльзкий металл",
        col="6:0:0",
        color="BROWN"
    },
    MUSIC={
        name="їЇющий металл",
        col="7:0:1",
        color="WHITE"
    },
    NIGHT={
        name="чєрный металл",
        col="0:0:1",
        color="BLACK"
    },
    RAINBOWS={
        name="мнЇгЇцветный металл",
        col="2:0:1",
        color="CLEAR"
    },
    SKY={
        name="їрЇзрачнЇ-синий металл",
        col="3:0:1",
        color="SKY_BLUE"
    },
    STARS={
        name="мигающий металл",
        col="7:0:1",
        color="WHITE"
    },
    STORMS={
        name="грЇхЇчущий металл",
        col="7:0:0",
        color="GRAY"
    },
    SUN={
        name="їылающий металл",
        col="7:0:1",
        color="WHITE"
    },
    THUNDER={
        name="гулкий металл",
        col="7:0:0",
        color="GRAY"
    },
    TORTURE={
        name="Їбжигающий металл",
        col="0:0:1",
        color="BLACK"
    },
    VOLCANOS={
        name="текучий металл",
        col="4:0:1",
        color="RED"
    },
}

materials.divine.metal.default=function(sphere)
    local mat_info=metal_by_sphere[sphere]
    if mat_info then
        local m={weight=1,mat={}}
        m.mat[#m.mat+1]="[USE_MATERIAL_TEMPLATE:METAL_TEMPLATE]"
        m.mat[#m.mat+1]="[DISPLAY_COLOR:"..mat_info.col.."]"
        m.mat[#m.mat+1]="[BUILD_COLOR:"..mat_info.col.."]"
        m.mat[#m.mat+1]="[STATE_COLOR:ALL_SOLID:"..mat_info.color.."]"
        m.mat[#m.mat+1]="[STATE_NAME_ADJ:ALL_SOLID:"..mat_info.name.."]"
        m.mat[#m.mat+1]="[MATERIAL_VALUE:200]"
        m.mat[#m.mat+1]="[SPEC_HEAT:7500]"
        m.mat[#m.mat+1]="[MELTING_POINT:NONE]"
        m.mat[#m.mat+1]="[BOILING_POINT:NONE]"
        m.mat[#m.mat+1]="[ITEMS_WEAPON][ITEMS_WEAPON_RANGED][ITEMS_AMMO][ITEMS_DIGGER][ITEMS_ARMOR][ITEMS_ANVIL]"
        m.mat[#m.mat+1]="[ITEMS_HARD]"
        m.mat[#m.mat+1]="[ITEMS_METAL]"
        m.mat[#m.mat+1]="[ITEMS_BARRED]"
        m.mat[#m.mat+1]="[ITEMS_SCALED]"
        m.mat[#m.mat+1]="[SOLID_DENSITY:1000]"
        m.mat[#m.mat+1]="[LIQUID_DENSITY:1000]"
        m.mat[#m.mat+1]="[MOLAR_MASS:20000]"
        m.mat[#m.mat+1]="[IMPACT_YIELD:1000000]"
        m.mat[#m.mat+1]="[IMPACT_FRACTURE:2000000]"
        m.mat[#m.mat+1]="[IMPACT_STRAIN_AT_YIELD:0]"
        m.mat[#m.mat+1]="[COMPRESSIVE_YIELD:1000000]"
        m.mat[#m.mat+1]="[COMPRESSIVE_FRACTURE:2000000]"
        m.mat[#m.mat+1]="[COMPRESSIVE_STRAIN_AT_YIELD:0]"
        m.mat[#m.mat+1]="[TENSILE_YIELD:1000000]"
        m.mat[#m.mat+1]="[TENSILE_FRACTURE:2000000]"
        m.mat[#m.mat+1]="[TENSILE_STRAIN_AT_YIELD:0]"
        m.mat[#m.mat+1]="[TORSION_YIELD:1000000]"
        m.mat[#m.mat+1]="[TORSION_FRACTURE:2000000]"
        m.mat[#m.mat+1]="[TORSION_STRAIN_AT_YIELD:0]"
        m.mat[#m.mat+1]="[SHEAR_YIELD:1000000]"
        m.mat[#m.mat+1]="[SHEAR_FRACTURE:2000000]"
        m.mat[#m.mat+1]="[SHEAR_STRAIN_AT_YIELD:0]"
        m.mat[#m.mat+1]="[BENDING_YIELD:1000000]"
        m.mat[#m.mat+1]="[BENDING_FRACTURE:2000000]"
        m.mat[#m.mat+1]="[BENDING_STRAIN_AT_YIELD:0]"
        m.mat[#m.mat+1]="[MAX_EDGE:12000]"
        return m
    end
end

silk_by_sphere={
    LIGHT={
        name="светящаяся ткань",
        col="7:0:1",
        color="WHITE"
    },
    LIGHTNING={
        name="сверкающие искры",
        col="6:0:1",
        color="YELLOW"
    },
    BEAUTY={
        name="їляшущие ЇгЇньки",
        col="6:0:1",
        color="YELLOW"
    },
    BLIGHT={
        name="истлевшая ткань",
        col="0:0:1",
        color="BLACK"
    },
    CHAOS={
        name="вечнЇ кЇлышущаяся ткань",
        col="4:0:1",
        color="RED"
    },
    DARKNESS={
        name="жидкая тьма",
        col="0:0:1",
        color="BLACK"
    },
    DAWN={
        name="сияющая ткань",
        col="6:0:1",
        color="ORANGE"
    },
    DAY={
        name="яркая ткань",
        col="7:0:1",
        color="WHITE"
    },
    DEATH={
        name="бледная ткань",
        col="3:0:1",
        color="PALE_BLUE"
    },
    DEFORMITY={
        name="їерекрученная ткань",
        col="0:0:1",
        color="BLACK"
    },
    DISEASE={
        name="лЇскутная ткань",
        col="7:0:0",
        color="GRAY"
    },
    DREAMS={
        name="дымчатая ткань",
        col="1:0:1",
        color="BLUE"
    },
    DUSK={
        name="їЇлуїрЇзрачная ткань",
        col="3:0:1",
        color="CLEAR"
    },
    FIRE={
        name="мерцающая ткань",
        col="6:0:1",
        color="YELLOW"
    },
    JEWELS={
        name="гранєная ткань",
        col="2:0:1",
        color="GREEN"
    },
    LAKES={
        name="неїЇдвижная синяя ткань",
        col="1:0:1",
        color="BLUE"
    },
    LIES={
        name="тяжєлая ткань",
        col="0:0:1",
        color="BLACK"
    },
    MIST={
        name="туманная ткань",
        col="7:0:0",
        color="CLEAR"
    },
    MOON={
        name="белая ткань",
        col="7:0:1",
        color="WHITE"
    },
    MUCK={
        name="грязная ткань",
        col="6:0:0",
        color="BROWN"
    },
    MUSIC={
        name="звучные нити",
        col="0:0:1",
        color="BLACK"
    },
    NIGHT={
        name="неїрЇгляднЇ-чєрная ткань",
        col="0:0:1",
        color="BLACK"
    },
    NIGHTMARES={
        name="кричащие рты",
        col="5:0:0",
        color="TAUPE_MEDIUM"
    },
    OCEANS={
        name="вЇлнистая ткань",
        col="3:0:0",
        color="SEA_GREEN"
    },
    RAIN={
        name="влажная ткань",
        col="3:0:1",
        color="CLEAR"
    },
    RAINBOWS={
        name="мнЇгЇцветная ткань",
        col="2:0:1",
        color="CLEAR"
    },
    RIVERS={
        name="струящаяся ткань",
        col="1:0:1",
        color="BLUE"
    },
    SKY={
        name="їрЇзрачнЇ-синяя ткань",
        col="3:0:1",
        color="SKY_BLUE"
    },
    STARS={
        name="круїицы света",
        col="7:0:1",
        color="WHITE"
    },
    STORMS={
        name="текучая ткань",
        col="7:0:0",
        color="GRAY"
    },
    SUN={
        name="їылающая ткань",
        col="7:0:1",
        color="WHITE"
    },
    THUNDER={
        name="сияющая ткань",
        col="7:0:1",
        color="WHITE"
    },
    TRICKERY={
        name="їереливчатая ткань",
        col="3:0:1",
        color="CLEAR"
    },
    TWILIGHT={
        name="теневая материя",
        col="0:0:1",
        color="BLACK"
    },
    VOLCANOS={
        name="расїлавленная жидкЇсть",
        col="4:0:1",
        color="RED"
    },
    WATER={
        name="жидкая ткань",
        col="1:0:1",
        color="BLUE"
    },
    WIND={
        name="шуршащая ткань",
        col="7:0:0",
        color="GRAY"
    },
}

materials.divine.silk.default=function(sphere)
    local m={weight=0,mat={}}
    local mat_info=silk_by_sphere[sphere]
    if mat_info then
        m.weight=1
        m.mat[#m.mat+1]="[USE_MATERIAL_TEMPLATE:SILK_TEMPLATE]"
        m.mat[#m.mat+1]="[DISPLAY_COLOR:"..mat_info.col.."]"
        m.mat[#m.mat+1]="[BUILD_COLOR:"..mat_info.col.."]"
        m.mat[#m.mat+1]="[STATE_COLOR:ALL_SOLID:"..mat_info.color.."]"
        m.mat[#m.mat+1]="[STATE_NAME_ADJ:ALL_SOLID:"..mat_info.name.."]"
        m.mat[#m.mat+1]="[MATERIAL_VALUE:300]"
        m.mat[#m.mat+1]="[IGNITE_POINT:NONE]"
        m.mat[#m.mat+1]="[SOLID_DENSITY:1]"
        m.mat[#m.mat+1]="[MOLAR_MASS:1]"
        m.mat[#m.mat+1]="[ITEMS_SOFT]"
        return m
    end
end