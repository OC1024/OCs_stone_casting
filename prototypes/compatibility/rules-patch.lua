-- pepare the generator
local generator_api = require("__OCs_base_assets__.prototypes.utils.api")

-- register lava as a fluid overlayer
local fluid_overlayer = {
  ["lava"] = {
    icon = "__OCs_base_assets__/graphics/icons/overlayer-recipe-lava.png",
    icon_size = 64,
    icon_mipmaps = 4,
    priority = 6,
  }
}
generator_api.register_fluid_overlays(fluid_overlayer)

-- register new alt recipes
local new_alt_recipes = {
  ["stone"] = {
    [40] = "lava-to-stone",
    [20] = "stone"
  },
  ["stone-brick"] = {
    [40] = "lava-to-stone-brick",
    [20] = "stone-brick"
  },
  ["stone-furnace"] = {
    [40] = "lava-to-stone-furnace",
    [20] = "stone-furnace"
  },
  ["steel-furnace"] = {
    [40] = "lava-to-steel-furnace",
    [20] = "steel-furnace"
  },
  ["rail"] = {
    [40] = "lava-to-rail",
    [20] = "rail"
  },
  ["stone-wall"] = {
    [40] = "lava-to-stone-wall",
    [20] = "stone-wall"
  },
  ["gate"] = {
    [40] = "lava-to-gate",
    [20] = "gate"
  },
  ["refined-concrete"] = {
    [40] = "oc-casting-refined-concrete",
    [20] = "refined-concrete",
  },
  ["concrete"] = {
    [60] = "oc-casting-concrete", -- adding at the top
  },
}
generator_api.register_category_alt_recipes("metallurgy", new_alt_recipes)

-- remove stone from blacklist, as we can make it from lava now
generator_api.unregister_item_blacklist("metallurgy", { "stone" })
