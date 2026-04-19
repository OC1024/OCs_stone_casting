-- require("prototypes.recipe-updates")
-- require("prototypes.technology-updates")

if mods["aai-industry"] then
  require("prototypes.compatibility.aai-industry")
end
if mods["metal-and-stars"] then
  require("prototypes.compatibility.metal-and-stars")
end
if mods["maraxsis"] then
  require("prototypes.compatibility.maraxsis")
end
if mods["concrete-productivity"] then
  require("prototypes.compatibility.concrete-productivity")
end
if mods["foundation-productivity"] then
  require("prototypes.compatibility.foundation-productivity")
end
if mods["landfill-productivity"] then
  require("prototypes.compatibility.landfill-productivity")
end
if mods["Krastorio2-spaced-out"] then -- replaces normal Krastorio2 with space-age compatible version
  require("prototypes.compatibility.Krastorio2")
end