for tech_name, tech_data in pairs(data.raw.technology) do
  if string.match(tech_name, "^concrete%-productivity%-%d+$") then
      add_productivity_bonus(tech_data, "casting-concrete-recipe", 0.0625)
      add_productivity_bonus(tech_data, "casting-refined-concrete-recipe", 0.0625) -- weirdly this results in 4*0.0625=0.25
  end
end