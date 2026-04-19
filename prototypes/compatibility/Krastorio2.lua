local oc_tech = require("__OCs_base_assets__.prototypes.utils.oc_tech")
local oc_recipe = require("__OCs_base_assets__.prototypes.utils.oc_recipe")

data:extend({
  -- overwrite sand to kr-sand
  { -- lava to kr-sand
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
    energy_required = 24,                                                       --24 for 40 stone, 0.5*40 grinding sand (free)
    ingredients = {
      { type = "fluid", name = "lava", amount = 400, fluidbox_multiplier = 4 }, -- 40 stone
    },
    results = {
      { type = "item", name = "kr-sand", amount = 100 }, -- 2.5sand per stone (7-8 sand from 3 stone)
    },
    allow_productivity = true,
    show_amount_in_title = false,
  },
  -- overwrite kr-sand to lava
  { -- kr-sand to lava
    type = "recipe",
    name = "sand-to-lava",
    icon = "__OCs_stone_casting__/graphics/icons/lava-sand.png",
    icon_size = 64,
    icon_mipmaps = 4,
    category = "metallurgy",
    group = "intermediate-products",
    subgroup = "vulcanus-processes",
    order = "a[melting]-a[lava-c]",
    enabled = false,
    energy_required = 16,                                                        --twice as fast as stone-to-lava since sand is smaller
    ingredients = {
      { type = "item", name = "kr-sand", amount = 100, itembox_multiplyer = 4 }, -- 2.5sand per stone
    },
    results = {
      { type = "fluid", name = "lava", amount = 250, fluidbox_multiplier = 4 }, -- 40stone/2 making it less efficient
    },
    allow_productivity = false,
    show_amount_in_title = false,
  },
  -- create new K2 recipes
  { -- lava to quartz
    type = "recipe",
    name = "lava-to-quartz",
    icons = {
      {
        icon = "__Krastorio2Assets__/icons/items/quartz.png",
        icon_size = 64,
        icon_mipmaps = 1, -- hope that is still works
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
    energy_required = 40, -- 0.6s*40 lava-to-sand, 2.1s*8 filtration = 40.8 (rounded to 40 to be nice)
    ingredients = {
      { type = "fluid", name = "lava",    amount = 400, fluidbox_multiplier = 2 },
      { type = "item",  name = "calcite", amount = 1 }, -- automatically my "complex mode"
    },
    results = {
      { type = "item", name = "kr-quartz", amount = 48 }, --80 sand, 10sand too 6quartz, 18quartz to 9 silicon,
    },
    allow_productivity = true,
    show_amount_in_title = false,
  },
  { -- lava to silicon
    type = "recipe",
    name = "lava-to-silicon",
    icons = {
      {
        icon = "__Krastorio2Assets__/icons/items/silicon.png",
        icon_size = 64,
        icon_mipmaps = 1, -- hope that is still works
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
    energy_required = 64, -- 0.6s*40 lava-to-stone, 0.5*40 grinding sand(free), 2.1s*8 filtration, 16s*1.5smelting quartz = 64,8 (also rounded down)
    ingredients = {
      { type = "fluid", name = "lava",    amount = 400, fluidbox_multiplier = 2 },
      { type = "item",  name = "calcite", amount = 1 }, -- automatically my "complex mode"
    },
    results = {
      { type = "item", name = "kr-silicon", amount = 24 }, --80 sand, 10sand too 6quartz, 18quartz to 9 silicon,
    },
    allow_productivity = true,
    show_amount_in_title = false,
  },
})
if data.raw.recipe["oc-casting-glass"] then
  -- disable recipes that are overwritten/replaced by K2
  data.raw.recipe["oc-casting-glass"].enabled = false
  data.raw.recipe["oc-casting-glass"].hidden = true
end

-- 1. pepare the Generator
local generator_api = require("__OCs_base_assets__.prototypes.utils.api")
-- register new recipes to Generator
local new_alt_recipes = {
  ["kr-sand"] = { "lava-to-sand", "kr-sand" },
  ["kr-glass"] = { "oc-casting-kr-glass", "kr-glass" },
  ["kr-quartz"] = { "lava-to-quartz", "kr-quarz" },
  ["kr-silicon"] = { "lava-to-silicon", "kr-silicon" },
}
generator_api.register_category_alt_recipes("metallurgy", new_alt_recipes) -- check if correct usage

-- 2. Execute the Generator.
local casting_dict = {
  -- ["kr-sand"] = "metallurgy",
  ["kr-glass"] = "metallurgy",
  -- ["kr-quartz"] = "metallurgy", -- filtration process forbits quartz casting
  -- ["kr-silicon"] = "metallurgy", -- silicon is made from quartz, so no casting
  ["kr-black-reinforced-plate"] = "metallurgy",
  ["kr-white-reinforced-plate"] = "metallurgy",
}
generator_api.batch_generator(casting_dict)

local prod_recipes = {
  "oc-casting-kr-sand",
  "oc-casting-kr-glass",
  "oc-casting-kr-quartz",
  "oc-casting-kr-silicon",
}
oc_recipe.allow_productivity(prod_recipes)

-- 3. Add Recipes to Techs
local recipe_tech_mapping = {
  ["lava-to-sand"] = { "lava-to-stone-tech" },
  ["oc-casting-kr-glass"] = { "lava-to-stone-tech" },
  ["oc-casting-kr-black-reinforced-plate"] = { "casting-concrete-tech" },
  ["oc-casting-kr-white-reinforced-plate"] = { "casting-concrete-tech" },
}
oc_helper.add_recipe_unlocks(recipe_tech_mapping)

local new_prereqs = {
  ["casting-concrete-tech"] = "kr-reinforced-plates",
}
oc_tech.add_prerequisites(new_prereqs)

data:extend({
  -- create new K2 technology
  { -- advanced-mineral-processing (quartz and silicon from lava)
    type = "technology",
    name = "kr-advanced-mineral-processing-tech",
    icons = {
      {
        icon = "__space-age__/graphics/technology/foundry.png",
        icon_size = 256,
        icon_mipmaps = 4,
      },
      {
        icon = "__OCs_base_assets__/graphics/technology/overlayer-tech-kr-silicon.png",
        icon_size = 256,
        icon_mipmaps = 4,
      }
    },
    prerequisites = { "lava-to-stone-tech", "kr-silicon-processing", "metallurgic-science-pack", "production-science-pack" },
    unit = {
      ingredients = {
        { "chemical-science-pack",    1 },
        { "space-science-pack",       1 },
        { "production-science-pack",  1 },
        { "metallurgic-science-pack", 2 }
      },
      time = 60,
      count = 300
    },
    effects = {
      { type = "unlock-recipe", recipe = "lava-to-quartz" },
      { type = "unlock-recipe", recipe = "lava-to-silicon" },
    },
  }
})
