data:extend({
    { -- lava to stone
      type = "recipe",
      name = "lava-to-stone-recipe",
      icons =
      {
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
      icon_size = 64, icon_mipmaps = 4,
      category = "metallurgy",
      enabled = false,
      energy_required = 24, -- like the lava-to-metal: 10 liquid = 1 item. new time: 0.6 time per stone
      ingredients = {
        {type = "fluid", name = "lava", amount = 400, fluidbox_multiplier = 4},
      },
      results = {
        {type = "item", name = "stone", amount = 40},
      },
      allow_productivity = true,
    },
    { -- stone to lava
      type = "recipe",
      name = "stone-to-lava-recipe",
      icon = "__OCs_stone_casting__/graphics/icons/lava-stone.png",
      icon_size = 64, icon_mipmaps = 4,
      category = "metallurgy",
      group = "intermediate-products",
      subgroup= "vulcanus-processes",
      order = "a[melting]-a[lava-c]",
      enabled = false,
      energy_required = 64, -- 1 stone = 10 liquid. new time: 0.6
      ingredients = {
        {type = "item", name = "stone", amount = 50},
      },
      results = {
        {type = "fluid", name = "lava", amount = 250},
      },
      allow_productivity = false,
      show_amount_in_title =false,
    },
    { -- lava to brick
      type = "recipe",
      name = "lava-to-brick-recipe",
      icons =
      {
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
      category = "metallurgy",
      enabled = false,
      energy_required = 12, -- like liquid-metal-to-metal:  2stone to 1brick but 20x volume. new time: 20x0.6=12
      ingredients = {
        {type = "fluid", name = "lava", amount = 400, fluidbox_multiplier = 4}
      },
      results = {
        {type = "item", name = "stone-brick", amount = 20}
      },
      allow_productivity = true,
    },
    { -- lava to wall
      type = "recipe",
      name = "lava-to-wall-recipe",
      icons =
      {
        {
          icon = "__base__/graphics/icons/wall.png",
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
      energy_required = 2.4, -- 5*3.2 stone-to-brick but ignoring 2*0.5 brick-to-wall. Volume is 2x. new time: 0.6x4=2.4
      ingredients = {
        {type = "fluid", name = "lava", amount = 400, fluidbox_multiplier = 4}
      },
      results = {
        {type = "item", name = "stone-wall", amount = 4} -- 10lava/stone * 2stone/brick * 5brick/wall = 100lava/wall
      },
      allow_productivity = false,
      show_amount_in_title = false
    },
    { -- lava to concrete
      type = "recipe",
      name = "casting-concrete-recipe",
      icons =
      {
        {
          icon = "__base__/graphics/icons/concrete.png",
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
      energy_required = 40, -- using last step: 10 brick-to-concrete. volume x4.
      ingredients = {
        {type = "fluid", name = "water", amount = 400, fluidbox_multiplier = 2},
        {type = "fluid", name = "lava", amount = 480, fluidbox_multiplier = 2} -- 10lava/stone * 2stone/brick * 5 bricks/concrete + 20 due iron (easymode)
      },
      results = {
        {type = "item", name = "concrete", amount = 40}
      },
      allow_productivity = false,
    },
    { -- lava to refined concrete
      type = "recipe",
      name = "casting-refined-concrete-recipe",
      icons =
      {
        {
          icon = "__base__/graphics/icons/refined-concrete.png",
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
      energy_required = 70, -- time: 20lava-to-concrete + 15 concrete-to-refined-concrete. volume x2
      ingredients = {
        {type = "fluid", name = "water", amount = 600, fluidbox_multiplier = 2}, -- 200 from concrete+ 100 from refined concrete. volume x2
        {type = "fluid", name = "lava", amount = 620, fluidbox_multiplier = 2} -- 240concrete + 1steel + 8iron-stick  (easymode: steel=30lava, iron-stick=5lava)=310lava. volume x2
      },
      results = {
        {type = "item", name = "refined-concrete", amount = 20}
      },
      allow_productivity = false,
    },
    { -- casting foundation
      type = "recipe",
      name = "casting-foundation-recipe",
      icons =
      {
        {
          icon = "__space-age__/graphics/icons/foundation.png",
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
      energy_required = 30, -- 0.6*20=12lava-to-stone + 30 foundation. only last step: 30
      ingredients = {
        {type = "item", name = "tungsten-plate", amount = 4},
        {type = "item", name = "lithium-plate", amount = 4},
        {type = "item", name = "carbon-fiber", amount = 4},
        {type = "fluid", name = "lava", amount = 200, fluidbox_multiplier = 4}, -- equal to 20 stone
        {type = "fluid", name = "fluoroketone-cold", amount = 20, fluidbox_multiplier = 4}
      },
      results = {
        {type = "item", name = "foundation", amount = 1}
      },
      surface_conditions = --I am just mean
      {
        {
          property = "pressure",
          min = 4000,
          max = 4000
        }
      },
      allow_productivity = false,
    },
    { -- lava to landfill
      type = "recipe",
      name = "lava-to-landfill-recipe",
      icons =
      {
        {
          icon = "__base__/graphics/icons/landfill.png",
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
      energy_required = 30, --24 for 40 stone, 0.5 for 1 landfill. 
      ingredients = {
        {type = "fluid", name = "lava", amount = 500, fluidbox_multiplier = 4}, -- 50 stone
      },
      results = {
        {type = "item", name = "landfill", amount = 1},
      },
      allow_productivity = false,
    },
})