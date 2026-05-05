local generator_api = require("__OCs_base_assets__.prototypes.utils.api")
local oc_tech       = require("__OCs_base_assets__.prototypes.utils.oc_tech")
local oc_recipe     = require("__OCs_base_assets__.prototypes.utils.oc_recipe")
local constants     = require("prototypes.constants")
local stone_amount  = constants.stone_amount
local stone_energy  = constants.stone_energy -- crafting time

data:extend({
  { -- lava to sand
    -- copied from aai industry as it is the same prototype
    type = "recipe",
    name = "lava-to-sand",
    icons = {
      {
        icon = "__OCs_base_assets__/graphics/icons/sand.png", -- sand icon stolen from Kastorio2.
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
    energy_required = stone_amount * stone_energy,
    ingredients = {
      { type = "fluid", name = "lava", amount = stone_amount * 10, fluidbox_multiplier = 4 },
    },
    results = {
      { type = "item", name = "sand", amount = stone_amount * 2 }, -- 2sand per stone
    },
    allow_productivity = true,
    show_amount_in_title = true,
  },
})

if settings.startup["allow-stone-to-lava"].value then
  data:extend({
    { -- sand to lava
      type = "recipe",
      name = "sand-to-lava",
      icon = "__OCs_stone_casting__/graphics/icons/lava-sand.png",
      icon_size = 64,
      icon_mipmaps = 4,
      category = "metallurgy",
      group = "intermediate-products",
      subgroup = "vulcanus-processes",
      order = "a[melting]-a[lava-c]-b",
      enabled = false,
      energy_required = 16,
      --twice as fast as stone-to-lava since sand is smaller
      ingredients = {
        { type = "item", name = "sand", amount = 100, itembox_multiplyer = 4 }, -- 2sand per stone
      },
      results = {
        { type = "fluid", name = "lava", amount = 250, fluidbox_multiplier = 4 }, -- halfed to reduce positive feedback
      },
      allow_productivity = false,
      show_amount_in_title = false,
    },
  })
  oc_tech.add_recipe_unlocks({ ["sand-to-lava"] = { "lava-to-stone-tech" } })
end


-- add new alterative recipes for the generator to use
local new_alt_recipes = {
  ["sand"] = { "lava-to-sand", "sand" },
}
generator_api.register_category_alt_recipes("metallurgy", new_alt_recipes)

-- create new recipes
local casting_dict = {
  ["glass"] = "metallurgy",
}
generator_api.batch_generator(casting_dict)

-- add recipes to technology
local recipe_mapping = {
  ["lava-to-sand"] = { "lava-to-stone-tech" },
  ["oc-casting-glass"] = { "lava-to-stone-tech" },
  ["sand-to-lava"] = { "lava-to-stone-tech" }, -- if enabled
}
oc_tech.add_recipe_unlocks(recipe_mapping)
