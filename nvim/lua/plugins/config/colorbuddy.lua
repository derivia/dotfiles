local status_ok, plugin = pcall(require, "colorbuddy")
if not status_ok then
	vim.notify("plugin" .. plugin .. "failed to start")
	return
end

plugin.setup({})

plugin.colorscheme("color-test")

local color = plugin.Color
local group = plugin.Group
local c = plugin.colors

-- background colors
local bg = "#282828"
color.new("background", bg)
color.new("gray0", bg)

-- funny name base colors
color.new("blue", "#427CA6")
color.new("camel", "#C48635")
color.new("carp", "#BD9957")
color.new("green", "#59AD4C")
color.new("hay", "#AB8B61")
color.new("lightgray", "#7A7A74")
color.new("magenta", "#D46A9D")
color.new("maple", "#E82E41")
color.new("palebrown", "#D6B283")
color.new("purple", "#825291")
color.new("red", "#CC241D")
color.new("sakura", "#C96F8C")
color.new("salmon", "#E65C6B")
color.new("seagreen", "#65AD7A")
color.new("spring", "#8EB360")
color.new("violet", "#957FB7")
color.new("water", "#75B1C9")
color.new("white", "#F5F5F5")

-- lsp & other semantic tokens
group.new("@function", c.water)
group.new("@keyword", c.violet)
group.new("@module", c.white)
group.new("@variable", c.palebrown)

group.new("@lsp.typemod.interface", c.water)
group.new("@lsp.typemod.macro", c.water)
group.new("@lsp.typemod.member", c.water)
group.new("@lsp.typemod.variable", c.palebrown)

-- vim highlight groups
group.new("StorageClass", c.violet)
group.new("Boolean", c.palebrown)
group.new("Comment", c.lightgray)
group.new("Constant", c.palebrown)
group.new("CursorLineNr", c.hay)
group.new("Define", c.water)
group.new("Directory", c.palebrown)
group.new("Error", c.maple)
group.new("Function", c.water)
group.new("Import", c.palebrown)
group.new("Include", c.palebrown)
group.new("LineNr", c.lightgray)
group.new("MatchParen", c.salmon)
group.new("Number", c.sakura)
group.new("Operator", c.carp)
group.new("Repeat", c.water)
group.new("Special", c.salmon)
group.new("SpecialChar", c.salmon)
group.new("Statement", c.water)
group.new("String", c.spring)
group.new("WarningMsg", c.camel)
