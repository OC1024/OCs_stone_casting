
-- pepare the generator
local generator_api = require("__OCs_base_assets__.prototypes.utils.api")

-- register new alt recipes 
local new_alt_recipes = {
    ["stone"] = {"lava-to-stone","stone"},
    ["stone-brick"] = {"oc-casting-brick","stone-brick"},
    ["stone-furnace"] = {"oc-casting-stone-furnace","stone-furnace"},
    ["steel-furnace"] = {"oc-casting-steel-furnace","steel-furnace"},
    ["rail"] = {"oc-casting-rail","rail"},
    ["stone-wall"] = {"oc-casting-stone-wall","stone-wall"},
    ["gate"] = {"oc-casting-gate","gate"},
}
generator_api.register_category_alt_recipes("metallurgy", new_alt_recipes)

-- remove stone from blacklist, as we can make it from lava now
generator_api.unregister_item_blacklist("metallurgy", {"stone"})

-- overwrite with new order
local  overwrite_alt_recipes = {
    ["concrete"] = {"oc-casting-concrete","concrete-from-molten-iron","concrete",},
    ["refined-concrete"] = {"oc-casting-refined-concrete","refined-concrete",},
}
generator_api.overwrite_category_alt_recipes("metallurgy",overwrite_alt_recipes)

-- debug_log("Alt recipes for metallurgy:".. serpent.block(generator_api.rules_table["metallurgy"].alternative_recipes), generator_api) -- debug for finding hen the table gets overwritten