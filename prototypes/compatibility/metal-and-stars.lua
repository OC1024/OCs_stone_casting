for tech_name, tech_data in pairs(data.raw.technology) do
    if string.match(tech_name, "^railgun%-ammo%-productivity%-?%d*$")then
        add_productivity_bonus(tech_data, "casting-rail", 0.1)
    end
end