local generator_api       = require("__OCs_base_assets__.prototypes.utils.api")
local oc_tech             = require("__OCs_base_assets__.prototypes.utils.oc_tech")
local oc_recipe           = require("__OCs_base_assets__.prototypes.utils.oc_recipe")
local constants           = require("prototypes.constants")
local stone_amount        = constants.stone_amount
local stone_energy        = constants.stone_energy -- crafting time per item

-- energy and results calculation:
-- per item definitions
local sand_per_stone      = 2.5 -- 7-8 sand from 3 stone
local quartz_per_sand     = 0.6 -- 6/10
local silicon_per_quartz  = 0.5 -- 9/18

-- 24s for 40 stone, 0.5*40 grinding sand (free)
local filtration_per_sand = 2.1 / 10
local smelting_per_quartz = 1.5 / 18

local sand_amount         = stone_amount * sand_per_stone
local sand_energy         = stone_amount * stone_energy

-- 0.6s*40 lava-to-sand, 2.1s*8 filtration = 40.8 (rounded to 40 to be nice)
local quartz_amount       = sand_amount * quartz_per_sand
local quartz_energy       = math.floor((sand_energy + sand_amount * filtration_per_sand) * 10) / 10

-- 0.6s*40 lava-to-stone, 0.5*40 grinding sand(free), 2.1s*8 filtration, 16s*1.5smelting quartz = 64,8 (also rounded down)
local silicon_amount      = quartz_amount * silicon_per_quartz
local silicon_energy      = math.floor((quartz_energy + quartz_amount * smelting_per_quartz) * 10) / 10


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
    categories = { "metallurgy" },
    enabled = false,
    energy_required = sand_energy,
    ingredients = {
      { type = "fluid", name = "lava", amount = stone_amount * 10, fluidbox_multiplier = 4 },
    },
    results = {
      { type = "item", name = "kr-sand", amount = sand_amount },
    },
    allow_productivity = true,
    show_amount_in_title = false,
  },
  -- create new K2-specific recipes
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
    categories = { "metallurgy" },
    enabled = false,
    energy_required = quartz_energy,
    ingredients = {
      { type = "fluid", name = "lava",    amount = stone_amount * 10, fluidbox_multiplier = 4 },
      { type = "item",  name = "calcite", amount = 1 }, -- automatically my "complex mode"
    },
    results = {
      { type = "item", name = "kr-quartz", amount = quartz_amount },
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
    categories = {"metallurgy"},
    enabled = false,
    energy_required = silicon_energy,
    ingredients = {
      { type = "fluid", name = "lava",    amount = stone_amount * 10, fluidbox_multiplier = 4 },
      { type = "item",  name = "calcite", amount = 1 }, -- automatically my "complex mode"
    },
    results = {
      { type = "item", name = "kr-silicon", amount = silicon_amount },
      -- 80 sand, 10sand too 6quartz, 18quartz to 9 silicon,
    },
    allow_productivity = true,
    show_amount_in_title = false,
  },
})

if settings.startup["allow-stone-to-lava"].value then
  data:extend({
    -- overwrite kr-sand to lava
    { -- kr-sand to lava
      type = "recipe",
      name = "sand-to-lava",
      icon = "__OCs_stone_casting__/graphics/icons/lava-sand.png",
      icon_size = 64,
      icon_mipmaps = 4,
      categories = {"metallurgy"},
      group = "intermediate-products",
      subgroup = "vulcanus-processes",
      order = "a[melting]-a[lava-c]-b",
      enabled = false,
      energy_required = 16,
      --twice as fast as stone-to-lava since sand is smaller
      ingredients = {
        { type = "item", name = "kr-sand", amount = 50*2.5, itembox_multiplyer = 4 }, -- 2.5sand per stone ( 7-8sand per 2stone)
      },
      results = {
        { type = "fluid", name = "lava", amount = 250, fluidbox_multiplier = 4 }, -- halfed to reduce positive feedback
      },
      allow_productivity = false,
      show_amount_in_title = false,
    },
  })
end

if data.raw.recipe["oc-casting-glass"] then
  -- disable recipes that are overwritten/replaced by K2
  data.raw.recipe["oc-casting-glass"].enabled = false
  data.raw.recipe["oc-casting-glass"].hidden = true
end

-- register new recipes to Generator
local new_alt_recipes = {
  ["kr-sand"] = {
    [50] = "lava-to-sand",
    [30] = "kr-sand"
  },
  ["kr-glass"] = {
    [50] = "oc-casting-kr-glass",
    [30] = "kr-glass"
  },
  ["kr-quartz"] = {
    [40] = "lava-to-quartz",
    [20] = "kr-quarz"
  },
  ["kr-silicon"] = {
    [40] = "lava-to-silicon",
    [20] = "kr-silicon"
  },
}
generator_api.register_category_alt_recipes("metallurgy", new_alt_recipes) -- check if correct usage

-- 2. Execute the Generator.
local casting_dict = {
  -- ["kr-sand"] = "metallurgy",
  ["kr-glass"] = "metallurgy",
  -- ["kr-quartz"]  = "metallurgy", -- filtration process forbits quartz casting
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
}
oc_tech.add_recipe_unlocks(recipe_tech_mapping)


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
    prerequisites = { "lava-to-stone-tech", "kr-silicon-processing", "production-science-pack", "space-science-pack", "metallurgic-science-pack" },
    unit = {
      ingredients = {
        { "chemical-science-pack",    1 },
        { "space-science-pack",       1 }, -- removed if correct starter planet
        { "production-science-pack",  1 },
        { "metallurgic-science-pack", 2 }, -- removed if correct starter planet
      },
      time = 60,
      count = 300
    },
    effects = {
      { type = "unlock-recipe", recipe = "lava-to-quartz" },
      { type = "unlock-recipe", recipe = "lava-to-silicon" },
    },
  },
  { -- casting reinforced plates
    type = "technology",
    name = "cast-reinforced-plates-tech",
    icons = {
      {
        icon = "__space-age__/graphics/technology/foundry.png",
        icon_size = 256,
        icon_mipmaps = 4,
      },
      {
        icon = "__OCs_base_assets__/graphics/technology/overlayer-tech-kr-reinforced-plates.png",
        icon_size = 256,
        icon_mipmaps = 4,
      }
    },
    prerequisites = { "casting-concrete-tech", "kr-reinforced-plates", "space-science-pack", "metallurgic-science-pack" },
    unit = {
      ingredients = {
        { "chemical-science-pack",    1 },
        { "space-science-pack",       1 }, -- removed if correct starter planet
        { "production-science-pack",  1 },
        { "metallurgic-science-pack", 2 }, -- removed if correct starter planet
      },
      time = 60,
      count = 250
    },
    effects = {
      { type = "unlock-recipe", recipe = "oc-casting-kr-black-reinforced-plate" },
      { type = "unlock-recipe", recipe = "oc-casting-kr-white-reinforced-plate" },
    },
  }
})
