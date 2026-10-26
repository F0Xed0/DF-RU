function optionally_localized()
    return one_in(2) and ":LOCALIZED" or ""
end

function optionally_vascular()
    local str=""
    if not one_in(5) then str=":LOCALIZED" else str=":BP:BY_CATEGORY:ALL:ALL" end
    str=str..":VASCULAR_ONLY"
    if one_in(3) then str=str..":MUSCULAR_ONLY" end
    return str
end

default_poison_bits={
    CE_PAIN=optionally_localized,
    CE_SWELLING=optionally_vascular,
    CE_OOZING=optionally_vascular,
    CE_BRUISING=optionally_vascular,
    CE_BLISTERS=optionally_vascular,
    CE_NUMBNESS=optionally_localized,
    CE_PARALYSIS=optionally_localized,
    CE_BLEEDING=optionally_vascular,
    CE_NECROSIS=function()
        if not one_in(5) then
            return ":LOCALIZED:VASCULAR_ONLY"..(one_in(3) and ":MUSCULAR_ONLY" or "")
        else
            return ":VASCULAR_ONLY:BP:BY_CATEGORY:ALL:"..pick_random({
                "SKIN",
                "FAT",
                "MUSCLE",
                "EYE",
                "NERVE",
                "BRAIN",
                "LUNG",
                "HEART",
                "LIVER",
                "GUT",
                "STOMACH",
                "PANCREAS",
                "SPLEEN",
                "KIDNEY",
                "ALL",
            })
        end
    end,
    CE_IMPAIR_FUNCTION=function()
        --COULD DO LUNGS OR SOMETHING
        if one_in(3) then 
            return ":LOCALIZED"
        else
            return ":BP:BY_CATEGORY:ALL:"..pick_random({
                "MUSCLE",
                "EYE",
                "NERVE",
                "BRAIN",
                "LUNG",
                "HEART",
                "LIVER",
                "GUT",
                "STOMACH",
                "PANCREAS",
                "SPLEEN",
                "KIDNEY",
                "ALL",
            })
        end
    end
}

function add_base_poison_effects(mat,good_effects,sev,max_eff,min_start,max_start,min_peak,max_peak,min_end,max_end,terminal_chance,resist_chance,size_delay_chance,size_dilute_chance)
    local num=trandom(max_eff)+1
    while num>0 do
        local picked=pick_random_no_replace(good_effects)
        local start=trandom(max_start)+min_start
        local peak=start+trandom(max_peak)+min_peak
        local s_end = peak+trandom(max_end)+min_end
        if one_in(terminal_chance) then s_end=false end
        local str="        ["..picked..":SEV:"..sev..":PROB:100:START:"..start..":PEAK:"..peak..(s_end and ":END:"..s_end or "")
        local bits=default_poison_bits[picked]
        if bits then str = str..bits() end
        str=str..(one_in(resist_chance) and ":RESISTABLE" or "")..(one_in(size_delay_chance) and ":SIZE_DELAYS" or "")..(one_in(size_dilute_chance) and ":SIZE_DILUTES" or "").."]"
        mat[#mat+1]=str
        num=num-1
    end
end

gestures={
    "делаете жест:делает жест",
    "указываете:указывает",
    "їЇднимаете руку:їЇднимает руку",
    "сжимаете кулак:сжимает кулак",
    "делаете резкЇе движение:делает резкЇе движение",
}

gestures_abstract={
    "указываете:указывает",
    "їренебрежительнЇ машете рукЇй:їренебрежительнЇ машет рукЇй"
}
function get_abstract_gesture()
    return pick_random(table_merge(gestures,gestures_abstract))
end

default_curse_effects={
    PAIN={
        adv_name="Причинить бЇль",
        target_verb="чувствуете сильную бЇль:мЇрщится",
        default_icon="ADVENTURE_INTERACTION_ICON_CAUSE_PAIN",
        ci_str=function(sev)
            return "[CE_PAIN:SEV:"..tostring(sev)..":PROB:100:START:0:PEAK:0:END:3:RESISTABLE]"
        end
    },
    BLISTERS={
        adv_name="Вызвать вЇлдыри",
        target_verb="чувствуете, как вздуваются вЇлдыри:мЇрщится",
        default_icon="ADVENTURE_INTERACTION_ICON_BLISTER",
        ci_str=function(sev)
            return "[CE_BLISTERS:SEV:"..tostring(sev)..":PROB:100:START:0:PEAK:0:END:3:BP:BY_CATEGORY:ALL:SKIN:VASCULAR_ONLY:RESISTABLE]"
        end
    },
    PARALYSIS={
        adv_name="ПарализЇвать",
        target_verb="цеїенеете:цеїенеет",
        default_icon="ADVENTURE_INTERACTION_ICON_PARALYZE",
        ci_str=function(sev)
            return "[CE_PARALYSIS:SEV:"..tostring(sev)..":PROB:100:START:0:PEAK:0:END:3:RESISTABLE]"
        end
    },
    BLEEDING={
        adv_name="Вызвать крЇвЇтечение",
        target_verb="чувствуете, как выстуїает крЇвь:мЇрщится",
        default_icon="ADVENTURE_INTERACTION_ICON_CAUSE_BLEEDING",
        ci_str=function(sev)
            return "[CE_BLEEDING:SEV:"..tostring(math.floor(sev/10))..":PROB:100:START:0:PEAK:0:END:3:BP:BY_CATEGORY:ALL:SKIN:VASCULAR_ONLY:RESISTABLE]"
        end
    },
    COUGH_BLOOD={
        adv_name="Наслать хвЇрь",
        target_verb="чувствуете дурнЇту:выглядит бЇльным",
        default_icon="ADVENTURE_INTERACTION_ICON_SICKEN_COUGH_BLOOD",
        ci_str=function(sev)
            return "[CE_COUGH_BLOOD:SEV:"..tostring(sev)..":PROB:100:START:0:PEAK:0:END:3:RESISTABLE]"
        end
    },
    VOMIT_BLOOD={
        adv_name="Наслать хвЇрь",
        target_verb="чувствуете дурнЇту:выглядит бЇльным",
        default_icon="ADVENTURE_INTERACTION_ICON_SICKEN_VOMIT_BLOOD",
        ci_str=function(sev)
            return "[CE_VOMIT_BLOOD:SEV:"..tostring(sev)..":PROB:100:START:0:PEAK:0:END:3:RESISTABLE]"
        end
    },
    NAUSEA={
        adv_name="Наслать хвЇрь",
        target_verb="чувствуете дурнЇту:выглядит бЇльным",
        default_icon="ADVENTURE_INTERACTION_ICON_SICKEN_NAUSEA",
        ci_str=function(sev)
            return "[CE_NAUSEA:SEV:"..tostring(sev)..":PROB:100:START:0:PEAK:0:END:3:RESISTABLE]"
        end
    },
    NECROSIS={
        adv_name="Наслать гниль",
        target_verb="чувствуете дыхание смерти:мЇрщится",
        default_icon="ADVENTURE_INTERACTION_ICON_ROT",
        ci_str=function(sev)
            return "[CE_NECROSIS:SEV:"..tostring(sev)..":PROB:100:START:0:PEAK:0:END:3:BP:BY_CATEGORY:ALL:"..pick_random({
                "SKIN",
                "FAT",
                "MUSCLE",
                "EYE",
                "NERVE",
                "BRAIN",
                "LUNG",
                "HEART",
                "LIVER",
                "GUT",
                "STOMACH",
                "PANCREAS",
                "SPLEEN",
                "KIDNEY",
                "ALL"})..":RESISTABLE]"
            
        end
    },
    SUFFOCATE={
        adv_name="Удушить",
        target_verb="чувствуете, чтЇ задыхаетесь:замирает",
        default_icon="ADVENTURE_INTERACTION_ICON_BLIND",
        ci_str=function(sev)
            return "[CE_IMPAIR_FUNCTION:SEV:"..tostring(sev)..":PROB:100:START:0:PEAK:0:END:3:BP:BY_CATEGORY:ALL:LUNG:RESISTABLE]"
        end
    },
    BLIND={
        adv_name="Ослеїить",
        target_verb="чувствуете, чтЇ слеїнете:замирает",
        default_icon="ADVENTURE_INTERACTION_ICON_SUFFOCATE",
        ci_str=function(sev)
            return "[CE_IMPAIR_FUNCTION:SEV:"..tostring(sev)..":PROB:100:START:0:PEAK:0:END:3:BP:BY_CATEGORY:ALL:EYE:RESISTABLE]"
        end
    },
    DIZZY={
        adv_name="Вызвать гЇлЇвЇкружение",
        target_verb="чувствуете гЇлЇвЇкружение:їЇшатывается",
        default_icon="ADVENTURE_INTERACTION_ICON_CAUSE_DIZZINESS",
        ci_str=function(sev)
            return "[CE_DIZZINESS:SEV:"..tostring(sev)..":PROB:100:START:0:PEAK:0:END:3:RESISTABLE]"
        end
    },
}

function add_curses(tbl, end_tbl, token, num, start_idx, sev, good_effects)
    if num<1 then return end
    local idx=start_idx
    for i=1,num do
        local which=pick_random_no_replace(good_effects)
        local actual_name=token.."_"..tostring(idx)
        idx = idx + 1
        if which=="SICKEN" then
            which=pick_random({"VOMIT_BLOOD","COUGH_BLOOD","NAUSEA"})
        end
        if which=="IMPAIR" then
            which=pick_random({"SUFFOCATE","BLIND"})
        end
        local chosen=default_curse_effects[which]
        tbl=split_to_lines(tbl,[[
            [CE_CAN_DO_INTERACTION:START:0:ABRUPT]
            [CDI:ADV_NAME:]]..chosen.adv_name..[[]
            [CDI:INTERACTION:]]..actual_name..[[]
			[CDI:TARGET:A:LINE_OF_SIGHT]
			[CDI:TARGET_RANGE:A:25]
			[CDI:BP_REQUIRED:BY_TYPE:GRASP]
			[CDI:USAGE_HINT:ATTACK]
            [CDI:VERB:]]..get_abstract_gesture()..[[:NA]
            [CDI:TARGET_VERB:]]..chosen.target_verb..[[]
			[CDI:MAX_TARGET_NUMBER:A:1]
			[CDI:WAIT_PERIOD:50]
            [CDI:DEFAULT_ICON:]]..chosen.default_icon..[[]
            ]])
        end_tbl[#end_tbl+1]="[INTERACTION:"..actual_name.."]"
        end_tbl=add_generated_info(end_tbl)
        end_tbl=split_to_lines(end_tbl,[[
			[I_TARGET:A:CREATURE]
				[IT_LOCATION:CONTEXT_CREATURE]
				[IT_MANUAL_INPUT:victim]
			[I_EFFECT:ADD_SYNDROME]
				[IE_TARGET:A]
				[IE_IMMEDIATE]
				[SYNDROME]
					[SYN_CONCENTRATION_ADDED:1000:0]
                    ]])
        end_tbl[#end_tbl+1]=chosen.ci_str(sev)
    end
    return tbl, end_tbl, idx
end

--[[
    You don't need specific names! e.g. if you want your own evil materials, it doesn't have to be in generators/evil.lua or whatever.
    You can just put it all in init.lua or similar. This is just an organizational convention.
]]

monotone_color_pattern={}

function populate_monotone_color_pattern()
    if #monotone_color_pattern>0 then return end
    for k,v in ipairs(world.descriptor.color_pattern) do
        if #v.pattern=="MONOTONE" and #v.color>0 then
            monotone_color_pattern[#monotone_color_pattern+1]=v
        end
    end
end

require("generators.ru") -- df-ru: русская грамматика (ru.lua, ru_data.lua)
require("generators.language")
require("generators.divine")
require("generators.evil")
require("generators.materials")
require("generators.items")
require("generators.creatures")
require("generators.interactions")
require("generators.entities")