-- require("prototypes.recipe-updates")
-- require("prototypes.technology-updates")

if mods["aai-industry"] then
  require("prototypes.compatibility.aai-industry")
end
if mods["Krastorio2-spaced-out"] then -- replaces normal Krastorio2 with space-age compatible version
  require("__OCs_base_assets__.prototypes.compatibility.Krastorio2")
  require("prototypes.compatibility.Krastorio2")
end
if mods["metal-and-stars"] then
  require("prototypes.compatibility.metal-and-stars") -- prod bonus for casting rail
end
if mods["concrete-productivity"] then
  require("prototypes.compatibility.concrete-productivity")
end
if mods["foundation-productivity"] then
  require("prototypes.compatibility.foundation-productivity")
end