-- pepare the generator
local generator_api = require("__OCs_base_assets__.prototypes.utils.api")

-- register lava as a fluid overlayer
local fluid_overlayer = {
  ["lava"] = {
    icon = "__OCs_base_assets__/graphics/icons/overlayer-recipe-lava.png",
    priority = 6,
  }
}
generator_api.register_fluid_overlays(fluid_overlayer)

-- register new alt recipes
local new_alt_recipes = {
  ["stone"] = { "lava-to-stone", "stone" },
  ["stone-brick"] = { "oc-casting-brick", "stone-brick" },
  ["stone-furnace"] = { "oc-casting-stone-furnace", "stone-furnace" },
  ["steel-furnace"] = { "oc-casting-steel-furnace", "steel-furnace" },
  ["rail"] = { "oc-casting-rail", "rail" },
  ["stone-wall"] = { "oc-casting-stone-wall", "stone-wall" },
  ["gate"] = { "oc-casting-gate", "gate" },
}
generator_api.register_category_alt_recipes("metallurgy", new_alt_recipes)

-- remove stone from blacklist, as we can make it from lava now
generator_api.unregister_item_blacklist("metallurgy", { "stone" })

-- overwrite with new order
local overwrite_alt_recipes = {
  ["concrete"] = { 
    [60] = "oc-casting-concrete",
    [40] = "concrete-from-molten-iron",
    [20] = "concrete",
  },
  ["refined-concrete"] = { 
    [40] = "oc-casting-refined-concrete",
    [20] = "refined-concrete",
  },
}
generator_api.overwrite_category_alt_recipes("metallurgy", overwrite_alt_recipes)
