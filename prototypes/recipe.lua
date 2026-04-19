local oc_recipe = require("__OCs_base_assets__.prototypes.utils.oc_recipe")

data:extend({
  { -- lava to stone
    type = "recipe",
    name = "lava-to-stone",
    icons = {
      {
        icon = "__base__/graphics/icons/stone.png",
        icon_size = 64,
        icon_mipmaps = 4,
      },
      {
        icon = "__OCs_base_assets__/graphics/icons/overlayer-recipe-lava-droplet.png",
        icon_size = 64,
        icon_mipmaps = 4,
      }
    },
    icon_size = 64,
    icon_mipmaps = 4,
    category = "metallurgy",
    enabled = false,
    energy_required = 24, -- like the lava-to-metal: 10 liquid = 1 item. new time: 0.6 time per stone
    ingredients = {
      { type = "fluid", name = "lava", amount = 400, fluidbox_multiplier = 4 },
    },
    results = {
      { type = "item", name = "stone", amount = 40 },
    },
    allow_productivity = true,
    show_amount_in_title = true,
  },
  { -- stone to lava
    type = "recipe",
    name = "stone-to-lava",
    icon = "__OCs_stone_casting__/graphics/icons/lava-stone.png",
    icon_size = 64,
    icon_mipmaps = 4,
    category = "metallurgy",
    group = "intermediate-products",
    subgroup = "vulcanus-processes",
    order = "a[melting]-a[lava-c]",
    enabled = false,
    energy_required = 32, -- like melting ores
    ingredients = {
      { type = "item", name = "stone", amount = 50 },
    },
    results = {
      { type = "fluid", name = "lava", amount = 250 }, -- halfed to reduce positive feedback
    },
    allow_productivity = false,
    show_amount_in_title = false,
  },
  { -- lava to brick
    type = "recipe",
    name = "lava-to-stone-brick",
    icons = {
      {
        icon = "__base__/graphics/icons/stone-brick.png",
        icon_size = 64,
        icon_mipmaps = 4,
      },
      {
        icon = "__OCs_base_assets__/graphics/icons/overlayer-recipe-lava-droplet.png",
        icon_size = 64,
        icon_mipmaps = 4,
      }
    },
    category = "metallurgy",
    enabled = false,
    energy_required = 24, -- like liquid-metal-to-metal:  2stone to 1brick but 20x volume. new time: 20x0.6=12
    ingredients = {
      { type = "fluid", name = "lava", amount = 400, fluidbox_multiplier = 4 }
    },
    results = {
      { type = "item", name = "stone-brick", amount = 20 }
    },
    allow_productivity = true,
  },
})

-- pepare the generator
local generator_api = require("__OCs_base_assets__.prototypes.utils.api")

-- create new recipes
local casting_dict = {
  ["stone-wall"] = "metallurgy",
  ["concrete"] = "metallurgy",
  ["refined-concrete"] = "metallurgy",
  ["landfill"] = "metallurgy",
  ["foundation"] = "metallurgy",
  ["stone-furnace"] = "metallurgy",
  ["steel-furnace"] = "metallurgy",
  ["gate"] = "metallurgy",
  ["rail"] = "metallurgy",
}
generator_api.batch_generator(casting_dict)

data.raw.recipe["oc-casting-foundation"].surface_conditions = { { property = "pressure", min = 4000, max = 4000 } } -- Vulcanus only
