local oc_tech = require("__OCs_base_assets__.prototypes.utils.oc_tech")

data:extend({
  { -- lava-to-stone
    type = "technology",
    name = "lava-to-stone-tech",
    icon = "__OCs_stone_casting__/graphics/icons/lava-stone.png",
    icon_size = 64,
    icon_mipmaps = 4,
    prerequisites = { "foundry", "railway", "landfill", "advanced-material-processing", "space-science-pack", "metallurgic-science-pack" },
    unit = {
      ingredients = {
        { "automation-science-pack",  1 },
        { "logistic-science-pack",    1 },
        { "chemical-science-pack",    1 },
        { "space-science-pack",        1 }, -- removed if correct starter planet
        { "metallurgic-science-pack", 2 }, -- removed if correct starter planet
      },
      time = 30,
      count = 200
    },
    effects = {
      { type = "unlock-recipe", recipe = "lava-to-stone" },
      { type = "unlock-recipe", recipe = "lava-to-stone-brick" },
      { type = "unlock-recipe", recipe = "oc-casting-rail" },
      { type = "unlock-recipe", recipe = "oc-casting-landfill" },
      { type = "unlock-recipe", recipe = "oc-casting-stone-furnace" },
      { type = "unlock-recipe", recipe = "oc-casting-steel-furnace" },
    },
  },
  { -- casting concrete
    type = "technology",
    name = "casting-concrete-tech",
    icons = {
      {
        icon = "__base__/graphics/technology/concrete.png",
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
    prerequisites = { "lava-to-stone-tech", "concrete" }, -- concrete is already, indirectly, a prerequisit.
    unit = {
      ingredients = {
        { "automation-science-pack",  1 },
        { "logistic-science-pack",    1 },
        { "chemical-science-pack",    1 },
        { "space-science-pack",       1 },  -- removed if correct starter planet
        { "metallurgic-science-pack", 2 },  -- removed if correct starter planet
      },
      time = 60,
      count = 250
    },
    effects = {
      { type = "unlock-recipe", recipe = "oc-casting-concrete" },
      { type = "unlock-recipe", recipe = "oc-casting-refined-concrete" }
    },
  },
  { -- casting stone-wall + gate
    type = "technology",
    name = "casting-wall-tech",
    icons = {
      {
        icon = "__base__/graphics/technology/stone-wall.png",
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
    prerequisites = { "lava-to-stone-tech", "gate" },
    unit = {
      ingredients = {
        { "automation-science-pack",  1 },
        { "logistic-science-pack",    1 },
        { "chemical-science-pack",    1 },
        { "military-science-pack",    2 },
        { "space-science-pack",       1 },  -- removed if correct starter planet
        { "metallurgic-science-pack", 2 },  -- removed if correct starter planet
      },
      time = 45,
      count = 300
    },
    effects = {
      { type = "unlock-recipe", recipe = "oc-casting-stone-wall" },
      { type = "unlock-recipe", recipe = "oc-casting-gate" }
    },
  }
})

-- changes to technologies
if settings.startup["allow-stone-to-lava"].value then
  local mapping = {
    ["stone-to-lava"] = { "lava-to-stone-tech" },
  }
  oc_tech.add_recipe_unlocks(mapping)
end

-- Conditionally included technologies
if settings.startup["allow-casting-foundation"].value then
  data:extend({
    { -- casting foundation
      type = "technology",
      name = "casting-foundation-tech",
      icons = {
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
      icon_size = 256,
      icon_mipmaps = 4,
      prerequisites = { "casting-concrete-tech", "foundation" },
      unit = {
        ingredients = {
          { "automation-science-pack",      1 },
          { "logistic-science-pack",        1 },
          { "chemical-science-pack",        1 },
          { "production-science-pack",      1 },
          { "utility-science-pack",         1 },
          { "space-science-pack",           1 },
          { "metallurgic-science-pack",     2 }, -- it's all about casting
          { "agricultural-science-pack",    1 },
          { "electromagnetic-science-pack", 1 },
          { "cryogenic-science-pack",       1 }
        },
        time = 60,
        count = 1000
      },
      effects = {
        { type = "unlock-recipe", recipe = "oc-casting-foundation" },
      },
    }
  })
end
