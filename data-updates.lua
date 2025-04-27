if mods["aai-industry"] then
  require("prototypes.compatibility.aai-industry")
end


alternative_recipes = alternative_recipes or {}

local new_entries = {
    ["stone-brick"] = {"lava-to-stone-brick","stone-brick",}, -- add new alt recipe, which is more important
    ["concrete"] = {"casting-concrete-recipe","concrete-from-molten-iron","concrete",}, -- overwrite with new order
    ["refined-concrete"] = {"cating-concrete","casting-refined-concrete-recipe","refined-concrete",},
}
for i, r in pairs(new_entries) do
    alternative_recipes[i] = r
end

if casting_materials then
    casting_materials["stone"] = {
        fluid = "lava",
        ratio = 10,
        energy_required = 0.8
    }
    if data.raw["item"]["sand"] then
    casting_materials["sand"] = {
        fluid = "lava",
        ratio = 5,
        energy_required = 0.4
    }
    end
end

require("prototypes.recipe-updates")
require("prototypes.technology-updates")