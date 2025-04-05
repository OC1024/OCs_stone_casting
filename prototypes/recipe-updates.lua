if data.raw["item"]["sand"] then
  data:extend({
    {
      type = "recipe",
      name = "lava-to-sand-recipe",
      icon = "__OCs_stone_casting__/graphics/icons/casting-sand.png",
      icon_size = 64,
      icon_mipmaps = 4,
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
    {
        type = "recipe",
        name = "lava-to-stone-wall-recipe",
        icon = "__OCs_stone_casting__/graphics/icons/casting-stone-wall.png",
        icon_size = 64,
        icon_mipmaps = 4,
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
    },
    {
        type = "recipe",
        name = "lava-to-steel-wall-recipe",
        icon = "__OCs_stone_casting__/graphics/icons/casting-steel-wall.png",
        icon_size = 64,
        icon_mipmaps = 4,
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
    },
  }) -- still if aai-industry

  if data.raw.recipe["lava-to-walls-recipe"] then
    data.raw.recipe["lava-to-walls-recipe"].ingredients = {
      {type = "fluid", name = "lava", amount = 400, fluidbox_multiplier = 4} -- 12concrete + 1 stone wall
    }
    log("Modified ingredients for lava-to-walls-recipe.")
  else
    log("Warning: Recipe 'lava-to-walls-recipe' not found.")
  end
  if data.raw.recipe["casting-concrete-recipe"] then
    data.raw.recipe["casting-concrete-recipe"].ingredients = {
      {type = "fluid", name = "water", amount = 400, fluidbox_multiplier = 2},
      {type = "fluid", name = "lava", amount = 640, fluidbox_multiplier = 2} -- 10lava/stone: 10sand * 5brick + 2iron-stick (easymode: 10lava=2iron-stick). volume x4
    }
    data.raw.recipe["casting-concrete-recipe"].results = {
      {type = "item", name = "concrete", amount = 40}
    }
    log("Modified ingredients for casting-concrete-recipe.")
  else
    log("Warning: Recipe 'casting-concrete-recipe' not found.")
  end
  if data.raw.recipe["casting-refined-concrete-recipe"] then
    data.raw.recipe["casting-refined-concrete-recipe"].ingredients = {
      {type = "fluid", name = "water", amount = 600, fluidbox_multiplier = 2},
      {type = "fluid", name = "lava", amount = 780, fluidbox_multiplier = 2} -- 20concrete +1steel+8iron-stick (easymode: 40lava=8iron-stick)=390. volume x2
    }
    data.raw.recipe["casting-refined-concrete-recipe"].results = {
      {type = "item", name = "refined-concrete", amount = 20}
    }
    log("Modified ingredients for casting-refined-concrete-recipe.")
  else
    log("Warning: Recipe 'casting-refined-concrete-recipe' not found.")
  end
  log("Successfully updated recipes.")
end