for tech_name, _ in pairs(data.raw.technology) do
    if string.match(tech_name, "^foundation%-productivity%-%d+$") then
        add_productivity_bonus(tech_name, "casting-foundation", 0.25)
        log("Added productivity bonus for casting-foundation to tech: " .. tech_name)
    end
  end