
if data.raw["item"]["sand"] then
  data:extend({
    { -- lava to sand
      type = "recipe",
      name = "lava-to-sand",
      icons =
      {
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
      energy_required = 24, --24 for 40 stone, 0.5*40 grinding sand (free)
      ingredients = {
        {type = "fluid", name = "lava", amount = 400, fluidbox_multiplier = 4}, -- 40 stone
      },
      results = {
        {type = "item", name = "sand", amount = 80}, -- 2sand per stone
      },
      allow_productivity = true,
      show_amount_in_title =false,
    },
    { -- sand to lava
      type = "recipe",
      name = "sand-to-lava",
      icon = "__OCs_stone_casting__/graphics/icons/lava-sand.png",
      icon_size = 64,
      icon_mipmaps = 4,
      category = "metallurgy",
      group = "intermediate-products",
      subgroup= "vulcanus-processes",
      order = "a[melting]-a[lava-c]",
      enabled = false,
      energy_required = 16, --twice as fast as stone-to-lava since sand is smaller
      ingredients = {
        {type = "item", name = "sand", amount = 100, itembox_multiplyer = 4}, -- 2sand per stone
      },
      results = {
        {type = "fluid", name = "lava", amount = 250, fluidbox_multiplier = 4}, -- 40stone/2 making it less efficient
      },
      allow_productivity = false,
      show_amount_in_title =false,
    },
  })
end

--[[ data:extend({
--     { -- lava-to-stone-wall-recipe
--         type = "recipe",
--         name = "lava-to-stone-wall-recipe",
--         icons = {
--         {
--             icon = "__aai-industry__/graphics/icons/stone-wall.png",
--             icon_size = 64,
--             icon_mipmaps = 4,
--         },
--         {
--             icon = "__OCs_base_assets__/graphics/icons/overlayer-recipe-lava-droplet.png",
--             icon_size = 64,
--             icon_mipmaps = 4,
--         }
--         },
--         category = "metallurgy",
--         enabled = false,
--         energy_required = 8, -- amount*time: 2*0.5 iron-stick + 10*0.5 lava-to-sand
--         ingredients = {
--             {type = "fluid", name = "lava", amount = 320, fluidbox_multiplier = 4} --2iron-sticks + 10sand + 5brick =160lava
--         },
--         results = {
--             {type = "item", name = "stone-wall", amount = 1}
--         },
--         allow_productivity = false,
--         show_amount_in_title = false,
--     },
--     { -- lava-to-steel-wall-recipe
--         type = "recipe",
--         name = "lava-to-steel-wall-recipe",
--         icons = {
--         {
--             icon = "__aai-industry__/graphics/icons/steel-wall.png",
--             icon_size = 64,
--             icon_mipmaps = 4,
--         },
--         {
--             icon = "__OCs_base_assets__/graphics/icons/overlayer-recipe-lava-droplet.png",
--             icon_size = 64,
--             icon_mipmaps = 4,
--         }
--         },
--         category = "metallurgy",
--         enabled = false,
--         energy_required = 32, -- amount*time: 2*8 concrete-wall + 5*3.2 steel 2*1 steel-wall
--         ingredients = {
--             {type = "fluid", name = "lava", amount = 480, fluidbox_multiplier = 4} -- 1 concrete wall + 5steel= 210lava
--         },
--         results = {
--             {type = "item", name = "steel-wall", amount = 1}
--         },
--         allow_productivity = false,
--         show_amount_in_title = false
--     },
-- })
-- local recipe_modifications = {
--     { -- lava-to-wall-recipe (concrete wall)
    -- recipe = "lava-to-wall-recipe",
    -- ingredients = {
    --     {type = "fluid", name = "lava", amount = 400, fluidbox_multiplier = 4} -- 12concrete + 1 stone wall
    -- },
    -- results = {
    --     {type = "item", name = "concrete-wall", amount = 1},
    -- },
    -- description = "Adapted for AAI Industry balance",
--     },
--     { -- casting-concrete-recipe
--     recipe = "casting-concrete-recipe",
--     ingredients = {
--         {type = "fluid", name = "water", amount = 400, fluidbox_multiplier = 2},
--         {type = "fluid", name = "lava", amount = 640, fluidbox_multiplier = 2} -- 10lava/stone: 10sand * 5brick + 2iron-stick (easymode: 10lava=2iron-stick). volume x4
--     },
--     results = {
--         {type = "item", name = "concrete", amount = 40},
--     },
--     description = "Adapted for AAI Industry balance",
--     },
--     { -- casting-refined-concrete-recipe
--     recipe = "casting-refined-concrete-recipe",
--     ingredients = {
--         {type = "fluid", name = "water", amount = 600, fluidbox_multiplier = 2},
--         {type = "fluid", name = "lava", amount = 780, fluidbox_multiplier = 2} -- 20concrete +1steel+8iron-stick (easymode: 40lava=8iron-stick)=390. volume x2
--     },
--     results = {
--         {type = "item", name = "refined-concrete", amount = 20}
--     },
--     description = "Adapted for AAI Industry balance",
--     }
-- }
-- replace_multiple_recipes((recipe_modifications)) -- do all replacements at once with the helper function
--]]

-- new code utilizing my generator
-- pepare the generator
local generator_api = require("__OCs_base_assets__.prototypes.utils.api")

-- add new alterative recipes for the generator to use

local new_alt_recipes = {
  ["sand"] = {"lava-to-sand","sand"},
}
generator_api.register_category_alt_recipes("metallurgy", new_alt_recipes)

-- create new recipes
local casting_dict = {
  ["stone-wall"] = "metallurgy", -- overwrite vanilla version
  ["concrete-wall"] = "metallurgy",
  ["steel-wall"] = "metallurgy",
  ["stone-tablet"] = "metallurgy",
  ["glass"] = "metallurgy",
}
generator_api.batch_generator(casting_dict)

-- remove and add recipes from techs
add_prerequisite("casting-wall-tech", "steel-walls")
add_prerequisite("casting-wall-tech", "casting-concrete-tech") -- since the concrete wall needs concrete
-- remove_recipes_from_tech("casting-wall-tech", {"lava-to-wall"}) -- doesn't exist anymore

-- add recipes to technology
local mapping  = {
  ["lava-to-sand"] = {"lava-to-stone-tech"},
  -- ["lava-to-wall"] = {"casting-wall-tech"}, -- old name
  ["casting-stone-wall"] = {"casting-wall-tech"}, -- already there
  ["casting-concrete-wall"] = {"casting-wall-tech"},
  ["casting-steel-wall"] = {"casting-wall-tech"},
  ["casting-stone-tablet"] = {"foundry"},
  ["casting-glass"] = {"lava-to-stone-tech"},
}
add_recipe_unlocks(mapping)
if settings.startup["allow-stone-to-lava"].value then
  local mapping = {
    ["sand-to-lava"] = {"lava-to-stone-tech"}
  }
  add_recipe_unlocks(mapping)
end