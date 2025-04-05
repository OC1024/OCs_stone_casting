data:extend({
  {
    type = "technology",
    name = "lava-to-stone-tech",
    icon = "__OCs_stone_casting__/graphics/icons/lava-stone.png",
		icon_size = 64, icon_mipmaps = 4,
    prerequisites = {"foundry"},
    unit = {
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        -- {"metallurgic-science-pack", 2}
      },
      time = 30,
      count = 200
      },
    effects = {
     {type = "unlock-recipe", recipe = "lava-to-stone-recipe"},
     {type = "unlock-recipe", recipe = "lava-to-brick-recipe"},
     {type = "unlock-recipe", recipe = "lava-to-wall-recipe"}
    },
     order = "a"
  },
  {
    type = "technology",
    name = "casting-concrete-tech",
    icon = "__OCs_stone_casting__/graphics/technology/casting-concrete-tech.png",
		icon_size = 256, icon_mipmaps = 4,
    prerequisites = {"lava-to-stone-tech","concrete"}, -- concrete is already, indirectly, a prerequisit. 
    unit = {
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"metallurgic-science-pack", 2}
      },
      time = 60,
      count = 250
      },
      effects = {
       {type = "unlock-recipe", recipe = "casting-concrete-recipe"},
       {type = "unlock-recipe", recipe = "casting-refined-concrete-recipe"}
      },
  }
})

-- changes to technologies
if settings.startup["allow-stone-to-lava"].value then
  local tech = data.raw["technology"]["lava-to-stone-tech"]
  if tech then
    tech.effects = tech.effects or {}
    table.insert(tech.effects, {type = "unlock-recipe", recipe = "stone-to-lava-recipe"})
    local recipe = data.raw["recipe"]["stone-to-lava-recipe"]
    if recipe then
      recipe.hidden = false
      log("Successfully added 'stone-to-lava-recipe' to 'lava-to-stone-tech'.")
    else
      log("Warning: Recipe 'stone-to-lava-recipe' not found.")
    end
  else
    log("Warning: Technology 'lava-to-stone-tech' not found. Unable to add 'stone-to-lava-recipe'.")
  end
end


if data.raw["technology"]["landfill"] then
  -- Inject the recipe unlock into the technology
  table.insert(data.raw["technology"]["landfill"].effects, {
      type = "unlock-recipe",
      recipe = "lava-to-landfill-recipe"
  })
  log("Successfully added 'lava-to-landfill-tech' to 'landfill'.")
else
  log("Warning: Technology 'lava-to-landfill-tech' not found. Unable to add 'lava-to-landfill-recipe' recipe.")
end

 -- Conditionally included technologies
 if settings.startup["allow-casting-foundation"].value then
    data:extend({
    {
      type = "technology",
      name = "casting-foundation-tech",
      icon = "__OCs_stone_casting__/graphics/technology/casting-foundation-tech.png",
      icon_size = 256, icon_mipmaps = 4,
      prerequisites = {"casting-concrete-tech","foundation"},
      unit = {
        ingredients = {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
          {"production-science-pack", 1},
          {"utility-science-pack", 1},
          {"space-science-pack", 1},
          {"metallurgic-science-pack", 2},
          {"agricultural-science-pack", 1},
          {"electromagnetic-science-pack", 1},
          {"cryogenic-science-pack", 1}
        },
        time = 60,
        count = 1000
        },
        effects = {
          {type = "unlock-recipe", recipe = "casting-foundation-recipe"},
        },
       order = "zzw",
    }
    })
end