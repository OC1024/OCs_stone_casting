
if settings.startup["expensive-lava-mode"].value then
  -- List of recipes to modify
  local recipes_to_update = {
    "lava-to-stone-recipe",
    "lava-to-brick-recipe",
    "lava-to-wall-recipe",
    "casting-concrete-recipe",
    "casting-refined-concrete-recipe",
    "casting-foundation-recipe",
    "casting-stone-furnace", -- seems a bit to expensive to add 1 calcite for 5 stone. Usually 1 calcite for 50 stone.
    "casting-steel-furnace",
    "casting-rail",
    "casting-wall",
    "casting-gate",
    "lava-to-sand-recipe",
    -- aai-industry
    "casting-stone-wall",
    "casting-concrete-wall",
    "casting-steel-wall",
  }

  for _, recipe_name in pairs(recipes_to_update) do
    local recipe = data.raw.recipe[recipe_name]
    if recipe then
      -- Add calcite as an additional ingredient
      if recipe.normal then
        -- Modify normal and expensive modes separately if defined
        table.insert(recipe.normal.ingredients, {type = "item", name = "calcite", amount = 1})
        table.insert(recipe.expensive.ingredients, {type = "item", name = "calcite", amount = 2})
      else
        -- Single mode recipe
        table.insert(recipe.ingredients, {type = "item", name = "calcite", amount = 1})
      end
    else
      log("Recipe '" .. recipe_name .. "' not found. Unable to apply complex mode adjustments.")
    end
  end
end