local oc_helper = require("__OCs_base_assets__.prototypes.utils.helper")

for tech_name, _ in pairs(data.raw.technology) do
    if string.match(tech_name, "^foundation%-productivity%-%d+$") then
        oc_helper.add_productivity_bonus(tech_name, "casting-foundation", 0.25)
    end
end