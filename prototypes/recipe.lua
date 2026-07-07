local oc_recipe    = require("__OCs_base_assets__.prototypes.utils.oc_recipe")
local constants    = require("prototypes.utils.constants")
local stone_amount = constants.stone_amount
local stone_energy = constants.stone_energy -- crafting time

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
    categories = { "metallurgy" },
    enabled = false,
    energy_required = stone_amount * stone_energy,
    ingredients = {
      { type = "fluid", name = "lava", amount = stone_amount * 10, fluidbox_multiplier = 4 },
    },
    results = {
      { type = "item", name = "stone", amount = stone_amount },
    },
    allow_productivity = true,
    show_amount_in_title = true,
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
    categories = { "metallurgy" },
    enabled = false,
    energy_required = stone_amount * stone_energy,
    ingredients = {
      { type = "fluid", name = "lava", amount = stone_amount * 10, fluidbox_multiplier = 4 },
    },
    results = {
      { type = "item", name = "stone-brick", amount = stone_amount / 2 }
    },
    allow_productivity = true,
  },
})
if settings.startup["allow-stone-to-lava"].value then
  data:extend({
    { -- stone to lava
      type = "recipe",
      name = "stone-to-lava",
      icon = "__OCs_stone_casting__/graphics/icons/lava-stone.png",
      icon_size = 64,
      icon_mipmaps = 4,
      categories = { "metallurgy" },
      group = "intermediate-products",
      subgroup = "vulcanus-processes",
      order = "a[melting]-a[lava-c]-a",
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
  })
end

-- pepare the generator
local generator_api = require("__OCs_base_assets__.prototypes.utils.api")

-- create new recipes
local casting_dict = {
  ["stone-wall"] = "metallurgy",
  ["concrete-from-molten-iron"] = "metallurgy",
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

-- push it back to the normal concret recipe instead of the vulcanus recipe
oc_recipe.change_recipes_subgroup({["oc-casting-concrete-from-molten-iron"] = "terrain"})