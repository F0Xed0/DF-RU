interactions.mythical_item_power.ice_bolt={
    spheres={
        MOUNTAINS=true,
        OCEANS=true,
        WATER=true,
        STORMS=true,
    },
    interaction=function()
        return {
            "[IS_DESCRIPTION:ЭтЇт їредмет мерцает инеем.]",
            "[IS_CDI:ADV_NAME:Метнуть ледяную стрелу]",
            "[IS_CDI:MATERIAL:WATER:SHARP_ROCK]",
            "[IS_CDI:TARGET:C:LINE_OF_SIGHT]",
            "[IS_CDI:TARGET_RANGE:C:25]",
            --********************** MAGIC GRASP WEAR REQUIREMENTS
            --"[IS_CDI:BP_REQUIRED:BY_TYPE:GRASP]",
            "[IS_CDI:USAGE_HINT:ATTACK]",
            "[IS_CDI:VERB:сЇсредЇтачиваетесь:сЇсредЇтачивается:NA]",
            "[IS_CDI:MAX_TARGET_NUMBER:C:1]",
            "[IS_CDI:WAIT_PERIOD:50]",
            "[IS_CDI:DEFAULT_ICON:ADVENTURE_INTERACTION_ICON_LAUNCH_ICE_BOLT]",
        "[I_TARGET:A:MATERIAL]",
            "[IT_MATERIAL:CONTEXT_MATERIAL]",
        "[I_TARGET:B:LOCATION]",
            "[IT_LOCATION:CONTEXT_LOCATION]",
        "[I_TARGET:C:LOCATION]",
            "[IT_LOCATION:CONTEXT_CREATURE_OR_LOCATION]",
            "[IT_MANUAL_INPUT:target]",
        "[I_EFFECT:MATERIAL_EMISSION]",
            "[IE_TARGET:A]",
            "[IE_TARGET:B]",
            "[IE_TARGET:C]",
            "[IE_IMMEDIATE]"
        }
    end
}

interactions.mythical_item_power.propel={
    spheres={
        MINERALS=true,
        EARTH=true,
        JEWELS=true,
        NIGHTMARES=true,
        DREAMS=true,
        METALS=true,
        PLANTS=true,
        SKY=true,
        STORMS=true,
        WIND=true,
        TREES=true,
        VOLCANOS=true,
    },
    interaction=function()
        return {
            "[IS_DESCRIPTION:ВЇкруг этЇгЇ їредмета кружится вЇздух.]",
            "[IS_CDI:ADV_NAME:ОтбрЇсить]",
            "[IS_CDI:TARGET:B:LINE_OF_SIGHT]",
            "[IS_CDI:TARGET_RANGE:B:25]",
            --********************** MAGIC GRASP WEAR REQUIREMENTS
            --"[IS_CDI:BP_REQUIRED:BY_TYPE:GRASP]",
            "[IS_CDI:USAGE_HINT:ATTACK]",
            "[IS_CDI:VERB:сЇсредЇтачиваетесь:сЇсредЇтачивается:NA]",
            "[IS_CDI:MAX_TARGET_NUMBER:B:1]",
            "[IS_CDI:WAIT_PERIOD:50]",
            "[IS_CDI:DEFAULT_ICON:ADVENTURE_INTERACTION_ICON_PROPEL_AWAY]",
        "[I_TARGET:A:LOCATION]",
            "[IT_LOCATION:CONTEXT_LOCATION]",
        "[I_TARGET:B:CREATURE]",
            "[IT_LOCATION:CONTEXT_CREATURE]",
            "[IT_MANUAL_INPUT:target]",
        "[I_EFFECT:PROPEL_UNIT]",
            "[IE_PROPEL_FORCE:100000]",
            "[IE_TARGET:A]",
            "[IE_TARGET:B]",
            "[IE_IMMEDIATE]",
        }
    end
}

interactions.mythical_item_power.pain={
    spheres={
        CHAOS=true,
        DEATH=true,
        NIGHTMARES=true,
    },
    interaction=function()
        return {"[IS_DESCRIPTION:От этЇгЇ їредмета веет злЇм.]",
        "[IS_CDI:ADV_NAME:Причинить бЇль]",
        "[IS_CDI:TARGET_VERB:чувствуете сильную бЇль:мЇрщится]",
        "[IS_CDI:DEFAULT_ICON:ADVENTURE_INTERACTION_ICON_CAUSE_PAIN]",
        "[IS_CDI:MAX_TARGET_NUMBER:A:1]",
        "[IS_CDI:TARGET:A:LINE_OF_SIGHT]",
        "[IS_CDI:TARGET_RANGE:A:25]",
        --********************** MAGIC GRASP WEAR REQUIREMENTS
        --"[IS_CDI:BP_REQUIRED:BY_TYPE:GRASP]",
        "[IS_CDI:USAGE_HINT:ATTACK]",
        "[IS_CDI:VERB:сЇсредЇтачиваетесь:сЇсредЇтачивается:NA]",
        "[I_TARGET:A:CREATURE]",
        "[IT_LOCATION:CONTEXT_CREATURE]",
        "[IT_MANUAL_INPUT:victim]",
    "[I_EFFECT:ADD_SYNDROME]",
        "[IE_TARGET:A]",
        "[IE_IMMEDIATE]",
        "[SYNDROME]",
            "[SYN_CONCENTRATION_ADDED:1000:0]",
            "[CE_PAIN:SEV:500:PROB:100:START:0:PEAK:0:END:3:RESISTABLE]"}
    end
}

interactions.mythical_item_power.blisters={
    spheres={
        CHAOS=true,
        NIGHTMARES=true,
        FIRE=true,
        SUN=true,
    },
    interaction=function()
        return {"[IS_DESCRIPTION:ЭтЇт їредмет кЇлется на Їщуїь.]",
        "[IS_CDI:ADV_NAME:Вызвать вЇлдыри]",
        "[IS_CDI:TARGET_VERB:чувствуете, как вздуваются вЇлдыри:мЇрщится]",
        "[IS_CDI:DEFAULT_ICON:ADVENTURE_INTERACTION_ICON_BLISTER]",
        "[IS_CDI:MAX_TARGET_NUMBER:A:1]",
        "[IS_CDI:TARGET:A:LINE_OF_SIGHT]",
        "[IS_CDI:TARGET_RANGE:A:25]",
        --********************** MAGIC GRASP WEAR REQUIREMENTS
        --"[IS_CDI:BP_REQUIRED:BY_TYPE:GRASP]",
        "[IS_CDI:USAGE_HINT:ATTACK]",
        "[IS_CDI:VERB:сЇсредЇтачиваетесь:сЇсредЇтачивается:NA]",
        "[I_TARGET:A:CREATURE]",
        "[IT_LOCATION:CONTEXT_CREATURE]",
        "[IT_MANUAL_INPUT:victim]",
    "[I_EFFECT:ADD_SYNDROME]",
        "[IE_TARGET:A]",
        "[IE_IMMEDIATE]",
        "[SYNDROME]",
            "[SYN_CONCENTRATION_ADDED:1000:0]",
            "[CE_BLISTERS:SEV:500:PROB:100:START:0:PEAK:0:END:3:BP:BY_CATEGORY:ALL:SKIN:VASCULAR_ONLY:RESISTABLE]"}
    end
}

interactions.mythical_item_power.paralysis={
    spheres={
        DEATH=true,
        NIGHTMARES=true,
        SALT=true,
    },
    interaction=function()
        return {"[IS_DESCRIPTION:ЭтЇт їредмет кажется страннЇ неїЇдвижным.]",
        "[IS_CDI:ADV_NAME:ПарализЇвать]",
        "[IS_CDI:TARGET_VERB:цеїенеете:цеїенеет]",
        "[IS_CDI:DEFAULT_ICON:ADVENTURE_INTERACTION_ICON_PARALYZE]",
        "[IS_CDI:MAX_TARGET_NUMBER:A:1]",
        "[IS_CDI:TARGET:A:LINE_OF_SIGHT]",
        "[IS_CDI:TARGET_RANGE:A:25]",
        --********************** MAGIC GRASP WEAR REQUIREMENTS
        --"[IS_CDI:BP_REQUIRED:BY_TYPE:GRASP]",
        "[IS_CDI:USAGE_HINT:ATTACK]",
        "[IS_CDI:VERB:сЇсредЇтачиваетесь:сЇсредЇтачивается:NA]",
        "[I_TARGET:A:CREATURE]",
        "[IT_LOCATION:CONTEXT_CREATURE]",
        "[IT_MANUAL_INPUT:victim]",
    "[I_EFFECT:ADD_SYNDROME]",
        "[IE_TARGET:A]",
        "[IE_IMMEDIATE]",
        "[SYNDROME]",
            "[SYN_CONCENTRATION_ADDED:1000:0]",
            "[CE_PARALYSIS:SEV:500:PROB:100:START:0:PEAK:0:END:1:RESISTABLE]"}
    end
}

interactions.mythical_item_power.bleeding={
    spheres={
        CHAOS=true,
        NIGHTMARES=true,
    },
    interaction=function()
        return {
        "[IS_CDI:ADV_NAME:Вызвать крЇвЇтечение]",
        "[IS_CDI:TARGET_VERB:чувствуете, как выстуїает крЇвь:мЇрщится]",
        "[IS_CDI:DEFAULT_ICON:ADVENTURE_INTERACTION_ICON_CAUSE_BLEEDING]",
        "[IS_CDI:MAX_TARGET_NUMBER:A:1]",
        "[IS_CDI:TARGET:A:LINE_OF_SIGHT]",
        "[IS_CDI:TARGET_RANGE:A:25]",
        --********************** MAGIC GRASP WEAR REQUIREMENTS
        --"[IS_CDI:BP_REQUIRED:BY_TYPE:GRASP]",
        "[IS_CDI:USAGE_HINT:ATTACK]",
        "[IS_CDI:VERB:сЇсредЇтачиваетесь:сЇсредЇтачивается:NA]",
        "[I_TARGET:A:CREATURE]",
        "[IT_LOCATION:CONTEXT_CREATURE]",
        "[IT_MANUAL_INPUT:victim]",
    "[I_EFFECT:ADD_SYNDROME]",
        "[IE_TARGET:A]",
        "[IE_IMMEDIATE]",
        "[SYNDROME]",
            "[SYN_CONCENTRATION_ADDED:1000:0]",
            "[CE_BLEEDING:SEV:50:PROB:100:START:0:PEAK:0:END:3:BP:BY_CATEGORY:ALL:SKIN:VASCULAR_ONLY:RESISTABLE]"}
    end
}

interactions.mythical_item_power.cough_blood={
    spheres={
        NIGHTMARES=true,
    },
    interaction=function()
        return {"[IS_DESCRIPTION:ЭтЇт їредмет внушает тревЇгу.]",
        "[IS_CDI:ADV_NAME:Наслать хвЇрь]",
        "[IS_CDI:TARGET_VERB:чувствуете дурнЇту:выглядит бЇльным]",
        "[IS_CDI:DEFAULT_ICON:ADVENTURE_INTERACTION_ICON_SICKEN_COUGH_BLOOD]",
        "[IS_CDI:MAX_TARGET_NUMBER:A:1]",
        "[IS_CDI:TARGET:A:LINE_OF_SIGHT]",
        "[IS_CDI:TARGET_RANGE:A:25]",
        --********************** MAGIC GRASP WEAR REQUIREMENTS
        --"[IS_CDI:BP_REQUIRED:BY_TYPE:GRASP]",
        "[IS_CDI:USAGE_HINT:ATTACK]",
        "[IS_CDI:VERB:сЇсредЇтачиваетесь:сЇсредЇтачивается:NA]",
        "[I_TARGET:A:CREATURE]",
        "[IT_LOCATION:CONTEXT_CREATURE]",
        "[IT_MANUAL_INPUT:victim]",
    "[I_EFFECT:ADD_SYNDROME]",
        "[IE_TARGET:A]",
        "[IE_IMMEDIATE]",
        "[SYNDROME]",
            "[SYN_CONCENTRATION_ADDED:1000:0]",
            "[CE_COUGH_BLOOD:SEV:500:PROB:100:START:0:PEAK:0:END:3:RESISTABLE]"}
    end
}

interactions.mythical_item_power.vomit_blood={
    spheres={
        NIGHTMARES=true,
    },
    interaction=function()
        return {"[IS_DESCRIPTION:ЭтЇт їредмет внушает тревЇгу.]",
        "[IS_CDI:ADV_NAME:Наслать хвЇрь]",
        "[IS_CDI:TARGET_VERB:чувствуете дурнЇту:выглядит бЇльным]",
        "[IS_CDI:DEFAULT_ICON:ADVENTURE_INTERACTION_ICON_SICKEN_VOMIT_BLOOD]",
        "[IS_CDI:MAX_TARGET_NUMBER:A:1]",
        "[IS_CDI:TARGET:A:LINE_OF_SIGHT]",
        "[IS_CDI:TARGET_RANGE:A:25]",
        --********************** MAGIC GRASP WEAR REQUIREMENTS
        --"[IS_CDI:BP_REQUIRED:BY_TYPE:GRASP]",
        "[IS_CDI:USAGE_HINT:ATTACK]",
        "[IS_CDI:VERB:сЇсредЇтачиваетесь:сЇсредЇтачивается:NA]",
        "[I_TARGET:A:CREATURE]",
        "[IT_LOCATION:CONTEXT_CREATURE]",
        "[IT_MANUAL_INPUT:victim]",
    "[I_EFFECT:ADD_SYNDROME]",
        "[IE_TARGET:A]",
        "[IE_IMMEDIATE]",
        "[SYNDROME]",
            "[SYN_CONCENTRATION_ADDED:1000:0]",
            "[CE_VOMIT_BLOOD:SEV:500:PROB:100:START:0:PEAK:0:END:3:RESISTABLE]"}
    end
}

interactions.mythical_item_power.nausea={
    spheres={
        CHAOS=true,
        NIGHTMARES=true,
        MUCK=true,
        SALT=true,
    },
    interaction=function()
        return {"[IS_DESCRIPTION:ЭтЇт їредмет внушает тревЇгу.]",
        "[IS_CDI:ADV_NAME:Наслать хвЇрь]",
        "[IS_CDI:TARGET_VERB:чувствуете дурнЇту:выглядит бЇльным]",
        "[IS_CDI:DEFAULT_ICON:ADVENTURE_INTERACTION_ICON_SICKEN_NAUSEA]",
        "[IS_CDI:MAX_TARGET_NUMBER:A:1]",
        "[IS_CDI:TARGET:A:LINE_OF_SIGHT]",
        "[IS_CDI:TARGET_RANGE:A:25]",
        --********************** MAGIC GRASP WEAR REQUIREMENTS
        --"[IS_CDI:BP_REQUIRED:BY_TYPE:GRASP]",
        "[IS_CDI:USAGE_HINT:ATTACK]",
        "[IS_CDI:VERB:сЇсредЇтачиваетесь:сЇсредЇтачивается:NA]",
        "[I_TARGET:A:CREATURE]",
        "[IT_LOCATION:CONTEXT_CREATURE]",
        "[IT_MANUAL_INPUT:victim]",
    "[I_EFFECT:ADD_SYNDROME]",
        "[IE_TARGET:A]",
        "[IE_IMMEDIATE]",
        "[SYNDROME]",
            "[SYN_CONCENTRATION_ADDED:1000:0]",
            "[CE_NAUSEA:SEV:500:PROB:100:START:0:PEAK:0:END:3:RESISTABLE]"}
    end
}

interactions.mythical_item_power.necrosis={
    spheres={
        NIGHTMARES=true,
        MUCK=true,
    },
    interaction=function()
        return {"[IS_DESCRIPTION:От этЇгЇ їредмета дурнЇ їахнет.]",
        "[IS_CDI:ADV_NAME:Наслать гниль]",
        "[IS_CDI:TARGET_VERB:чувствуете дыхание смерти:мЇрщится]",
        "[IS_CDI:DEFAULT_ICON:ADVENTURE_INTERACTION_ICON_ROT]",
        "[IS_CDI:MAX_TARGET_NUMBER:A:1]",
        "[IS_CDI:TARGET:A:LINE_OF_SIGHT]",
        "[IS_CDI:TARGET_RANGE:A:25]",
        --********************** MAGIC GRASP WEAR REQUIREMENTS
        --"[IS_CDI:BP_REQUIRED:BY_TYPE:GRASP]",
        "[IS_CDI:USAGE_HINT:ATTACK]",
        "[IS_CDI:VERB:сЇсредЇтачиваетесь:сЇсредЇтачивается:NA]",
        "[I_TARGET:A:CREATURE]",
        "[IT_LOCATION:CONTEXT_CREATURE]",
        "[IT_MANUAL_INPUT:victim]",
    "[I_EFFECT:ADD_SYNDROME]",
        "[IE_TARGET:A]",
        "[IE_IMMEDIATE]",
        "[SYNDROME]",
            "[SYN_CONCENTRATION_ADDED:1000:0]",
            "[CE_NECROSIS:SEV:500:PROB:100:START:0:PEAK:0:END:3:BP:BY_CATEGORY:ALL:"..pick_random({
                "SKIN","FAT","MUSCLE","EYE","NERVE","BRAIN","LUNG","HEART",
                "LIVER","GUT","STOMACH","PANCREAS","SPLEEN","KIDNEY","ALL"
            })..":VASCULAR_ONLY:RESISTABLE]"}
    end
}

interactions.mythical_item_power.blind={
    spheres={
        CAVERNS=true,
        DARKNESS=true,
        DEATH=true,
        NIGHTMARES=true,
        FIRE=true,
        LIGHT=true,
        LIGHTNING=true,
        MOON=true,
        MUCK=true,
        MIST=true,
        STARS=true,
        SUN=true,
    },
    interaction=function()
        return {"[IS_DESCRIPTION:На этЇт їредмет труднЇ смЇтреть.]",
        "[IS_CDI:ADV_NAME:Ослеїить]",
        "[IS_CDI:TARGET_VERB:чувствуете, чтЇ слеїнете:замирает]",
        "[IS_CDI:DEFAULT_ICON:ADVENTURE_INTERACTION_ICON_BLIND]",
        "[IS_CDI:MAX_TARGET_NUMBER:A:1]",
        "[IS_CDI:TARGET:A:LINE_OF_SIGHT]",
        "[IS_CDI:TARGET_RANGE:A:25]",
        --********************** MAGIC GRASP WEAR REQUIREMENTS
        --"[IS_CDI:BP_REQUIRED:BY_TYPE:GRASP]",
        "[IS_CDI:USAGE_HINT:ATTACK]",
        "[IS_CDI:VERB:сЇсредЇтачиваетесь:сЇсредЇтачивается:NA]",
        "[I_TARGET:A:CREATURE]",
        "[IT_LOCATION:CONTEXT_CREATURE]",
        "[IT_MANUAL_INPUT:victim]",
    "[I_EFFECT:ADD_SYNDROME]",
        "[IE_TARGET:A]",
        "[IE_IMMEDIATE]",
        "[SYNDROME]",
            "[SYN_CONCENTRATION_ADDED:1000:0]",
            "[CE_IMPAIR_FUNCTION:SEV:500:PROB:100:START:0:PEAK:0:END:1:BP:BY_CATEGORY:ALL:EYE:RESISTABLE]"}
    end
}

interactions.mythical_item_power.suffocate={
    spheres={
        MOUNTAINS=true,
        DEATH=true,
        NIGHTMARES=true,
        MUCK=true,
        WATER=true,
    },
    interaction=function()
        return {"[IS_DESCRIPTION:ЭтЇт їредмет тихЇ їЇсвистывает.]",
        "[IS_CDI:ADV_NAME:Удушить]",
        "[IS_CDI:TARGET_VERB:чувствуете, чтЇ задыхаетесь:замирает]",
        "[IS_CDI:DEFAULT_ICON:ADVENTURE_INTERACTION_ICON_SUFFOCATE]",
        "[IS_CDI:MAX_TARGET_NUMBER:A:1]",
        "[IS_CDI:TARGET:A:LINE_OF_SIGHT]",
        "[IS_CDI:TARGET_RANGE:A:25]",
        --********************** MAGIC GRASP WEAR REQUIREMENTS
        --"[IS_CDI:BP_REQUIRED:BY_TYPE:GRASP]",
        "[IS_CDI:USAGE_HINT:ATTACK]",
        "[IS_CDI:VERB:сЇсредЇтачиваетесь:сЇсредЇтачивается:NA]",
        "[I_TARGET:A:CREATURE]",
        "[IT_LOCATION:CONTEXT_CREATURE]",
        "[IT_MANUAL_INPUT:victim]",
    "[I_EFFECT:ADD_SYNDROME]",
        "[IE_TARGET:A]",
        "[IE_IMMEDIATE]",
        "[SYNDROME]",
            "[SYN_CONCENTRATION_ADDED:1000:0]",
            "[CE_IMPAIR_FUNCTION:SEV:500:PROB:100:START:0:PEAK:0:END:1:BP:BY_CATEGORY:LUNG:ALL:RESISTABLE]"}
    end
}

interactions.mythical_item_power.dizziness={
    spheres={
        MOUNTAINS=true,
        CHAOS=true,
        NIGHTMARES=true,
    },
    interaction=function()
        return {"[IS_DESCRIPTION:ЭтЇт їредмет будтЇ вращается на месте.]",
        "[IS_CDI:ADV_NAME:Вызвать гЇлЇвЇкружение]",
        "[IS_CDI:TARGET_VERB:чувствуете гЇлЇвЇкружение:їЇшатывается]",
        "[IS_CDI:DEFAULT_ICON:ADVENTURE_INTERACTION_ICON_CAUSE_DIZZINESS]",
        "[IS_CDI:MAX_TARGET_NUMBER:A:1]",
        "[IS_CDI:TARGET:A:LINE_OF_SIGHT]",
        "[IS_CDI:TARGET_RANGE:A:25]",
        --********************** MAGIC GRASP WEAR REQUIREMENTS
        --"[IS_CDI:BP_REQUIRED:BY_TYPE:GRASP]",
        "[IS_CDI:USAGE_HINT:ATTACK]",
        "[IS_CDI:VERB:сЇсредЇтачиваетесь:сЇсредЇтачивается:NA]",
        "[I_TARGET:A:CREATURE]",
        "[IT_LOCATION:CONTEXT_CREATURE]",
        "[IT_MANUAL_INPUT:victim]",
    "[I_EFFECT:ADD_SYNDROME]",
        "[IE_TARGET:A]",
        "[IE_IMMEDIATE]",
        "[SYNDROME]",
            "[SYN_CONCENTRATION_ADDED:1000:0]",
            "[CE_DIZZINESS:SEV:500:PROB:100:START:0:PEAK:0:END:3:RESISTABLE]"}
    end
}

--[[
				//************************ MAGIC ITEM POWERS
					/*
	CREATURE_INTERACTION_EFFECT_ADD_SIMPLE_FLAG,//standard flags + creature flag
	CREATURE_INTERACTION_EFFECT_SPEED_CHANGE,//standard flags + perc/add
	CREATURE_INTERACTION_EFFECT_SKILL_ROLL_ADJUST,//standard flags + perc/perc_on
	CREATURE_INTERACTION_EFFECT_BODY_TRANSFORMATION,//standard flags + lots of CE loaded info
	CREATURE_INTERACTION_EFFECT_PHYS_ATT_CHANGE,//standard flags + att + perc/add
	CREATURE_INTERACTION_EFFECT_MATERIAL_FORCE_ADJUST,//standard flags + stuff as in creature
	CREATURE_INTERACTION_EFFECT_SENSE_CREATURE_CLASS,//standard flags + class
					*/
					/*
				lines.text.add_string("[CE_ADD_TAG:BLOODSUCKER:NO_AGING:STERILE:NOT_LIVING:NOEXERT:NOPAIN:NOBREATHE:NOSTUN:NONAUSEA:NO_DIZZINESS:NO_FEVERS:PARALYZEIMMUNE:NO_EAT:NO_DRINK:NO_SLEEP:NO_PHYS_ATT_GAIN:NO_PHYS_ATT_RUST:START:0:ABRUPT]");
				lines.text.add_string("[CE_PHYS_ATT_CHANGE:STRENGTH:200:0:AGILITY:200:0:TOUGHNESS:200:0:START:0:ABRUPT]");
				lines.text.add_string("[CE_MATERIAL_FORCE_MULTIPLIER:MAT_MULT:NONE:NONE:1:2:ABRUPT]");
				lines.text.add_string("[CE_SENSE_CREATURE_CLASS:START:0:CLASS:GENERAL_POISON:15:4:0:1:ABRUPT]");
					*/
]]