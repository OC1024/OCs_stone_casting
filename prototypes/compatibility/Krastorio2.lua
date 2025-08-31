
-- 1. pepare the generator
local generator_api = require("__OCs_base_assets__.prototypes.utils.api")

-- 2. Execute the Generator.
local casting_dict = {
    ["kr-sand"] = "metallurgy",
    ["kr-glass"] = "metallurgy",
    -- ["kr-quartz"] = "metallurgy", -- filtration process forbits quartz casting
    -- ["kr-silicon"] = "metallurgy", -- silicon is made from quartz, so no casting
}
generator_api.batch_generator(casting_dict)

-- 3. Add Recipes to Techs
local recipe_tech_mapping = {
    ["casting-kr-glass"] = {"glass-processing"},
    -- ["casting-item-name-2"] = {"technology-name-2"},
}
add_recipe_unlocks(recipe_tech_mapping)