local oc_tech   = require("__OCs_base_assets__.prototypes.utils.oc_tech")

for tech_name, _ in pairs(data.raw.technology) do
    if string.match(tech_name, "^foundation%-productivity%-%d+$") then
        oc_tech.add_productivity_bonus(tech_name, "oc-casting-foundation", 0.25)
    end
end