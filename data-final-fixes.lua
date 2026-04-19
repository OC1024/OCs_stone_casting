local oc_helper = require("__OCs_base_assets__.prototypes.utils.helper")

-- legacy support for calcite in casting recipes - more expensive
if settings.startup["expensive-lava-mode"].value then
  -- List of recipes to modify
  local recipes_to_update = { -- "casting" recipes
    "lava-to-stone",
    "lava-to-stone-brick",
    "oc-casting-concrete",
    "oc-casting-refined-concrete",
    "oc-casting-landfill",
    "oc-casting-foundation",
    "oc-casting-stone-furnace", -- seems a bit to expensive to add 1 calcite for 5 stone. Usually 1 calcite for 50 stone.
    "oc-casting-steel-furnace",
    "oc-casting-rail",
    "oc-casting-wall",
    "oc-casting-stone-wall",
    "oc-casting-gate",
    "lava-to-sand",
    -- aai-industry
    "oc-casting-concrete-wall",
    "oc-casting-steel-wall",
    "oc-casting-stone-tablet", -- seeems also a bit expensive 1 calcite for 4 stone-tablet
    "oc-casting-glass",
    -- krastorio2
    "oc-casting-kr-glass",
    -- "lava-to-quartz", -- would add calcite twice
    -- "lava-to-silicon", -- would add calcite twice
    -- Maraxsis
    "oc-casting-maraxsis-glass-panes",
    -- Metal and Stars
    "lava-to-silica-sand",
  }

  for _, recipe_name in pairs(recipes_to_update) do
    -- Add calcite as an additional ingredient
      oc_helper.add_ingredient(recipe_name, "item", "calcite", 1)
  end
end

-- normal complex mode - only melting is affected
if settings.startup["complex-lava-mode"].value then
  -- List of recipes to modify
  local recipes_to_update = { -- melting recipes
    "stone-to-lava",
    "sand-to-lava", -- if present
  }

  for _, recipe_name in pairs(recipes_to_update) do
    -- Add calcite as an additional ingredient
      oc_helper.add_ingredient(recipe_name, "item", "calcite", 1)
  end
end

oc_helper.allow_productivity({ "casting-glass", "casting-stone-tablet","casting-kr-glass" })