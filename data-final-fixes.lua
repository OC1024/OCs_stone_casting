require("__OCs_base_assets__.prototypes.utils.helper")

-- legacy support for calcite in casting recipes - more expensive
if settings.startup["expensive-lava-mode"].value then
  -- List of recipes to modify
  local recipes_to_update = { -- "casting" recipes
    "lava-to-stone",
    "lava-to-stone-brick",
    "casting-concrete",
    "casting-refined-concrete",
    "casting-landfill",
    "casting-foundation",
    "casting-stone-furnace", -- seems a bit to expensive to add 1 calcite for 5 stone. Usually 1 calcite for 50 stone.
    "casting-steel-furnace",
    "casting-rail",
    "casting-wall",
    "casting-stone-wall",
    "casting-gate",
    "lava-to-sand",
    -- aai-industry
    "casting-concrete-wall",
    "casting-steel-wall",
    "casting-stone-tablet", -- seeems also a bit expensive 1 calcite for 4 stone-tablet
    "casting-glass",
    -- krastorio2
    "casting-kr-glass",
    -- "lava-to-quartz", -- would add calcite twice
    -- "lava-to-silicon", -- would add calcite twice
    -- Maraxsis
    "casting-maraxsis-glass-panes",
    -- Metal and Stars
    "lava-to-silica-sand",
  }

  for _, recipe_name in pairs(recipes_to_update) do
    -- Add calcite as an additional ingredient
      add_ingredient(recipe_name, "item", "calcite", 1)
  end
end

-- normal complex mode - only melting is affected
if settings.startup["complex-lava-mode"].value then
  -- List of recipes to modify
  local recipes_to_update = { -- melting recipes
    "stone-to-lava",
    "sand-to-lava",
  }

  for _, recipe_name in pairs(recipes_to_update) do
    -- Add calcite as an additional ingredient
      add_ingredient(recipe_name, "item", "calcite", 1)
  end
end

allow_productivity({ "casting-glass", "casting-stone-tablet","casting-kr-glass" })