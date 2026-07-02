local oc_helper = require("__OCs_base_assets__.prototypes.utils.helper")
local oc_tech = require("__OCs_base_assets__.prototypes.utils.oc_tech")
local oc_recipe = require("__OCs_base_assets__.prototypes.utils.oc_recipe")
local generator_api = require("__OCs_base_assets__.prototypes.utils.api")
local constants     = require("prototypes.constants")
local stone_amount  = constants.stone_amount
local stone_energy  = constants.stone_energy -- crafting time

data:extend({
  { -- lava to stone-crushed
    type = "recipe",
    name = "lava-to-stone-crushed",
    icons = {
      {
        icon = "__muluna-graphics__/graphics/icons/crushed-stone.png", -- sand icon stolen from planet muluna.
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
      { type = "item", name = "stone-crushed", amount = stone_amount },
    },
    allow_productivity = true,
    show_amount_in_title = false,
  },
})

if settings.startup["allow-stone-to-lava"].value then
  data:extend({
    { -- stone-crushed to lava
      type = "recipe",
      name = "stone-crushed-to-lava",
      icons = {
        {
          icon = "__space-age__/graphics/icons/fluid/lava.png",
          icon_size = 64,
          icon_mipmaps = 4,
        },
        {
          icon = "__muluna-graphics__/graphics/icons/crushed-stone.png", -- sand icon stolen from planet muluna.
          icon_size = 64,
          icon_mipmaps = 4,
          scale = 0.25,
          shift = {0,8},
        }
      },
      icon_size = 64,
      icon_mipmaps = 4,
      categories = { "metallurgy" },
      group = "intermediate-products",
      subgroup = "vulcanus-processes",
      order = "a[melting]-a[lava-c]",
      enabled = false,
      energy_required = 16,
      --twice as fast as stone-to-lava since "sand"/"stone-crushed" is smaller
      ingredients = {
        { type = "item", name = "stone-crushed", amount = 50, itembox_multiplyer = 4 }, -- 2sand per stone
      },
      results = {
        { type = "fluid", name = "lava", amount = 250, fluidbox_multiplier = 4 }, -- halfed to reduce positive feedback
      },
      allow_productivity = false,
      show_amount_in_title = false,
    },
  })
end

-- generate new recipes
local casting_dict = {
  -- aluminium intermetiates
  ["muluna-steam-stone-furnace"] = "metallurgy",
  ["muluna-steam-steel-furnace"] = "metallurgy",
}
generator_api.batch_generator(casting_dict)

-- Add Recipes to Techs
local recipe_tech_mapping = {
  ["oc-casting-muluna-steam-stone-furnace"] = { "lava-to-stone-tech" },
  ["oc-casting-muluna-steel-stone-furnace"] = { "lava-to-stone-tech" },
  ["stone-crushed-to-lava"] = { "lava-to-stone-tech" },
  ["lava-to-stone-crushed"] = { "lava-to-stone-tech" },
}
oc_tech.add_recipe_unlocks(recipe_tech_mapping)
