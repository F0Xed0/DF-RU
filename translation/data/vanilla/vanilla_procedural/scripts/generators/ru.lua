--[[
    df-ru: русская грамматика для генератЇрЇв (файл їрЇекта, не из игры).
    ИсхЇдник в UTF-8; build.py їерекЇдирует егЇ в байты шрифта игры, їЇэтЇму каждая буква ─ Їдин байт
    и string.sub / шаблЇны Lua рабЇтают їЇ буквам.

    РЇд: "m", "f", "n", "p" (тЇлькЇ мн. ч.).
    RU.adj(слЇвЇ, рЇд[, їадеж])  ─ сЇгласует їрилагательные в начале фразы (м. р. им. ї. -> нужный рЇд и їадеж):
        RU.adj("ЇгрЇмный", "f") -> "ЇгрЇмная"; RU.adj("длинный, изЇгнутый", "p", "gen") -> "длинных, изЇгнутых".
        СклЇняются слЇва їЇдряд с начала фразы, їЇка Їни їЇхЇжи на їрилагательные (оцвета мЇрскЇй вЇлнып ─ нет).
    RU.fmt(стрЇка, рЇд) ─ їЇдстанЇвки їЇ рЇду существа: {м|ж|ср|мн} и местЇимения {Їн} {Он} {негЇ} {егЇ} {ЕгЇ}
        {ему} {ним} {нєм} {нему} {им}; о{Їн} рычитп -> оЇна рычитп.
    RU.cap(стрЇка) ─ заглавная їервая буква (кириллица тЇже).
    RU.gen(имя) ─ рЇдительный їадеж имени сЇбственнЇгЇ їЇ ЇкЇнчаниям (оУрист Медвежьялаїап -> оУриста Медвежьялаїып).
    RU.rcp(англ.) ─ фЇрмы їрЇфиля тела (rcp.name_string): {sg, pl, gen, g, adj}; данные ─ ru_data.lua.
    RU.mat(им.ї.) ─ материал: {gen=рЇд.ї., adj=їрил. м. р. или nil}.
]]
RU = RU or {}

local LOWER = "абвгдеєжзийклмнЇїрстуфхцчшщъыьэюя"
local UPPER = "АБВГДЕЄЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"
RU.UP = {}
for i = 1, #LOWER do RU.UP[LOWER:sub(i, i)] = UPPER:sub(i, i) end

function RU.cap(s)
    if type(s) ~= "string" then return s end
    return (s:gsub("^([%s%p]*)(.)", function(pre, c) return pre .. (RU.UP[c] or c:upper()) end, 1))
end

local GI = {m = 1, f = 2, n = 3, p = 4}
RU.GI = GI

-- ОкЇнчания їрилагательных: тиї -> їадеж -> {м, ж, ср, мн}; винительный ─ неЇдушевлєнный
local ENDS = {
    H  = {nom = {"ый", "ая", "Їе", "ые"}, gen = {"ЇгЇ", "Їй", "ЇгЇ", "ых"}, dat = {"Їму", "Їй", "Їму", "ым"},
          acc = {"ый", "ую", "Їе", "ые"}, ins = {"ым", "Їй", "ым", "ыми"}, pre = {"Їм", "Їй", "Їм", "ых"}},
    HV = {nom = {"ий", "ая", "Їе", "ие"}, gen = {"ЇгЇ", "Їй", "ЇгЇ", "их"}, dat = {"Їму", "Їй", "Їму", "им"},
          acc = {"ий", "ую", "Їе", "ие"}, ins = {"им", "Їй", "им", "ими"}, pre = {"Їм", "Їй", "Їм", "их"}},
    SH = {nom = {"ий", "ая", "ее", "ие"}, gen = {"егЇ", "ей", "егЇ", "их"}, dat = {"ему", "ей", "ему", "им"},
          acc = {"ий", "ую", "ее", "ие"}, ins = {"им", "ей", "им", "ими"}, pre = {"ем", "ей", "ем", "их"}},
    S  = {nom = {"ий", "яя", "ее", "ие"}, gen = {"егЇ", "ей", "егЇ", "их"}, dat = {"ему", "ей", "ему", "им"},
          acc = {"ий", "юю", "ее", "ие"}, ins = {"им", "ей", "им", "ими"}, pre = {"ем", "ей", "ем", "их"}},
}
local VELAR = {["г"] = true, ["к"] = true, ["х"] = true}
local HUSH = {["ж"] = true, ["ш"] = true, ["ч"] = true, ["щ"] = true}

-- СлЇвЇ -> ЇснЇва, тиї склЇнения, ЇкЇнчание им. ї. м. р. (или nil, если этЇ не їрилагательнЇе)
local function adj_type(w)
    local e2, stem = w:sub(-2), w:sub(1, -3)
    local last = stem:sub(-1)
    if e2 == "ый" then return stem, "H", "ый" end
    if e2 == "Їй" and #stem >= 2 then
        if VELAR[last] or HUSH[last] then return stem, "HV", "Їй" end
        return stem, "H", "Їй"
    end
    if e2 == "ий" and #stem >= 2 then
        if VELAR[last] then return stem, "HV", "ий" end
        if HUSH[last] then return stem, "SH", "ий" end
        return stem, "S", "ий"
    end
    return nil
end

local function adj_word(w, g, case)
    local core, tail = w:match("^(.-)([,%.;!?]*)$")
    if core:sub(-2) == "ся" and #core > 4 then  -- вернувшийся -> вернувшаяся
        local r = adj_word(core:sub(1, -3), g, case)
        return r and (r .. "ся" .. tail)
    end
    local stem, t, nom = adj_type(core)
    if not stem then return nil end
    local gi = GI[g] or 1
    local e = ENDS[t][case or "nom"][gi]
    if (case or "nom") == "nom" and gi == 1 then e = nom end
    if case == "acc" and gi == 1 then e = nom end
    return stem .. e .. tail
end

-- Начинается ли фраза с їрилагательнЇгЇ (окрасныйп, одлинный, кривЇйп; не оцвета мЇрскЇй вЇлнып)
function RU.is_adj(phrase)
    if type(phrase) ~= "string" then return false end
    local w = phrase:match("^%s*(%S+)")
    return w ~= nil and adj_word(w, "m") ~= nil
end

function RU.adj(phrase, g, case)
    if type(phrase) ~= "string" or phrase == "" then return phrase end
    local out, stop = {}, false
    for w in phrase:gmatch("%S+") do
        local r = (not stop) and adj_word(w, g, case)
        if r then out[#out + 1] = r
        else
            out[#out + 1] = w
            stop = true
        end
    end
    local lead = phrase:match("^%s*") or ""
    return lead .. table.concat(out, " ")
end

-- окрасная шерстьп, нЇ ошерсть цвета мЇрскЇй вЇлнып: Їїределение м. р. + слЇвЇ рЇда g
function RU.np(attr, noun, g, case)
    if not attr or attr == "" then return noun end
    if RU.is_adj(attr) then return RU.adj(attr, g, case) .. " " .. noun end
    return noun .. " " .. attr
end

-- МестЇимения їЇ рЇду: м, ж, ср, мн
local PRON = {
    ["Їн"] = {"Їн", "Їна", "ЇнЇ", "Їни"}, ["Он"] = {"Он", "Она", "ОнЇ", "Они"},
    ["негЇ"] = {"негЇ", "неє", "негЇ", "них"}, ["егЇ"] = {"егЇ", "еє", "егЇ", "их"}, ["ЕгЇ"] = {"ЕгЇ", "Еє", "ЕгЇ", "Их"},
    ["ему"] = {"ему", "ей", "ему", "им"}, ["ним"] = {"ним", "ней", "ним", "ними"}, ["нєм"] = {"нєм", "ней", "нєм", "них"},
    ["нему"] = {"нему", "ней", "нему", "ним"}, ["им"] = {"им", "ей", "им", "ими"}, ["НегЇ"] = {"НегЇ", "Неє", "НегЇ", "Них"},
}

function RU.fmt(s, g)
    if type(s) ~= "string" then return s end
    local gi = GI[g] or 1
    return (s:gsub("{([^{}]*)}", function(body)
        if PRON[body] then return PRON[body][gi] end
        local alts = {}
        for a in (body .. "|"):gmatch("([^|]*)|") do alts[#alts + 1] = a end
        if #alts < 2 then return "{" .. body .. "}" end
        return alts[gi] or alts[#alts]
    end))
end

-- РЇдительный їадеж имени сЇбственнЇгЇ: каждЇе слЇвЇ с заглавнЇй склЇняется їЇ ЇкЇнчанию
local function gen_word(w)
    local e1, e2 = w:sub(-1), w:sub(-2)
    local stem1 = w:sub(1, -2)
    if e2 == "ия" then return w:sub(1, -2) .. "и" end
    if e1 == "а" then
        local l = stem1:sub(-1)
        return stem1 .. ((VELAR[l] or HUSH[l]) and "и" or "ы")
    end
    if e1 == "я" then return stem1 .. "и" end
    if e2 == "ый" or e2 == "Їй" then return w:sub(1, -3) .. "ЇгЇ" end
    if e2 == "ий" then return w:sub(1, -3) .. "егЇ" end
    if e1 == "й" then return stem1 .. "я" end
    if e1 == "ь" then return stem1 .. "я" end
    if ("Їеиуыэю"):find(e1, 1, true) or not RU.UP[e1] then return w end
    return w .. "а"
end

function RU.gen(name)
    if type(name) ~= "string" then return name end
    return (name:gsub("(%S+)", function(w)
        local first = w:sub(1, 1)
        if UPPER:find(first, 1, true) then return gen_word(w) end
        return w
    end))
end

function RU.rcp(en)
    local r = RU.RCP and RU.RCP[en]
    if r then return r end
    return {sg = en, pl = en, gen = en, g = "m", adj = en}
end

function RU.mat(nom)
    return (RU.MAT and RU.MAT[nom]) or {gen = nom}
end

-- РЇд существа для Їїисаний: їрЇфиль тела (options.rcp) или заданный явнЇ (options.ru_g)
function RU.g(options)
    if options.ru_g then return options.ru_g end
    if options.rcp and options.rcp.name_string then return RU.rcp(options.rcp.name_string).g end
    return "m"
end

require("generators.ru_data")
