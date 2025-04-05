if mods["aai-industry"] then
    if data.raw["technology"]["lava-to-stone-tech"] then
        for i = #data.raw["technology"]["lava-to-stone-tech"].effects, 1, -1 do
            local effect = data.raw["technology"]["lava-to-stone-tech"].effects[i]
            if effect.type == "unlock-recipe" and
               (effect.recipe == "lava-to-stone-wall" or
                -- effect.recipe == "lava-to-concrete-wall" or
                effect.recipe == "lava-to-steel-wall") then
                table.remove(data.raw["technology"]["lava-to-stone-tech"].effects, i)
                log("Successfully removed '" .. effect.recipe .. "' recipe from 'lava-to-stone-tech'.")
            end
        end
        log("Successfully removed wall recipes from 'lava-to-stone-tech'.")
    else
        log("Warning: Technology 'lava-to-stone-tech' not found. Unable to remove wall recipes.")
    end
    -- Add the lava-to-wall recipes to the corresponding wall technologies
    if data.raw["technology"]["stone-walls"] then
        table.insert(
            data.raw["technology"]["stone-walls"].effects,
            {type = "unlock-recipe",recipe = "lava-to-wall-recipe"}
        )
        log("Successfully added 'lava-to-wall-recipe' recipe to 'stone-walls' technology.")
    else
        log("Warning: Technology 'stone-walls' not found. Unable to add 'lava-to-stone-wall' recipe.")
    end
    if data.raw["technology"]["concrete-walls"] and data.raw["recipe"]["lava-to-concrete-wall-recipe"] then
        data.raw["technology"]["concrete-walls"].effects = data.raw["technology"]["concrete-walls"].effects or {}
        table.insert(data.raw["technology"]["concrete-walls"].effects,
            {type = "unlock-recipe",recipe = "lava-to-concrete-wall-recipe"}
        )
        log("Successfully added 'lava-to-concrete-wall' recipe to 'concrete-walls' technology.")
    else
        log("Warning: Technology 'concrete-walls' not found. Unable to add 'lava-to-concrete-wall' recipe.")
    end
    if data.raw["technology"]["steel-walls"] and data.raw["recipe"]["lava-to-steel-wall-recipe"] then
        data.raw["technology"]["steel-walls"].effects = data.raw["technology"]["steel-walls"].effects or {}
        table.insert(
            data.raw["technology"]["steel-walls"].effects,
            {type = "unlock-recipe",recipe = "lava-to-steel-wall-recipe"}
        )
        log("Successfully added 'lava-to-steel-wall' recipe to 'steel-walls' technology.")
    else
        log("Warning: Technology 'steel-walls' not found. Unable to add 'lava-to-steel-wall' recipe.")
    end
else
    log("Warning: AAI Industry mod is not active. Skipping specialized lava-to-wall recipes.")
end