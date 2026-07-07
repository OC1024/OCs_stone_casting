local oc_recipe = require("__OCs_base_assets__.prototypes.utils.oc_recipe")
local oc_tech = require("__OCs_base_assets__.prototypes.utils.oc_tech")
local starter_planet_tables = require("prototypes.utils.starter-planet-tables")

-- sp for starter_planet
local sp_vulcanus = settings.startup["oc-pp-vulcanus"].value
local sp_fulgora = settings.startup["oc-pp-fulgora"].value
local sp_gleba = settings.startup["oc-pp-gleba"].value
local sp_moshine = settings.startup["oc-pp-moshine"].value
local starter_planets = {}

-- todo : add dedicated moshine compat, not just a simpler vulcanus clone
if sp_moshine then
  -- make techs cheaper and simpler
  local moshine_techs = starter_planet_tables.moshine_techs
  oc_tech.remove_prerequisites(moshine_techs)
  oc_tech.remove_tech_ingredients(moshine_techs)

  -- end of moshine changes, WIP
  starter_planets[#starter_planets + 1] = "moshine"
end

if sp_vulcanus then
  -- make techs cheaper and simpler
  local vulcanus_techs = starter_planet_tables.vulcanus_techs
  oc_tech.remove_prerequisites(vulcanus_techs)
  oc_tech.remove_tech_ingredients(vulcanus_techs)

  -- end of vulcanus changes
  starter_planets[#starter_planets + 1] = "vulcanus"
end

log("Changed OCs techs slightly because starter planets are " .. table.concat(starter_planets, ", "))
