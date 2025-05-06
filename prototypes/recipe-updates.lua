if data.raw["item"]["sand"] then
  data:extend({
    { -- lava to sand
      type = "recipe",
      name = "lava-to-sand-recipe",
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
      show_amount_in_title =false,
    },
  })
end

-- used the casting-generator
local whitelist = {
  -- "stone", -- test
  -- "stone-brick", --test
  -- "concrete", -- test
  -- "refined-concrete", -- test
  -- "foundation",
  "stone-furnace",
  "steel-furnace",
  -- "stone-wall", -- test
  "gate",
  "rail"
  -- extend as needed
}
if data.raw["item"]["sand"] then
  table.insert(whitelist, "sand")
end
batch_generator(whitelist)