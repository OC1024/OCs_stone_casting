if data.raw["item"]["sand"] then
  data:extend({
    { -- lava to sand
      type = "recipe",
      name = "lava-to-sand-recipe",
      icon = "__OCs_stone_casting__/graphics/icons/casting-sand.png", -- sand icon stolen from Kastorio2. 
      icons =
      {
        {
          icon = "__OCs_stone_casting__/graphics/icons/sand.png",
          icon_size = 64,
          icon_mipmaps = 4,
        },
        {
          icon = "__OCs_stone_casting__/graphics/icons/overlayer-recipe-lava-droplet.png",
          icon_size = 64,
          icon_mipmaps = 4,
        }
      },
      category = "metallurgy",
      enabled = false,
      energy_required = 24+20, --24 for 40 stone, 0.5*40 grinding sand
      ingredients = {
        {type = "fluid", name = "lava", amount = 400, fluidbox_multiplier = 4}, -- 40 stone
      },
      results = {
        {type = "item", name = "sand", amount = 80}, -- 2sand per stone
      },
      allow_productivity = false,
    },
    { -- sand to lava
      type = "recipe",
      name = "sand-to-lava-recipe",
      icon = "__OCs_stone_casting__/graphics/icons/lava-sand.png",
      icons = {
        {
          icon = "__OCs_base_assets__/grapics/icons/sand.png", -- stolen from Kastorio2. I like that one better than the aai sand icon
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
      group = "intermediate-products",
      subgroup= "vulcanus-processes",
      order = "a[melting]-a[lava-c]",
      enabled = false,
      energy_required = 32, --twice as fast as stone-to-lava since sand is smaller
      ingredients = {
        {type = "item", name = "sand", amount = 80, itembox_multiplyer = 4}, -- 2sand per stone
      },
      results = {
        {type = "fluid", name = "lava", amount = 200, fluidbox_multiplier = 4}, -- 40stone/2 making it less efficient
      },
      allow_productivity = false,
    },
  })
end

if mods["aai-industry"] then
  data:extend({
    -- {
    --     type = "recipe",
    --     name = "lava-to-sand-recipe",
    --     icon = "__OCs_stone_casting__/graphics/icons/casting-sand.png",
    --     icon_size = 64,
    --     icon_mipmaps = 4,
    --     category = "metallurgy",
    --     enabled = false,
    --     energy_required = 64, -- last step only: 0.5 per sand
    --     ingredients = {
    --       {type = "fluid", name = "lava", amount = 400, fluidbox_multiplier = 4},
    --     },
    --     results = {
    --       {type = "item", name = "sand", amount = 80}, -- 2sand per stone
    --     },
    -- },
    { -- lava-to-stone-wall-recipe
        type = "recipe",
        name = "lava-to-stone-wall-recipe",
        icons = {
          {
            icon = "__aai-industry__/grapics/icons/stone-wall.png",
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
        energy_required = 8, -- amount*time: 2*0.5 iron-stick + 10*0.5 lava-to-sand
        ingredients = {
          {type = "fluid", name = "lava", amount = 320, fluidbox_multiplier = 4} --2iron-sticks + 10sand + 5brick =160lava
        },
        results = {
          {type = "item", name = "stone-wall", amount = 2}
        },
        allow_productivity = false,
        show_amount_in_title = false,
    },
    { -- lava-to-steel-wall-recipe
        type = "recipe",
        name = "lava-to-steel-wall-recipe",
        icons = {
          {
            icon = "__aai-industry__/grapics/icons/steel-wall.png",
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
        energy_required = 32, -- amount*time: 2*8 concrete-wall + 5*3.2 steel 2*1 steel-wall
        ingredients = {
          {type = "fluid", name = "lava", amount = 420, fluidbox_multiplier = 4} -- 1wall + 5steel= 210lava
        },
        results = {
          {type = "item", name = "stone-wall", amount = 2}
        },
        allow_productivity = false,
        show_amount_in_title = false
    },
  }) -- still if aai-industry
  local recipe_modifications = {
    {
      recipe = "lava-to-walls-recipe",
      ingredients = {
        {type = "fluid", name = "lava", amount = 400, fluidbox_multiplier = 4} -- 12concrete + 1 stone wall
      },
      -- results = {
      --   {type = "item", name = "wall", amount = 1},
      -- },
      description = "Adapted for AAI Industry balance",
    },
    {
      recipe = "casting-concrete-recipe",
      ingredients = {
        {type = "fluid", name = "water", amount = 400, fluidbox_multiplier = 2},
        {type = "fluid", name = "lava", amount = 640, fluidbox_multiplier = 2} -- 10lava/stone: 10sand * 5brick + 2iron-stick (easymode: 10lava=2iron-stick). volume x4
      },
      results = {
        {type = "item", name = "concrete", amount = 40},
      },
      description = "Adapted for AAI Industry balance",
    },
    {
      recipe = "casting-refined-concrete-recipe",
      ingredients = {
        {type = "fluid", name = "water", amount = 600, fluidbox_multiplier = 2},
        {type = "fluid", name = "lava", amount = 780, fluidbox_multiplier = 2} -- 20concrete +1steel+8iron-stick (easymode: 40lava=8iron-stick)=390. volume x2
      },
      results = {
        {type = "item", name = "refined-concrete", amount = 20}
      },
      description = "Adapted for AAI Industry balance",
    }
  }
  replace_multiple_recipes((recipe_modifications)) -- do all replacements at once with the helper function
end