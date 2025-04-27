-- Iterate through all technologies
for tech_name, tech_data in pairs(data.raw.technology) do
  -- Check if the technology name matches the pattern for repeatable productivity tech
  if string.match(tech_name, "^concrete%-productivity%-%d+$") then
    -- Ensure the technology has an effects table
    tech_data.effects = tech_data.effects or {}

    -- Add the "casting-concrete" recipe to the productivity effect
    table.insert(tech_data.effects, {
      type = "change-recipe-productivity",
      recipe = "casting-concrete-recipe",
      change = 0.25
    })
    -- Add the "casting-refined-concrete" recipe to the productivity effect
    table.insert(tech_data.effects, {
      type = "change-recipe-productivity",
      recipe = "casting-refined-concrete-recipe",
      change = 0.25
    })
  end
end