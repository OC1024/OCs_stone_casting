for tech_name, _ in pairs(data.raw.technology) do
  if string.match(tech_name, "^concrete%-productivity%-%d+$") then
    add_productivity_bonus(tech_name, "casting-concrete", 0.25) --0.0625
    add_productivity_bonus(tech_name, "casting-refined-concrete", 0.25) --0.0625
    -- weirdly this results in 4*0.0625=0.25
  end
end

if mods["Krastorio2-spaced-out"] then
  for tech_name, _ in pairs(data.raw.technology) do
    if string.match(tech_name, "^concrete%-productivity%-%d+$") then
      add_productivity_bonus(tech_name, "casting-kr-black-reinforced-plate", 0.25)
      add_productivity_bonus(tech_name, "casting-kr-white-reinforced-plate", 0.25)
      -- this should be done in the concrete-productivity mod itself. If this gets done, I will remove these two lines:
      add_productivity_bonus(tech_name, "kr-black-reinforced-plate", 0.25)
      add_productivity_bonus(tech_name, "kr-white-reinforced-plate", 0.25)
    end
  end
end

if mods["Moshine"] then
  for tech_name, _ in pairs(data.raw.technology) do
    if string.match(tech_name, "^concrete%-productivity%-%d+$") then
      -- this should be done in the concrete-productivity mod itself. If this gets done, I will remove these lines:
      add_productivity_bonus(tech_name, "concrete-from-molten-iron-and-sand", 0.25)
    end
  end
end