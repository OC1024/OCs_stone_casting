-- Iterate through all technologies
for tech_name, tech_data in pairs(data.raw.technology) do
    -- Check if the technology name matches the pattern for repeatable productivity tech
    if string.match(tech_name, "^foundation%-productivity%-%d+$") then
      -- Ensure the technology has an effects table
      tech_data.effects = tech_data.effects or {}

      -- Add the "casting-foundation" recipe to the productivity effect
      table.insert(tech_data.effects, {
        type = "change-recipe-productivity",
        recipe = "casting-foundation-recipe",
        change = 0.25
      })
    end
end
if mods["concrete-productivity"] then
  require("prototypes.compatibility.concrete-productivity")
end

if settings.startup["expensive-lava-mode"].value then
  -- List of recipes to modify
  local recipes_to_update = {
    "lava-to-stone-recipe",
    "lava-to-brick-recipe",
    "lava-to-walls-recipe",
    "casting-concrete-recipe",
    "casting-refined-concrete-recipe",
    "casting-foundation-recipe",
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
      log("Recipe '" .. recipe_name .. "' not found. Unable to apply expensive mode adjustments.")
    end
  end
end