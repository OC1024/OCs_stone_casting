if mods["aai-industry"] then
  require("prototypes.compatibility.aai-industry")
end

if casting_materials then
    casting_materials["stone"] = {
        liquid = "lava",
        ratio = 10,
        energy_required = 0.8
    }
    if data.raw["item"]["sand"] then
    casting_materials["sand"] = {
        liquid = "lava",
        ratio = 5,
        energy_required = 0.4
    }
    end
end
require("__OCs_base_assets__.prototypes.utils.casting-generator")

require("prototypes.recipe-updates")
require("prototypes.technology-updates")