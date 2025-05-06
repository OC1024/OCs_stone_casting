for tech_name, tech_data in pairs(data.raw.technology) do
    if string.match(tech_name, "^foundation%-productivity%-%d+$") then
        add_productivity_bonus(tech_data, "casting-foundation-recipe", 0.25)
    end
  end