local generator_api = require("__OCs_base_assets__.prototypes.utils.api")
local oc_tech       = require("__OCs_base_assets__.prototypes.utils.oc_tech")
local oc_recipe     = require("__OCs_base_assets__.prototypes.utils.oc_recipe")
local constants     = require("prototypes.utils.constants")
local stone_amount  = constants.stone_amount
local stone_energy  = constants.stone_energy      -- crafting time per item
local melt_amount   = constants.melting_amount    -- stone per melting cycle
local melt_energy   = constants.melting_energy    -- crafting time per item
local melt_eff      = constants.melting_efficiency -- nerfing factor

data:extend({
  { -- lava to sand
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
    categories = { "metallurgy" },
    enabled = false,
    energy_required = stone_amount * stone_energy,
    --24 for 40 stone, 0.5*40 grinding sand (free)
    ingredients = {
      { type = "fluid", name = "lava", amount = stone_amount * 10, fluidbox_multiplier = 4 },
    },
    results = {
      { type = "item", name = "sand", amount = stone_amount * 2 }, -- 2sand per stone
    },
    allow_productivity = true,
    show_amount_in_title = false,
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
      categories = { "metallurgy" },
      group = "intermediate-products",
      subgroup = "vulcanus-processes",
      order = "a[melting]-a[lava-c]",
      enabled = false,
      energy_required = melt_amount * melt_energy * 0.5,
      --twice as fast as stone-to-lava since sand is smaller
      ingredients = {
        { type = "item", name = "sand", amount = melt_amount * 2, itembox_multiplyer = 4 }, -- 2sand per stone
      },
      results = {
        { type = "fluid", name = "lava", amount = melt_amount * 10 * melt_eff, fluidbox_multiplier = 4 },
      },
      allow_productivity = false,
      show_amount_in_title = false,
    },
  })
end

-- add new alternative recipes for the generator to use
local new_alt_recipes = {
  ["sand"] = {
    [40] = "lava-to-sand",
    [20] = "sand"
  },
  ["glass"] = {
    [40] = "oc-casting-glass",
    [20] = "glass",
  }
}
generator_api.register_category_alt_recipes("metallurgy", new_alt_recipes)

-- create new recipes
local casting_dict = {
  ["stone-wall"] = "metallurgy", -- overwrite vanilla version
  ["gate"] = "metallurgy",       -- overwrite vanilla version
  ["concrete-wall"] = "metallurgy",
  ["concrete-gate"] = "metallurgy",
  ["steel-wall"] = "metallurgy",
  ["steel-gate"] = "metallurgy",
  ["stone-tablet"] = "metallurgy",
  ["glass"] = "metallurgy",
}
generator_api.batch_generator(casting_dict)

-- remove and add recipes from techs
local new_prereq = {
  ["casting-wall-tech"] = { "steel-gates", "steel-walls", "casting-concrete-tech" }, -- since the concrete wall needs concrete
}
oc_tech.add_prerequisites(new_prereq)

-- add recipes to technology
local mapping = {
  ["lava-to-sand"] = { "lava-to-stone-tech" },
  ["oc-casting-stone-wall"] = { "casting-wall-tech" }, -- already there
  ["oc-casting-concrete-wall"] = { "casting-wall-tech" },
  ["oc-casting-concrete-gate"] = { "casting-wall-tech" },
  ["oc-casting-steel-wall"] = { "casting-wall-tech" },
  ["oc-casting-steel-gate"] = { "casting-wall-tech" },
  ["oc-casting-stone-tablet"] = { "foundry" },
  ["oc-casting-glass"] = { "lava-to-stone-tech" },
}
if settings.startup["allow-stone-to-lava"].value then
  mapping["sand-to-lava"] = { "lava-to-stone-tech" }
end
oc_tech.add_recipe_unlocks(mapping)
