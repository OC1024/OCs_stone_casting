data:extend({
  { -- lava-to-stone
    type = "technology",
    name = "lava-to-stone-tech",
    icon = "__OCs_stone_casting__/graphics/icons/lava-stone.png",
		icon_size = 64,
    icon_mipmaps = 4,
    prerequisites = {"foundry","railway"},
    unit = {
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        -- {"metallurgic-science-pack", 2}
      },
      time = 30,
      count = 200
      },
    effects = {
     {type = "unlock-recipe", recipe = "lava-to-stone-recipe"},
     {type = "unlock-recipe", recipe = "lava-to-brick-recipe"},
    --  {type = "unlock-recipe", recipe = "lava-to-wall-recipe"},
    {type = "unlock-recipe", recipe = "casting-rail"}
    },
    --  order = "a"
  },
  { -- casting concrete
    type = "technology",
    name = "casting-concrete-tech",
    icons =
    {
      {
        icon = "__base__/graphics/technology/concrete.png",
        icon_size = 256,
        icon_mipmaps = 4,
      },
      {
        icon = "__OCs_stone_casting__/graphics/icons/overlayer-recipe-lava-droplet.png",
        icon_size = 64,
        icon_mipmaps = 4,
        icon_scale = 4,
      }
    },
    prerequisites = {"lava-to-stone-tech","concrete"}, -- concrete is already, indirectly, a prerequisit. 
    unit = {
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"metallurgic-science-pack", 2}
      },
      time = 60,
      count = 250
      },
      effects = {
       {type = "unlock-recipe", recipe = "casting-concrete-recipe"},
       {type = "unlock-recipe", recipe = "casting-refined-concrete-recipe"}
      },
  },
  { -- casting wall + gate
    type = "technology",
    name = "casting-wall-tech",
    icons = 
    {
      {
        icon = "__base__/graphics/technology/stone-wall.png",
        icon_size = 256,
        icon_mipmaps = 4,
      },
      {
        icon = "__OCs_stone_casting__/graphics/icons/overlayer-recipe-lava-droplet.png",
        icon_size = 64,
        icon_mipmaps = 4,
        icon_scale = 4,
      }
    },
    prerequisites = {"lava-to-stone-tech","gate"},
    unit =
    {
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"military-science-pack", 2}
      },
      time = 45,
      count = 300
      },
      effects = {
       {type = "unlock-recipe", recipe = "lava-to-wall-recipe"},
      --  {type = "unlock-recipe", recipe = "casting-gate"} -- will be added in data-lua stage
      },
  }
})

-- changes to technologies
if settings.startup["allow-stone-to-lava"].value then
 local mapping = {
    ["stone-to-lava-recipe"] = {"lava-to-stone-tech"},
 }
 add_recipe_unlocks(mapping)
end

-- Inject the recipe unlock into the technology
local mapping = {
  ["lava-to-landfill-recipe"] = {"lava-to-stone-tech"},
}
add_recipe_unlocks(mapping)

-- Conditionally included technologies
if settings.startup["allow-casting-foundation"].value then
  data:extend({
  { -- casting foundation
    type = "technology",
    name = "casting-foundation-tech",
    icons =
    {
      {
        icon = "__space-age__/graphics/technology/foundation.png",
        icon_size = 256,
        icon_mipmaps = 4,
      },
      {
        icon = "__OCs_base_assets__/graphics/icons/overlayer-recipe-lava-droplet.png",
        icon_size = 64,
        icon_mipmaps = 4,
        icon_scale = 4,
      }
    },
    icon_size = 256, icon_mipmaps = 4,
    prerequisites = {"casting-concrete-tech","foundation"},
    unit = {
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"space-science-pack", 1},
        {"metallurgic-science-pack", 2},
        {"agricultural-science-pack", 1},
        {"electromagnetic-science-pack", 1},
        {"cryogenic-science-pack", 1}
      },
      time = 60,
      count = 1000
      },
      effects = {
        {type = "unlock-recipe", recipe = "casting-foundation-recipe"},
      },
      -- order = "zzw",
  }
  })
end