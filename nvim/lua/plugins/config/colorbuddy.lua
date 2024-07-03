local status_ok, plugin = pcall(require, "colorbuddy")
if not status_ok then
	return
end

plugin.setup({})

plugin.colorscheme("color-test")

local color = plugin.Color
local group = plugin.Group
local c = plugin.colors
local s = plugin.styles

-- background colors
local bg = "#282828"
color.new("background", bg)
color.new("gray0", bg)

-- funny name base colors
color.new("blue", "#427CA6")
color.new("camel", "#C48635")
color.new("carp", "#BD9957")
color.new("coral", "#304044")
color.new("green", "#59AD4C")
color.new("hay", "#AB8B61")
color.new("lightgray", "#7A7A74")
color.new("magenta", "#D46A9D")
color.new("maple", "#E82E41")
color.new("palebrown", "#D6B283")
color.new("purple", "#825291")
color.new("red", "#CC3232")
color.new("sakura", "#C96F8C")
color.new("salmon", "#E65C6B")
color.new("seagreen", "#65AD7A")
color.new("spring", "#8EB360")
color.new("violet", "#957FB7")
color.new("water", "#75B1C9")
color.new("white", "#F5F5F5")

-- colorbuddy group syntax:
-- (<name>, <fg-color>?, <bg-color>?, <style>?)

-- lsp & other semantic tokens
group.new("@function", c.water, nil, nil)
group.new("@keyword", c.violet, nil, nil)
group.new("@module", c.white, nil, nil)
group.new("@variable", c.palebrown, nil, nil)

group.new("@lsp.typemod.interface", c.water, nil, nil)
group.new("@lsp.typemod.macro", c.water, nil, nil)
group.new("@lsp.typemod.member", c.water, nil, nil)
group.new("@lsp.typemod.variable", c.palebrown, nil, nil)
group.new("@variable.builtin", c.palebrown, nil, nil)

-- vim highlight groups
group.new("Boolean", c.palebrown, nil, nil)
group.new("Comment", c.lightgray, nil, nil)
group.new("Conditional", c.violet, nil, nil)
group.new("Constant", c.palebrown, nil, nil)
group.new("CursorLineNr", c.hay, nil, nil)
group.new("Define", c.water, nil, nil)
group.new("DiagnosticError", c.red, nil, s.italic)
group.new("Directory", c.palebrown, nil, nil)
group.new("Error", c.maple, nil, nil)
group.new("Function", c.water, nil, nil)
group.new("Import", c.palebrown, nil, nil)
group.new("Include", c.palebrown, nil, nil)
group.new("Label", c.violet, nil, nil)
group.new("LineNr", c.lightgray, nil, nil)
group.new("MatchParen", c.salmon, nil, nil)
group.new("Number", c.sakura, nil, nil)
group.new("Operator", c.carp, nil, nil)
group.new("Preproc", c.water, nil, nil)
group.new("Repeat", c.water, nil, nil)
group.new("Special", c.salmon, nil, nil)
group.new("SpecialChar", c.salmon, nil, nil)
group.new("Statement", c.water, nil, nil)
group.new("StorageClass", c.violet, nil, nil)
group.new("String", c.spring, nil, nil)
group.new("Title", c.caramel, nil, nil)
group.new("WarningMsg", c.camel, nil, nil)
group.new("Visual", nil, c.coral, nil)
group.new("FloatBorder", nil, nil, nil)
group.new("NormalFloat", nil, c.background, nil)

-- markdown specific
group.new("markdownCodeBlock", c.spring, nil, nil)
group.new("markdownError", c.white, nil, nil)
group.new("markdownLinkText", c.camel, nil, nil)
group.new("markdownh1", c.water, nil, nil)
group.new("markdownh2", c.water, nil, nil)
group.new("markdownh3", c.water, nil, nil)
group.new("markdownh4", c.water, nil, nil)
group.new("markdownh5", c.water, nil, nil)
