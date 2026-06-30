local oc_recipe = require("__OCs_base_assets__.prototypes.utils.oc_recipe")
local oc_tech = require("__OCs_base_assets__.prototypes.utils.oc_tech")

local starter_planet = settings.startup["aps-planet"].value
-- expected result: "none", "vulcanus", "fulgora", "gleba"}
local supported_planets = { "none", "vulcanus", "fulgora", "gleba", "moshine" }
if not table.contains(supported_planets, starter_planet) then
  log("Unsupported starter planet: " ..
    tostring(starter_planet) .. ". Supported planets are: " .. table.concat(supported_planets, ", "))
end


if starter_planet == "none" then
  return
elseif starter_planet == "moshine" then
  -- todo : add dedicated moshine compat, not just a simpler vulcanus clone
  -- make techs cheaper and simpler
  local moshine_mapping = {
    ["lava-to-stone-tech"] = { "space-science-pack", "metallurgic-science-pack" },
    ["casting-concrete-tech"] = { "space-science-pack", "metallurgic-science-pack" },
    ["casting-wall-tech"] = { "space-science-pack", "metallurgic-science-pack" },
  }
  oc_tech.remove_prerequisites(moshine_mapping)
  oc_tech.remove_tech_ingredients(moshine_mapping)

  -- end of moshine changes, WIP
elseif starter_planet == "vulcanus" then
  local vulcanus_mapping = {
    ["lava-to-stone-tech"] = { "space-science-pack", "metallurgic-science-pack" },
    ["casting-concrete-tech"] = { "space-science-pack", "metallurgic-science-pack" },
    ["casting-wall-tech"] = { "space-science-pack", "metallurgic-science-pack" },
    ["kr-advanced-mineral-processing-tech"] = { "space-science-pack", "metallurgic-science-pack" },
    ["cast-reinforced-plates-tech"] = { "space-science-pack", "metallurgic-science-pack" },
  }
  oc_tech.remove_prerequisites(vulcanus_mapping)
  oc_tech.remove_tech_ingredients(vulcanus_mapping)
  -- end of vulvanus changes
end
