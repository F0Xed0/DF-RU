angel_item_info={
    armor={
        pants={
            gen={},
            adj={
                "углЇватый",
                "Їкруглый",
                "тЇнкий",
                "зазубренный"
            }
        },
        armor={
            gen={},
            adj={
                "выїуклый",
                "квадратный",
                "сегментирЇванный",
                "зазубренный"
            }
        },
        helm={
            gen={},
            adj={
                "кЇнический",
                "Їкруглый",
                "высЇкий",
                "зазубренный"
            }
        },
        gloves={
            gen={},
            adj={
                "грЇмЇздкий",
                "замыслЇватый",
                "тЇнкий",
                "зазубренный"
            }
        },
        shoes={
            gen={},
            adj={
                "углЇватый",
                "гладкий",
                "замыслЇватый",
                "зазубренный"
            }
        },
    },
    clothing={
        pants={
            gen={},
            adj={
                "разрезнЇй",
                "ЇбЇрчатый",
                "їрЇзрачный",
                "кЇлЇкЇлЇЇбразный"
            }
        },
        armor={
            gen={},
            adj={
				"ЇбЇрчатый",
				"гладкий",
				"грЇмЇздкий",
				"асимметричный",
            }
        },
        helm={
            gen={},
            adj={
				"ЇбЇрчатый",
				"гладкий",
				"грЇмЇздкий",
            }
        },
        gloves={
            gen={},
            adj={
				"грЇмЇздкий",
				"гладкий",
				"ЇбЇрчатый",
            }
        },
        shoes={
            gen={},
            adj={
				"ЇбЇрчатый",
				"їрЇзрачный",
				"грЇмЇздкий",
            }
        },
    },
    weapon={
        PIKE={
            gen={},
            adj={
                "изЇгнутый",
                "вЇлнистый",
                "зазубренный",
                "тЇнкий"
            }
        },
        WHIP={
            gen={},
            adj={
                "грЇмЇздкий",
                "ветвистый",
                "тЇнкий",
                "длинный",
            }
        },
        BOW={
            gen={},
            adj={
                "заЇстрєнный",
                "высЇкий",
                "зазубренный",
                "тЇнкий",
            }
        },
        BLOWGUN={
            gen={},
            adj={
                "изЇгнутый",
                "вЇлнистый",
                "зазубренный",
                "тЇнкий"
            }
        },
        AXE={
            gen={},
            adj={
                "серїЇвидный",
                "зазубренный",
                "тЇнкий",
            }
        },
        SWORD={
            gen={},
            adj={
                "изЇгнутый",
                "вЇлнистый",
                "зазубренный",
                "тЇнкий"
            }
        },
        DAGGER={
            gen={},
            adj={
                "изЇгнутый",
                "витЇй",
                "зазубренный",
                "тЇнкий",
            }
        },
        MACE={
            gen={},
            adj={
                "гнутый",
                "высЇкий",
                "зазубренный",
                "тЇнкий",
            }
        },
        HAMMER={
            gen={},
            adj={
                "изЇгнутый",
                "бЇльшегЇлЇвый",
                "зазубренный",
                "тЇнкий",
            }
        },
        SPEAR={
            gen={},
            adj={
                "тЇлстый",
                "вЇлнистый",
                "зазубренный",
                "тЇнкий",
            }
        },
        CROSSBOW={
            gen={},
            adj={
                "гладкий",
                "длинный",
                "зазубренный",
                "грЇмЇздкий",
            }
        },
    },
    ammo={
        ARROW={},
        BLOWDART={},
        BOLT={}
    },
    shield={
        gen={},
        adj={
            "изЇгнутый",
            "квадратный",
            "высЇкий",
            "їрямЇугЇльный"
        }
    }
}

angel_item_info.armor.pants.gen.greaves=function()
    local lines={}
    -- some more variety-causing way to generate these?
    lines[#lines+1]="[NAME:їЇнЇжи:їЇнЇжи]"
    lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.armor.pants.adj).."]"
    lines[#lines+1]="[ARMORLEVEL:3]"
    lines[#lines+1]="[LBSTEP:MAX]"
    lines[#lines+1]="[SHAPED]"
    lines[#lines+1]="[LAYER:ARMOR]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:15]"
    lines[#lines+1]="[LAYER_PERMIT:30]"
    lines[#lines+1]="[MATERIAL_SIZE:6]"
    lines[#lines+1]="[METAL]"
    lines[#lines+1]="[BARRED]"
    lines[#lines+1]="[HARD]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:PANTS_GREAVES]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.pants.gen.skirt=function()
    local lines={}
    lines[#lines+1]="[NAME:юбка:юбки]"
    lines[#lines+1]="[LBSTEP:1]"
    lines[#lines+1]="[LAYER:OVER]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:10]"
    lines[#lines+1]="[LAYER_PERMIT:100]"
    lines[#lines+1]="[MATERIAL_SIZE:2]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:PANTS_SKIRT]"
    return {raws=lines,weight=1}
end

angel_item_info.armor.armor.gen.breastplate=function()
    local lines={}
    lines[#lines+1]="[NAME:кираса:кирасы]"
    lines[#lines+1]="[ARMORLEVEL:3]"
    lines[#lines+1]="[UBSTEP:0]"
    lines[#lines+1]="[LBSTEP:0]"
    lines[#lines+1]="[SHAPED]"
    lines[#lines+1]="[LAYER:ARMOR]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:20]"
    lines[#lines+1]="[LAYER_PERMIT:50]"
    lines[#lines+1]="[MATERIAL_SIZE:9]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:ARMOR_BREASTPLATE]"
    return {raws=lines,weight=1}
end

-- out into its own file?
angel_item_info.clothing.armor.gen.coat=function()
    local lines={}
    lines[#lines+1]="[NAME:кафтан:кафтаны]"
    lines[#lines+1]="[UBSTEP:MAX]"
    lines[#lines+1]="[LBSTEP:1]"
    lines[#lines+1]="[LAYER:OVER]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:20]"
    lines[#lines+1]="[LAYER_PERMIT:50]"
    lines[#lines+1]="[MATERIAL_SIZE:5]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:ARMOR_COAT]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.armor.gen.shirt=function()
    local lines={}
    lines[#lines+1]="[NAME:рубаха:рубахи]"
    lines[#lines+1]="[UBSTEP:MAX]"
    lines[#lines+1]="[LBSTEP:0]"
    lines[#lines+1]="[LAYER:UNDER]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:10]"
    lines[#lines+1]="[LAYER_PERMIT:50]"
    lines[#lines+1]="[MATERIAL_SIZE:3]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:ARMOR_SHIRT]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.armor.gen.cloak=function()
    local lines={}
    lines[#lines+1]="[NAME:їлащ:їлащи]"
    lines[#lines+1]="[UBSTEP:MAX]"
    lines[#lines+1]="[LBSTEP:1]"
    lines[#lines+1]="[LAYER:COVER]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:15]"
    lines[#lines+1]="[LAYER_PERMIT:150]"
    lines[#lines+1]="[MATERIAL_SIZE:5]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:ARMOR_CLOAK]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.armor.gen.tunic=function()
    local lines={}
    lines[#lines+1]="[NAME:туника:туники]"
    lines[#lines+1]="[UBSTEP:0]"
    lines[#lines+1]="[LBSTEP:1]"
    lines[#lines+1]="[LAYER:UNDER]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:10]"
    lines[#lines+1]="[LAYER_PERMIT:50]"
    lines[#lines+1]="[MATERIAL_SIZE:3]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:ARMOR_TUNIC]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.armor.gen.toga=function()
    local lines={}
    lines[#lines+1]="[NAME:тЇга:тЇги]"
    lines[#lines+1]="[UBSTEP:1]"
    lines[#lines+1]="[LBSTEP:1]"
    lines[#lines+1]="[LAYER:OVER]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:30]"
    lines[#lines+1]="[LAYER_PERMIT:100]"
    lines[#lines+1]="[MATERIAL_SIZE:5]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:ARMOR_TOGA]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.armor.gen.cape=function()
    local lines={}
    lines[#lines+1]="[NAME:накидка:накидки]"
    lines[#lines+1]="[UBSTEP:0]"
    lines[#lines+1]="[LBSTEP:0]"
    lines[#lines+1]="[LAYER:COVER]"
    lines[#lines+1]="[COVERAGE:50]"
    lines[#lines+1]="[LAYER_SIZE:10]"
    lines[#lines+1]="[LAYER_PERMIT:300]"
    lines[#lines+1]="[MATERIAL_SIZE:3]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:ARMOR_CAPE]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.armor.gen.vest=function()
    local lines={}
    lines[#lines+1]="[NAME:жилет:жилеты]"
    lines[#lines+1]="[UBSTEP:0]"
    lines[#lines+1]="[LBSTEP:0]"
    lines[#lines+1]="[LAYER:OVER]"
    lines[#lines+1]="[COVERAGE:50]"
    lines[#lines+1]="[LAYER_SIZE:10]"
    lines[#lines+1]="[LAYER_PERMIT:50]"
    lines[#lines+1]="[MATERIAL_SIZE:2]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:ARMOR_VEST]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.armor.gen.dress=function()
    local lines={}
    lines[#lines+1]="[NAME:їлатье:їлатья]"
    lines[#lines+1]="[UBSTEP:MAX]"
    lines[#lines+1]="[LBSTEP:MAX]"
    lines[#lines+1]="[LAYER:UNDER]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:10]"
    lines[#lines+1]="[LAYER_PERMIT:50]"
    lines[#lines+1]="[MATERIAL_SIZE:5]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:ARMOR_DRESS]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.armor.gen.robe=function()
    local lines={}
    lines[#lines+1]="[NAME:мантия:мантии]"
    lines[#lines+1]="[UBSTEP:MAX]"
    lines[#lines+1]="[LBSTEP:MAX]"
    lines[#lines+1]="[LAYER:OVER]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:20]"
    lines[#lines+1]="[LAYER_PERMIT:100]"
    lines[#lines+1]="[MATERIAL_SIZE:6]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:ARMOR_ROBE]"
    return {raws=lines,weight=1}
end

angel_item_info.armor.helm.gen.helm=function()
    local lines={}
    lines[#lines+1]="[NAME:шлем:шлемы]"
    lines[#lines+1]="[ARMORLEVEL:1]"
    lines[#lines+1]="[METAL_ARMOR_LEVELS]"
    lines[#lines+1]="[SHAPED]"
    lines[#lines+1]="[LAYER:ARMOR]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:30]"
    lines[#lines+1]="[LAYER_PERMIT:20]"
    lines[#lines+1]="[MATERIAL_SIZE:2]"
    lines[#lines+1]="[BARRED]"
    lines[#lines+1]="[SCALED]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[SHAPED]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:HELM_HELM]"
    return {raws=lines,weight=1}
end

angel_item_info.armor.helm.gen.cap=function()
    local lines={}
    lines[#lines+1]="[NAME:шаїка:шаїки]"
    lines[#lines+1]="[METAL_ARMOR_LEVELS]"
    lines[#lines+1]="[LAYER:OVER]"
    lines[#lines+1]="[COVERAGE:50]"
    lines[#lines+1]="[LAYER_SIZE:10]"
    lines[#lines+1]="[LAYER_PERMIT:15]"
    lines[#lines+1]="[MATERIAL_SIZE:1]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[HARD]"
    lines[#lines+1]="[METAL]"
    lines[#lines+1]="[SHAPED]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:HELM_CAP]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.helm.gen.hood=function()
    local lines={}
    lines[#lines+1]="[NAME:каїюшЇн:каїюшЇны]"
    lines[#lines+1]="[LAYER:COVER]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:10]"
    lines[#lines+1]="[LAYER_PERMIT:100]"
    lines[#lines+1]="[MATERIAL_SIZE:2]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:HELM_HOOD]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.helm.gen.turban=function()
    local lines={}
    lines[#lines+1]="[NAME:тюрбан:тюрбаны]"
    lines[#lines+1]="[LAYER:OVER]"
    lines[#lines+1]="[COVERAGE:50]"
    lines[#lines+1]="[LAYER_SIZE:20]"
    lines[#lines+1]="[LAYER_PERMIT:100]"
    lines[#lines+1]="[MATERIAL_SIZE:2]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:HELM_TURBAN]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.helm.gen.mask=function()
    local lines={}
    lines[#lines+1]="[NAME:маска:маски]"
    lines[#lines+1]="[LAYER:UNDER]"
    lines[#lines+1]="[COVERAGE:50]"
    lines[#lines+1]="[LAYER_SIZE:20]"
    lines[#lines+1]="[LAYER_PERMIT:10]"
    lines[#lines+1]="[MATERIAL_SIZE:2]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[HARD]"
    lines[#lines+1]="[METAL]"
    lines[#lines+1]="[BARRED]"
    lines[#lines+1]="[SCALED]"
    lines[#lines+1]="[SHAPED]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:HELM_MASK]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.helm.gen.veil_head=function()
    local lines={}
    lines[#lines+1]="[NAME:їЇкрывалЇ:їЇкрывала]"
    lines[#lines+1]="[LAYER:OVER]"
    lines[#lines+1]="[COVERAGE:50]"
    lines[#lines+1]="[LAYER_SIZE:10]"
    lines[#lines+1]="[LAYER_PERMIT:100]"
    lines[#lines+1]="[MATERIAL_SIZE:2]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:HELM_VEIL_HEAD]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.helm.gen.veil_face=function()
    local lines={}
    lines[#lines+1]="[NAME:вуаль:вуали]"
    lines[#lines+1]="[LAYER:UNDER]"
    lines[#lines+1]="[COVERAGE:50]"
    lines[#lines+1]="[LAYER_SIZE:10]"
    lines[#lines+1]="[LAYER_PERMIT:100]"
    lines[#lines+1]="[MATERIAL_SIZE:2]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:HELM_VEIL_FACE]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.helm.gen.headscarf=function()
    local lines={}
    lines[#lines+1]="[NAME:їлатЇк:їлатки]"
    lines[#lines+1]="[LAYER:OVER]"
    lines[#lines+1]="[COVERAGE:50]"
    lines[#lines+1]="[LAYER_SIZE:10]"
    lines[#lines+1]="[LAYER_PERMIT:100]"
    lines[#lines+1]="[MATERIAL_SIZE:2]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:HELM_HEADSCARF]"
    return {raws=lines,weight=1}
end

angel_item_info.armor.gloves.gen.gauntlet=function()
    local lines={}
    lines[#lines+1]="[NAME:латная рукавица:латные рукавицы]"
    lines[#lines+1]="[ARMORLEVEL:2]"
    lines[#lines+1]="[UPSTEP:1]"
    lines[#lines+1]="[SHAPED]"
    lines[#lines+1]="[LAYER:ARMOR]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:20]"
    lines[#lines+1]="[LAYER_PERMIT:15]"
    lines[#lines+1]="[MATERIAL_SIZE:2]"
    lines[#lines+1]="[SCALED]"
    lines[#lines+1]="[BARRED]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:GLOVES_GAUNTLET]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.gloves.gen.glove=function()
    local lines={}
    lines[#lines+1]="[NAME:їерчатка:їерчатки]"
    lines[#lines+1]="[MATERIAL_SIZE:1]"
    lines[#lines+1]="[LAYER:UNDER]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:10]"
    lines[#lines+1]="[LAYER_PERMIT:10]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:GLOVES_GLOVE]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.gloves.gen.mitten=function()
    local lines={}
    lines[#lines+1]="[NAME:варежка:варежки]"
    lines[#lines+1]="[LAYER:COVER]"
    lines[#lines+1]="[COVERAGE:150]"
    lines[#lines+1]="[LAYER_SIZE:15]"
    lines[#lines+1]="[LAYER_PERMIT:20]"
    lines[#lines+1]="[MATERIAL_SIZE:1]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:GLOVES_MITTEN]"
    return {raws=lines,weight=1}
end

angel_item_info.armor.shoes.gen.boots_high=function()
    local lines={}
    lines[#lines+1]="[NAME:саїЇг:саїЇги]"
    lines[#lines+1]="[ARMORLEVEL:1]"
    lines[#lines+1]="[UPSTEP:1]"
    lines[#lines+1]="[METAL_ARMOR_LEVELS]"
    lines[#lines+1]="[LAYER:OVER]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:25]"
    lines[#lines+1]="[LAYER_PERMIT:15]"
    lines[#lines+1]="[MATERIAL_SIZE:2]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:SHOES_BOOT_HIGH]"
    return {raws=lines,weight=1}
end

angel_item_info.armor.shoes.gen.boots_low=function()
    local lines={}
    lines[#lines+1]="[NAME:бЇтинЇк:бЇтинки]"
    lines[#lines+1]="[ARMORLEVEL:1]"
    lines[#lines+1]="[METAL_ARMOR_LEVELS]"
    lines[#lines+1]="[LAYER:OVER]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:25]"
    lines[#lines+1]="[LAYER_PERMIT:15]"
    lines[#lines+1]="[MATERIAL_SIZE:1]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:SHOES_BOOT_LOW]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.shoes.gen.shoes=function()
    local lines={}
    lines[#lines+1]="[NAME:башмак:башмаки]"
    lines[#lines+1]="[LAYER:OVER]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:20]"
    lines[#lines+1]="[LAYER_PERMIT:15]"
    lines[#lines+1]="[MATERIAL_SIZE:1]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:SHOES_SHOE]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.shoes.gen.sandals=function()
    local lines={}
    lines[#lines+1]="[NAME:сандалия:сандалии]"
    lines[#lines+1]="[LAYER:OVER]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:25]"
    lines[#lines+1]="[LAYER_PERMIT:15]"
    lines[#lines+1]="[MATERIAL_SIZE:1]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:SHOES_SANDAL]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.shoes.gen.chausses=function()
    local lines={}
    lines[#lines+1]="[NAME:шЇсса:шЇссы]"
    lines[#lines+1]="[UPSTEP:MAX]"
    lines[#lines+1]="[LAYER:UNDER]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:10]"
    lines[#lines+1]="[LAYER_PERMIT:15]"
    lines[#lines+1]="[MATERIAL_SIZE:3]"
    lines[#lines+1]="[LEATHER]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:SHOES_CHAUSSE]"
    return {raws=lines,weight=1}
end

angel_item_info.clothing.shoes.gen.socks=function()
    local lines={}
    lines[#lines+1]="[NAME:нЇсЇк:нЇски]"
    lines[#lines+1]="[LAYER:UNDER]"
    lines[#lines+1]="[COVERAGE:100]"
    lines[#lines+1]="[LAYER_SIZE:10]"
    lines[#lines+1]="[LAYER_PERMIT:15]"
    lines[#lines+1]="[MATERIAL_SIZE:1]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:SHOES_SOCK]"
    return {raws=lines,weight=1}
end

local function make_sword_func(name)
    return function()
        local lines={}
        lines[#lines+1]="[NAME:"..name.."]"
        lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.weapon.SWORD.adj).."]"
        lines[#lines+1]="[SIZE:300]"
        lines[#lines+1]="[SKILL:SWORD]"
        lines[#lines+1]="[TWO_HANDED:37500]"
        lines[#lines+1]="[MINIMUM_SIZE:32500]"
        lines[#lines+1]="[MATERIAL_SIZE:3]"
        lines[#lines+1]="[ATTACK:EDGE:20000:4000:їЇлЇсуете:їЇлЇсует:NO_SUB:1250]"
        lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
        lines[#lines+1]="[ATTACK:EDGE:50:2000:кЇлете:кЇлет:NO_SUB:1000]"
        lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
        lines[#lines+1]="[ATTACK:BLUNT:20000:4000:шлєїаете:шлєїает:їлЇская стЇрЇна:1250]"
        lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
        lines[#lines+1]="[ATTACK:BLUNT:100:1000:ударяете:ударяет:навершие:1000]"
        lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
        lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:WEAPON_SWORD]"
        return {raws=lines,weight=1}
    end
end

angel_item_info.weapon.SWORD.gen.sword=make_sword_func("меч:мечи")

angel_item_info.weapon.SWORD.gen.blade=make_sword_func("клинЇк:клинки")

angel_item_info.weapon.PIKE.gen.pike=function()
    local lines={}
    lines[#lines+1]="[NAME:їика:їики]"
    lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.weapon.PIKE.adj).."]"
    lines[#lines+1]="[SIZE:800]"
    lines[#lines+1]="[SKILL:PIKE]"
    lines[#lines+1]="[TWO_HANDED:77500]"
    lines[#lines+1]="[MINIMUM_SIZE:62500]"
    lines[#lines+1]="[MATERIAL_SIZE:4]"
    lines[#lines+1]="[ATTACK:EDGE:20:12000:кЇлете:кЇлет:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ATTACK:BLUNT:10000:6000:кЇлЇтите:кЇлЇтит:древкЇ:1250]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:WEAPON_PIKE]"
    return {raws=lines,weight=1}
end

local function make_whip_func(name)
    return function()
        local lines={}
        lines[#lines+1]="[NAME:"..name.."]"
        lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.weapon.WHIP.adj).."]"
        lines[#lines+1]="[SIZE:300]"
        lines[#lines+1]="[SKILL:WHIP]"
        lines[#lines+1]="[TWO_HANDED:27500]"
        lines[#lines+1]="[MINIMUM_SIZE:22500]"
        lines[#lines+1]="[MATERIAL_SIZE:1]"
        lines[#lines+1]="[ATTACK:BLUNT:1:10:хлещете:хлещет:NO_SUB:5000]"
        lines[#lines+1]="[ATTACK_PREPARE_AND_RECOVER:4:4]"
        lines[#lines+1]="[ATTACK_FLAG_BAD_MULTIATTACK]"
        lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:WEAPON_WHIP]"
        return {raws=lines,weight=1}
    end
end

angel_item_info.weapon.WHIP.gen.whip=make_whip_func("хлыст:хлысты")

angel_item_info.weapon.WHIP.gen.lash=make_whip_func("бич:бичи")

angel_item_info.weapon.WHIP.gen.scourge=function()
    local lines={}
    lines[#lines+1]="[NAME:їлеть:їлети]"
    lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.weapon.WHIP.adj).."]"
    lines[#lines+1]="[SIZE:300]"
    lines[#lines+1]="[SKILL:WHIP]"
    lines[#lines+1]="[TWO_HANDED:27500]"
    lines[#lines+1]="[MINIMUM_SIZE:22500]"
    lines[#lines+1]="[MATERIAL_SIZE:1]"
    lines[#lines+1]="[ATTACK:EDGE:10:50:хлещете:хлещет:NO_SUB:2000]"
    lines[#lines+1]="[ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ATTACK_FLAG_BAD_MULTIATTACK]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:WEAPON_SCOURGE]"
    return {raws=lines,weight=1}
end

-- if you want your angels to use a totally different kind of arrow, you're totally allowed to do that,
-- which is why there's this whole arrow table
angel_item_info.ammo.ARROW.thin=function()
    local lines={}
    lines[#lines+1]="[NAME:стрела:стрелы]"
    lines[#lines+1]="[ADJECTIVE:тЇнкий]"
    lines[#lines+1]="[CLASS:ARROW]"
    lines[#lines+1]="[SIZE:150]"
    lines[#lines+1]="[ATTACK:EDGE:4:1000:кЇлете:кЇлет:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:AMMO_ARROW]"
    return {raws=lines,weight=1}
end

angel_item_info.ammo.ARROW.jagged=function()
    local lines={}
    lines[#lines+1]="[NAME:стрела:стрелы]"
    lines[#lines+1]="[ADJECTIVE:зазубренный]"
    lines[#lines+1]="[CLASS:ARROW]"
    lines[#lines+1]="[SIZE:150]"
    lines[#lines+1]="[ATTACK:EDGE:5:1000:кЇлете:кЇлет:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:AMMO_ARROW]"
    return {raws=lines,weight=1}
end

angel_item_info.ammo.ARROW.wide_headed=function()
    local lines={}
    lines[#lines+1]="[NAME:стрела:стрелы]"
    lines[#lines+1]="[ADJECTIVE:ширЇкЇгЇлЇвый]"
    lines[#lines+1]="[CLASS:ARROW]"
    lines[#lines+1]="[SIZE:150]"
    lines[#lines+1]="[ATTACK:EDGE:100:1000:кЇлете:кЇлет:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:AMMO_ARROW]"
    return {raws=lines,weight=1}
end

angel_item_info.ammo.ARROW.cone_headed=function()
    local lines={}
    lines[#lines+1]="[NAME:стрела:стрелы]"
    lines[#lines+1]="[ADJECTIVE:кЇнусЇгЇлЇвый]"
    lines[#lines+1]="[CLASS:ARROW]"
    lines[#lines+1]="[SIZE:175]"
    lines[#lines+1]="[ATTACK:EDGE:50:1000:кЇлете:кЇлет:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:AMMO_ARROW]"
    return {raws=lines,weight=1}
end

angel_item_info.weapon.BOW.gen.bow=function(i,prefix)
    local lines={}
    lines[#lines+1]="[NAME:лук:луки]"
    lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.weapon.BOW.adj).."]"
    lines[#lines+1]="[SIZE:300]"
    lines[#lines+1]="[SKILL:SWORD]"
    lines[#lines+1]="[RANGED:BOW:ARROW]"
    lines[#lines+1]="[AIM_DIFFICULTY:5]"
    lines[#lines+1]="[NOCKED:20:7]"
    lines[#lines+1]="[INITIATE_SHOT_TIME:1]"
    lines[#lines+1]="[SHOT_RECOVERY_TIME:0]"
    lines[#lines+1]="[SHOOT_FORCE:1000]"
    lines[#lines+1]="[SHOT_FORCE_REQUIRES:STRENGTH:1500]"
    lines[#lines+1]="[SHOT_FORCE_REQUIRES:BOW:15]"
    lines[#lines+1]="[SHOOT_MAXVEL:200]"
    lines[#lines+1]="[TWO_HANDED:0]"
    lines[#lines+1]="[MINIMUM_SIZE:15000]"
    lines[#lines+1]="[MATERIAL_SIZE:3]"
    lines[#lines+1]="[ATTACK:BLUNT:10000:4000:кЇлЇтите:кЇлЇтит:NO_SUB:1250]"
        lines[#lines+1]="[ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:WEAPON_BOW]"
    lines[#lines+1]="[ITEM_AMMO:"..prefix.."WP_A"..tostring(i).."]"
    add_generated_info(lines)
    local g=generate_from_list(angel_item_info.ammo.ARROW)
    local generated_tbl=g.raws or g.item
    table_merge(lines,generated_tbl)
    return {raws=lines,weight=1}
end

angel_item_info.ammo.BOLT.short=function()
    local lines={}
    lines[#lines+1]="[NAME:бЇлт:бЇлты]"
    lines[#lines+1]="[ADJECTIVE:кЇрЇткий]"
    lines[#lines+1]="[CLASS:BOLT]"
    lines[#lines+1]="[SIZE:125]"
    lines[#lines+1]="[ATTACK:EDGE:5:500:кЇлете:кЇлет:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:AMMO_BOLT]"
    return {raws=lines,weight=1}
end

angel_item_info.ammo.BOLT.long=function()
    local lines={}
    lines[#lines+1]="[NAME:бЇлт:бЇлты]"
    lines[#lines+1]="[ADJECTIVE:длинный]"
    lines[#lines+1]="[CLASS:BOLT]"
    lines[#lines+1]="[SIZE:175]"
    lines[#lines+1]="[ATTACK:EDGE:5:1000:кЇлете:кЇлет:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:AMMO_BOLT]"
    return {raws=lines,weight=1}
end

angel_item_info.ammo.BOLT.jagged=function()
    local lines={}
    lines[#lines+1]="[NAME:бЇлт:бЇлты]"
    lines[#lines+1]="[ADJECTIVE:зазубренный]"
    lines[#lines+1]="[CLASS:BOLT]"
    lines[#lines+1]="[SIZE:150]"
    lines[#lines+1]="[ATTACK:EDGE:10:1000:кЇлете:кЇлет:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:AMMO_BOLT]"
    return {raws=lines,weight=1}
end

angel_item_info.ammo.BOLT.thin=function()
    local lines={}
    lines[#lines+1]="[NAME:бЇлт:бЇлты]"
    lines[#lines+1]="[ADJECTIVE:тЇнкий]"
    lines[#lines+1]="[CLASS:BOLT]"
    lines[#lines+1]="[SIZE:150]"
    lines[#lines+1]="[ATTACK:EDGE:3:1500:кЇлете:кЇлет:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:AMMO_BOLT]"
    return {raws=lines,weight=1}
end

angel_item_info.weapon.CROSSBOW.gen.crossbow=function(i,prefix)
    local lines={}
    lines[#lines+1]="[NAME:арбалет:арбалеты]"
    lines[#lines+1]="[SIZE:400]"
    lines[#lines+1]="[SKILL:HAMMER]"
    lines[#lines+1]="[RANGED:CROSSBOW:BOLT]"
    lines[#lines+1]="[AIM_DIFFICULTY:2]"
    lines[#lines+1]="[LOADED:30:7]"
    lines[#lines+1]="[INITIATE_SHOT_TIME:1]"
    lines[#lines+1]="[SHOT_RECOVERY_TIME:0]"
    lines[#lines+1]="[SHOOT_FORCE:1000]"
    lines[#lines+1]="[SHOOT_MAXVEL:200]"
    lines[#lines+1]="[TWO_HANDED:0]"
    lines[#lines+1]="[MINIMUM_SIZE:15000]"
    lines[#lines+1]="[MATERIAL_SIZE:3]"
    lines[#lines+1]="[ATTACK:BLUNT:10000:4000:кЇлЇтите:кЇлЇтит:NO_SUB:1250]"
        lines[#lines+1]="[ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:WEAPON_CROSSBOW]"
    lines[#lines+1]="[ITEM_AMMO:"..prefix.."WP_A"..tostring(i).."]"
    add_generated_info(lines)
    local g=generate_from_list(angel_item_info.ammo.BOLT)
    local generated_tbl=g.raws or g.item
    table_merge(lines,generated_tbl)
    return {raws=lines,weight=1}
end

angel_item_info.ammo.BLOWDART.narrow=function()
    local lines={}
    lines[#lines+1]="[NAME:дрЇтик:дрЇтики]"
    lines[#lines+1]="[ADJECTIVE:узкий]"
    lines[#lines+1]="[CLASS:BLOWDART]"
    lines[#lines+1]="[SIZE:20]"
    lines[#lines+1]="[ATTACK:EDGE:1:50:втыкаете:втыкает:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:AMMO_BLOWDART]"
    return {raws=lines,weight=1}
end

angel_item_info.ammo.BLOWDART.thick=function()
    local lines={}
    lines[#lines+1]="[NAME:дрЇтик:дрЇтики]"
    lines[#lines+1]="[ADJECTIVE:тЇлстый]"
    lines[#lines+1]="[CLASS:BLOWDART]"
    lines[#lines+1]="[SIZE:40]"
    lines[#lines+1]="[ATTACK:EDGE:2:50:втыкаете:втыкает:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:AMMO_BLOWDART]"
    return {raws=lines,weight=1}
end

angel_item_info.ammo.BLOWDART.tapered=function()
    local lines={}
    lines[#lines+1]="[NAME:дрЇтик:дрЇтики]"
    lines[#lines+1]="[ADJECTIVE:узкий]"
    lines[#lines+1]="[CLASS:BLOWDART]"
    lines[#lines+1]="[SIZE:30]"
    lines[#lines+1]="[ATTACK:EDGE:1:50:втыкаете:втыкает:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:AMMO_BLOWDART]"
    return {raws=lines,weight=1}
end

angel_item_info.ammo.BLOWDART.double=function()
    local lines={}
    lines[#lines+1]="[NAME:дрЇтик:дрЇтики]"
    lines[#lines+1]="[ADJECTIVE:двуЇстрый]"
    lines[#lines+1]="[CLASS:BLOWDART]"
    lines[#lines+1]="[SIZE:25]"
    lines[#lines+1]="[ATTACK:EDGE:2:50:втыкаете:втыкает:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:AMMO_BLOWDART]"
    return {raws=lines,weight=1}
end

angel_item_info.weapon.BLOWGUN.gen.blowgun=function(i,prefix)
    local lines={}
    lines[#lines+1]="[NAME:духЇвая трубка:духЇвые трубки]"
    lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.weapon.BOW.adj).."]"
    lines[#lines+1]="[SIZE:150]"
    lines[#lines+1]="[SKILL:SWORD]"
    lines[#lines+1]="[RANGED:BLOWGUN:BLOWDART]"
    lines[#lines+1]="[AIM_DIFFICULTY:5]"
    lines[#lines+1]="[LOADED:10:5]"
    lines[#lines+1]="[INITIATE_SHOT_TIME:5]"
    lines[#lines+1]="[SHOT_RECOVERY_TIME:0]"
    lines[#lines+1]="[SHOOT_FORCE:100]"
    lines[#lines+1]="[SHOT_FORCE_REQUIRES:ENDURANCE:1500]"
    lines[#lines+1]="[SHOT_FORCE_REQUIRES:BLOWGUN:15]"
    lines[#lines+1]="[SHOOT_MAXVEL:1000]"
    lines[#lines+1]="[TWO_HANDED:0]"
    lines[#lines+1]="[MINIMUM_SIZE:5000]"
    lines[#lines+1]="[MATERIAL_SIZE:2]"
    lines[#lines+1]="[ATTACK:BLUNT:10000:4000:кЇлЇтите:кЇлЇтит:NO_SUB:1250]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:WEAPON_BLOWGUN]"
    lines[#lines+1]="[ITEM_AMMO:"..prefix.."WP_A"..tostring(i).."]"
    add_generated_info(lines)
    local g=generate_from_list(angel_item_info.ammo.BLOWDART)
    local generated_tbl=g.raws or g.item
    table_merge(lines,generated_tbl)
    return {raws=lines,weight=1}
end

angel_item_info.weapon.AXE.gen.battle=function(i,prefix)
    local lines={}
    lines[#lines+1]="[NAME:бЇевЇй тЇїЇр:бЇевые тЇїЇры]"
    lines[#lines+1]="[SIZE:800]"
    lines[#lines+1]="[SKILL:AXE]"
    lines[#lines+1]="[TWO_HANDED:47500]"
    lines[#lines+1]="[MINIMUM_SIZE:42500]"
    lines[#lines+1]="[MATERIAL_SIZE:4]"
    lines[#lines+1]="[ATTACK:EDGE:40000:6000:рубите:рубит:NO_SUB:1250]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ATTACK:BLUNT:40000:6000:шлєїаете:шлєїает:їлЇская стЇрЇна:1250]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ATTACK:BLUNT:100:1000:ударяете:ударяет:навершие:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.weapon.AXE.adj).."]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:WEAPON_BATTLE_AXE]"
    return {raws=lines,weight=1}
end

angel_item_info.weapon.AXE.gen.halberd=function(i,prefix)
    local lines={}
    lines[#lines+1]="[NAME:алебарда:алебарды]"
    lines[#lines+1]="[SIZE:1200]"
    lines[#lines+1]="[SKILL:AXE]"
    lines[#lines+1]="[TWO_HANDED:77500]"
    lines[#lines+1]="[MINIMUM_SIZE:62500]"
    lines[#lines+1]="[MATERIAL_SIZE:5]"
    lines[#lines+1]="[ATTACK:EDGE:20000:8000:їЇлЇсуете:їЇлЇсует:NO_SUB:1250]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ATTACK:EDGE:50:2000:кЇлете:кЇлет:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ATTACK:BLUNT:20000:6000:кЇлЇтите:кЇлЇтит:древкЇ:1250]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.weapon.AXE.adj).."]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:WEAPON_HALBERD]"
    return {raws=lines,weight=1}
end

angel_item_info.weapon.AXE.gen.great=function(i,prefix)
    local lines={}
    lines[#lines+1]="[NAME:секира:секиры]"
    lines[#lines+1]="[SIZE:1300]"
    lines[#lines+1]="[SKILL:AXE]"
    lines[#lines+1]="[TWO_HANDED:77500]"
    lines[#lines+1]="[MINIMUM_SIZE:62500]"
    lines[#lines+1]="[MATERIAL_SIZE:5]"
    lines[#lines+1]="[ATTACK:EDGE:60000:8000:рубите:рубит:NO_SUB:1250]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ATTACK:BLUNT:60000:8000:шлєїаете:шлєїает:їлЇская стЇрЇна:1250]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ATTACK:BLUNT:100:1000:ударяете:ударяет:навершие:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.weapon.AXE.adj).."]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:WEAPON_GREAT_AXE]"
    return {raws=lines,weight=1}
end

angel_item_info.weapon.DAGGER.gen.dagger=function(i,prefix)
    local lines={}
    lines[#lines+1]="[NAME:кинжал:кинжалы]"
    lines[#lines+1]="[SIZE:200]"
    lines[#lines+1]="[SKILL:DAGGER]"
    lines[#lines+1]="[TWO_HANDED:27500]"
    lines[#lines+1]="[MINIMUM_SIZE:5000]"
    lines[#lines+1]="[MATERIAL_SIZE:1]"
    lines[#lines+1]="[ATTACK:EDGE:1000:800:їЇлЇсуете:їЇлЇсует:NO_SUB:1250]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ATTACK:EDGE:5:1000:кЇлете:кЇлет:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ATTACK:BLUNT:20:600:ударяете:ударяет:навершие:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.weapon.DAGGER.adj).."]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:WEAPON_DAGGER]"
    return {raws=lines,weight=1}
end

angel_item_info.weapon.DAGGER.gen.knife=function(i,prefix)
    local lines={}
    lines[#lines+1]="[NAME:нЇж:нЇжи]"
    lines[#lines+1]="[SIZE:200]"
    lines[#lines+1]="[SKILL:DAGGER]"
    lines[#lines+1]="[TWO_HANDED:27500]"
    lines[#lines+1]="[MINIMUM_SIZE:5000]"
    lines[#lines+1]="[MATERIAL_SIZE:1]"
    lines[#lines+1]="[ATTACK:EDGE:1000:800:їЇлЇсуете:їЇлЇсует:NO_SUB:1250]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ATTACK:EDGE:5:1000:кЇлете:кЇлет:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.weapon.DAGGER.adj).."]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:WEAPON_DAGGER]"
    return {raws=lines,weight=1}
end

angel_item_info.weapon.DAGGER.gen.nail=function(i,prefix)
    local lines={}
    lines[#lines+1]="[NAME:гвЇздь:гвЇзди]"
    lines[#lines+1]="[SIZE:200]"
    lines[#lines+1]="[SKILL:DAGGER]"
    lines[#lines+1]="[TWO_HANDED:27500]"
    lines[#lines+1]="[MINIMUM_SIZE:5000]"
    lines[#lines+1]="[MATERIAL_SIZE:1]"
    lines[#lines+1]="[ATTACK:EDGE:5:1000:кЇлете:кЇлет:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.weapon.DAGGER.adj).."]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:WEAPON_DAGGER]"
    return {raws=lines,weight=1}
end

angel_item_info.weapon.DAGGER.gen.spike=function(i,prefix)
    local lines={}
    lines[#lines+1]="[NAME:шиї:шиїы]"
    lines[#lines+1]="[SIZE:200]"
    lines[#lines+1]="[SKILL:DAGGER]"
    lines[#lines+1]="[TWO_HANDED:27500]"
    lines[#lines+1]="[MINIMUM_SIZE:5000]"
    lines[#lines+1]="[MATERIAL_SIZE:1]"
    lines[#lines+1]="[ATTACK:EDGE:5:1000:кЇлете:кЇлет:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.weapon.DAGGER.adj).."]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:WEAPON_DAGGER]"
    return {raws=lines,weight=1}
end

angel_item_info.weapon.DAGGER.gen.prong=function(i,prefix)
    local lines={}
    lines[#lines+1]="[NAME:зубец:зубцы]"
    lines[#lines+1]="[SIZE:200]"
    lines[#lines+1]="[SKILL:DAGGER]"
    lines[#lines+1]="[TWO_HANDED:27500]"
    lines[#lines+1]="[MINIMUM_SIZE:5000]"
    lines[#lines+1]="[MATERIAL_SIZE:1]"
    lines[#lines+1]="[ATTACK:EDGE:5:1000:кЇлете:кЇлет:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.weapon.DAGGER.adj).."]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:WEAPON_DAGGER]"
    return {raws=lines,weight=1}
end

angel_item_info.weapon.MACE.gen.mace=function(i,prefix)
    local lines={}
    lines[#lines+1]="[NAME:булава:булавы]"
    lines[#lines+1]="[SIZE:800]"
    lines[#lines+1]="[SKILL:MACE]"
    lines[#lines+1]="[TWO_HANDED:37500]"
    lines[#lines+1]="[MINIMUM_SIZE:32500]"
    lines[#lines+1]="[MATERIAL_SIZE:3]"
    lines[#lines+1]="[ATTACK:BLUNT:20:200:кЇлЇтите:кЇлЇтит:NO_SUB:2000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.weapon.MACE.adj).."]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:WEAPON_MACE]"
    return {raws=lines,weight=1}
end

angel_item_info.weapon.HAMMER.gen.war_hammer=function(i,prefix)
    local lines={}
    lines[#lines+1]="[NAME:бЇевЇй мЇлЇт:бЇевые мЇлЇты]"
    lines[#lines+1]="[SIZE:400]"
    lines[#lines+1]="[SKILL:HAMMER]"
    lines[#lines+1]="[TWO_HANDED:37500]"
    lines[#lines+1]="[MINIMUM_SIZE:32500]"
    lines[#lines+1]="[MATERIAL_SIZE:3]"
    lines[#lines+1]="[ATTACK:BLUNT:10:200:кЇлЇтите:кЇлЇтит:NO_SUB:2000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.weapon.HAMMER.adj).."]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:WEAPON_WAR_HAMMER]"
    return {raws=lines,weight=1}
end

angel_item_info.weapon.HAMMER.gen.maul=function(i,prefix)
    local lines={}
    lines[#lines+1]="[NAME:кувалда:кувалды]"
    lines[#lines+1]="[SIZE:1300]"
    lines[#lines+1]="[SKILL:HAMMER]"
    lines[#lines+1]="[TWO_HANDED:77500]"
    lines[#lines+1]="[MINIMUM_SIZE:62500]"
    lines[#lines+1]="[MATERIAL_SIZE:5]"
    lines[#lines+1]="[ATTACK:BLUNT:100:6000:кЇлЇтите:кЇлЇтит:NO_SUB:2000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.weapon.HAMMER.adj).."]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:WEAPON_MAUL]"
    return {raws=lines,weight=1}
end

angel_item_info.weapon.SPEAR.gen.spear=function(i,prefix)
    local lines={}
    lines[#lines+1]="[NAME:кЇїьє:кЇїья]"
    lines[#lines+1]="[SIZE:400]"
    lines[#lines+1]="[SKILL:SPEAR]"
    lines[#lines+1]="[TWO_HANDED:47500]"
    lines[#lines+1]="[MINIMUM_SIZE:5000]"
    lines[#lines+1]="[MATERIAL_SIZE:3]"
    lines[#lines+1]="[ATTACK:EDGE:20:10000:кЇлете:кЇлет:NO_SUB:1000]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ATTACK:BLUNT:10000:6000:кЇлЇтите:кЇлЇтит:древкЇ:1250]"
    lines[#lines+1]="    [ATTACK_PREPARE_AND_RECOVER:3:3]"
    lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.weapon.SPEAR.adj).."]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:WEAPON_SPEAR]"
    return {raws=lines,weight=1}
end

angel_item_info.shield.gen.shield=function(i,prefix)
    local lines={}
    lines[#lines+1]="[NAME:щит:щиты]"
    lines[#lines+1]="[ARMORLEVEL:2]"
    lines[#lines+1]="[BLOCKCHANCE:20]"
    lines[#lines+1]="[UPSTEP:2]"
    lines[#lines+1]="[MATERIAL_SIZE:4]"
    lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.shield.adj).."]"
    lines[#lines+1]="[PROCEDURAL_ITEM_GRAPHICS:SHIELD_SHIELD]"
    return {raws=lines,weight=1}
end

angel_item_gens={}

angel_item_gens.default=function(prefix,tokens)
    local weapon_num=5
    local shield_num=1
    local a_pants_num=1
    local c_pants_num=1
    local a_armor_num=1
    local c_armor_num=1
    local a_helm_num=1
    local c_helm_num=1
    local a_gloves_num=1
    local c_gloves_num=1
    local a_shoes_num=1
    local c_shoes_num=1
    local lines={}
    local tokens={
        WEAPON={},
        AMMO={},
        SHIELD={},
        ARMOR={},
        HELM={},
        GLOVES={},
        SHOES={},
        PANTS={}
    }
    for i=1,a_pants_num do
        local tok=prefix.."APN"..tostring(i)
        tokens.PANTS[#tokens.PANTS+1]=tok
        lines[#lines+1]="[ITEM_PANTS:"..tok.."]"
        add_generated_info(lines)
        local g=generate_from_list(angel_item_info.armor.pants.gen,i,prefix)
        local generated_tbl=g.item or g.raws
        table_merge(lines,generated_tbl)
        lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.armor.pants.adj).."]"
        lines[#lines+1]="[METAL]"
        lines[#lines+1]="[HARD]"
    end
    for i=1,c_pants_num do
        local tok=prefix.."CPN"..tostring(i)
        tokens.PANTS[#tokens.PANTS+1]=tok
        lines[#lines+1]="[ITEM_PANTS:"..tok.."]"
        add_generated_info(lines)
        local g=generate_from_list(angel_item_info.clothing.pants.gen,i,prefix)
        local generated_tbl=g.item or g.raws
        table_merge(lines,generated_tbl)
        lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.clothing.pants.adj).."]"
        lines[#lines+1]="[SOFT]"
        lines[#lines+1]="[STRUCTURAL_ELASTICITY_WOVEN_THREAD]"
    end
    for i=1,a_armor_num do
        local tok=prefix.."AAR"..tostring(i)
        tokens.ARMOR[#tokens.ARMOR+1]=tok
        lines[#lines+1]="[ITEM_ARMOR:"..tok.."]"
        add_generated_info(lines)
        local g=generate_from_list(angel_item_info.armor.armor.gen,i,prefix)
		local generated_tbl=g.item or g.raws
		table_merge(lines,generated_tbl)
        lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.armor.armor.adj).."]"
        lines[#lines+1]="[HARD]"
        lines[#lines+1]="[METAL]"
    end
    for i=1,c_armor_num do
        local tok=prefix.."CAR"..tostring(i)
        tokens.ARMOR[#tokens.ARMOR+1]=tok
        lines[#lines+1]="[ITEM_ARMOR:"..tok.."]"
        add_generated_info(lines)
        local g=generate_from_list(angel_item_info.clothing.armor.gen,i,prefix)
		local generated_tbl=g.item or g.raws
		table_merge(lines,generated_tbl)
        lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.clothing.armor.adj).."]"
        lines[#lines+1]="[SOFT]"
        lines[#lines+1]="[STRUCTURAL_ELASTICITY_WOVEN_THREAD]"
    end
    for i=1,a_helm_num do
        local tok=prefix.."AHM"..tostring(i)
        tokens.HELM[#tokens.HELM+1]=tok
        lines[#lines+1]="[ITEM_HELM:"..tok.."]"
        add_generated_info(lines)
        local g=generate_from_list(angel_item_info.armor.helm.gen,i,prefix)
		local generated_tbl=g.item or g.raws
		table_merge(lines,generated_tbl)
        lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.armor.helm.adj).."]"
        lines[#lines+1]="[HARD]"
        lines[#lines+1]="[METAL]"
    end
    for i=1,c_helm_num do
        local tok=prefix.."CHM"..tostring(i)
        tokens.HELM[#tokens.HELM+1]=tok
        lines[#lines+1]="[ITEM_HELM:"..tok.."]"
        add_generated_info(lines)
        local g=generate_from_list(angel_item_info.clothing.helm.gen,i,prefix)
		local generated_tbl=g.item or g.raws
		table_merge(lines,generated_tbl)
        lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.clothing.helm.adj).."]"
        lines[#lines+1]="[SOFT]"
        lines[#lines+1]="[STRUCTURAL_ELASTICITY_WOVEN_THREAD]"
    end
    for i=1,a_gloves_num do
        local tok=prefix.."AGL"..tostring(i)
        tokens.GLOVES[#tokens.GLOVES+1]=tok
        lines[#lines+1]="[ITEM_GLOVES:"..tok.."]"
        add_generated_info(lines)
        local g=generate_from_list(angel_item_info.armor.gloves.gen,i,prefix)
		local generated_tbl=g.item or g.raws
		table_merge(lines,generated_tbl)
        lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.armor.gloves.adj).."]"
        lines[#lines+1]="[METAL]"
        lines[#lines+1]="[HARD]"
    end
    for i=1,c_gloves_num do
        local tok=prefix.."CGL"..tostring(i)
        tokens.GLOVES[#tokens.GLOVES+1]=tok
        lines[#lines+1]="[ITEM_GLOVES:"..tok.."]"
        add_generated_info(lines)
        local g=generate_from_list(angel_item_info.clothing.gloves.gen,i,prefix)
		local generated_tbl=g.item or g.raws
		table_merge(lines,generated_tbl)
        lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.clothing.gloves.adj).."]"
        lines[#lines+1]="[SOFT]"
        lines[#lines+1]="[STRUCTURAL_ELASTICITY_WOVEN_THREAD]"
    end
    for i=1,a_shoes_num do
        local tok=prefix.."ASH"..tostring(i)
        tokens.SHOES[#tokens.SHOES+1]=tok
        lines[#lines+1]="[ITEM_SHOES:"..tok.."]"
        add_generated_info(lines)
        local g=generate_from_list(angel_item_info.armor.shoes.gen,i,prefix)
		local generated_tbl=g.item or g.raws
		table_merge(lines,generated_tbl)
        lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.armor.shoes.adj).."]"
        lines[#lines+1]="[METAL]"
        lines[#lines+1]="[HARD]"
    end
    for i=1,c_shoes_num do
        local tok=prefix.."CSH"..tostring(i)
        tokens.SHOES[#tokens.SHOES+1]=tok
        lines[#lines+1]="[ITEM_SHOES:"..tok.."]"
        add_generated_info(lines)
        local g=generate_from_list(angel_item_info.clothing.shoes.gen,i,prefix)
		local generated_tbl=g.item or g.raws
		table_merge(lines,generated_tbl)
        lines[#lines+1]="[ADJECTIVE:"..pick_random(angel_item_info.clothing.shoes.adj).."]"
        lines[#lines+1]="[SOFT]"
        lines[#lines+1]="[STRUCTURAL_ELASTICITY_WOVEN_THREAD]"
    end
    local available_skills={
        "PIKE",
        "WHIP",
        "BOW",
        "BLOWGUN",
        "AXE",
        "SWORD",
        "DAGGER",
        "MACE",
        "HAMMER",
        "SPEAR",
        "CROSSBOW"
    }
    for i=1,weapon_num do
        local tok=prefix.."WP"..tostring(i)
        tokens.WEAPON[#tokens.WEAPON+1]=tok
        lines[#lines+1]="[ITEM_WEAPON:"..tok.."]"
        add_generated_info(lines)
        local skill=pick_random_no_replace(available_skills)
        local g=generate_from_list(angel_item_info.weapon[skill].gen,i,prefix)
		local generated_tbl=g.item or g.raws
		table_merge(lines,generated_tbl)
    end
    for i=1,shield_num do
        local tok=prefix.."SH"..tostring(i)
        tokens.SHIELD[#tokens.SHIELD+1]=tok
        lines[#lines+1]="[ITEM_SHIELD:"..tok.."]"
        add_generated_info(lines)
        local g=generate_from_list(angel_item_info.shield.gen,i,prefix)
		local generated_tbl=g.item or g.raws
		table_merge(lines,generated_tbl)
    end
    return {lines=lines,weight=1,tokens=tokens}
end

local rarityless_items={
    WEAPON=true,
    AMMO=true,
    SHIELD=true
}

entities.vault_guardian.default=function(idx,tok)
    -- first, we have to generate their weird items
    local item_token_prefix=random_object_parameters.token_prefix.."EI"..tostring(idx)
    local item_info=generate_from_list(angel_item_gens,item_token_prefix)
    raws.register_items(item_info.lines)
    local lines={}
    -- put the weird items into the entity
    for k,v in pairs(item_info.tokens) do
        for kk,vv in ipairs(v) do
            lines[#lines+1]="["..k..":"..vv..(rarityless_items[k] and "" or ":COMMON").."]"
        end
    end
    lines[#lines+1]="[DIVINE_MAT_WEAPONS]"
    lines[#lines+1]="[DIVINE_MAT_ARMOR]"
    lines[#lines+1]="[DIVINE_MAT_CRAFTS]"
    lines[#lines+1]="[DIVINE_MAT_CLOTHING]"
    lines[#lines+1]="[CLOTHING]"
    lines[#lines+1]="[TRANSLATION:GEN_DIVINE]"
    return {raws=lines,weight=1}
end

entities.mythical_guardian.default=function(idx,tok)
    local lines={}
    for k,v in ipairs({"WEAPON","AMMO","SHIELD","ARMOR","HELM","GLOVES","SHOES","PANTS"}) do
        for kk,vv in ipairs(world.itemdef[v:lower()]) do
            if not vv.generated then
                lines[#lines+1]="["..v..":"..vv.token..(rarityless_items[v] and "" or ":COMMON").."]"
            end
        end
    end
    lines[#lines+1]="[DIVINE_MAT_WEAPONS]"
    lines[#lines+1]="[DIVINE_MAT_ARMOR]"
    lines[#lines+1]="[DIVINE_MAT_CRAFTS]"
    lines[#lines+1]="[DIVINE_MAT_CLOTHING]"
    lines[#lines+1]="[CLOTHING]"
    lines[#lines+1]="[TRANSLATION:GEN_DIVINE]"
    return {raws=lines,weight=1}
end