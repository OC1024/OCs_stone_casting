
-- pepare the generator
local generator_api = require("__OCs_base_assets__.prototypes.utils.api")

-- register new alt recipes 
local new_alt_recipes = {
    ["stone"] = {"lava-to-stone","stone"},
    ["stone-brick"] = {"lava-to-stone-brick","stone-brick",},
    ["concrete"] = {"casting-concrete-recipe","concrete-from-molten-iron","concrete",}, -- overwrite with new order
    ["refined-concrete"] = {"casting-refined-concrete-recipe","refined-concrete",},
}
generator_api.register_category_alt_recipes("metallurgy", new_alt_recipes)
debug_log("Alt recipes for metallurgy:".. serpent.block(generator_api.rules_table["metallurgy"].alternative_recipes), generator_api) -- debug for finding hen the table gets overwritten