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

color.new("red", "#CC241D")
color.new("purple", "#825291")
color.new("magenta", "#D46A9D")
color.new("violet", "#957FB7")
color.new("hay", "#AB8B61")
color.new("palebrown", "#D6B283")
color.new("green", "#59AD4C")
color.new("seagreen", "#65AD7A")
color.new("spring", "#8EB360")
color.new("blue", "#427CA6")
color.new("white", "#F5F5F5")
color.new("lightgray", "#7A7A74")
color.new("carp", "#BD9957")
color.new("water", "#75B1C9")
color.new("sakura", "#C96F8C")
color.new("salmon", "#E65C6B")

group.new("@variable", c.palebrown)
group.new("@function", c.hay)
group.new("@keyword", c.violet)
group.new("@module", c.white)
group.new("@lsp.typemod.member", c.water)
group.new("@lsp.typemod.variable", c.palebrown)
group.new("@lsp.typemod.interface", c.water)

group.new("Special", c.salmon)
group.new("SpecialChar", c.salmon)
group.new("Number", c.sakura)
group.new("Statement", c.water)
group.new("Define", c.water)
group.new("Repeat", c.water)
group.new("Import", c.palebrown)
group.new("Include", c.palebrown)
group.new("Boolean", c.palebrown)
group.new("Constant", c.palebrown)
group.new("Operator", c.carp)
group.new("String", c.spring)
group.new("Comment", c.lightgray)
group.new("CursorLineNr", c.hay)
group.new("LineNr", c.lightgray)
group.new("MatchParen", c.salmon)
group.new("Directory", c.palebrown)
