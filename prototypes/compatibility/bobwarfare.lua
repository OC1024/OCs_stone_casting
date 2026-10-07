local oc_recipe = require("__OCs_base_assets__.prototypes.utils.oc_recipe")
local oc_tech = require("__OCs_base_assets__.prototypes.utils.oc_tech")
local generator_api = require("__OCs_base_assets__.prototypes.utils.api")


-- use generator_api
local casting_dict = {
  ["bob-reinforced-wall"] = "metallurgy",
  ["bob-reinforced-gate"] = "metallurgy",
}
generator_api.batch_generator(casting_dict)


-- add prereq
local adding_prereq = {
  ["casting-wall-tech"] = { "bob-reinforced-wall" },
}
oc_tech.add_prerequisites(adding_prereq)

-- add recipes to technology
local recipe_unlock_mapping = {
  ["casting-wall-tech"] = { "oc-casting-bob-reinforced-wall", "oc-casting-bob-reinforced-gate", },
}
oc_tech.add_tech_unlocks(recipe_unlock_mapping)
