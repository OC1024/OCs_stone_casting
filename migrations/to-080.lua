local recipe_renames = {
    {
    --   vanilla
    ["lava-to-stone-recipe"]= "lava-to-stone",
    ["stone-to-lava-recipe"]= "stone-to-lava",
    ["lava-to-brick-recipe"]= "casting-brick",
    ["casting-concrete-recipe"] = "casting-concrete",
    ["casting-refined-concrete-recipe"] = "casting-refined-concrete",
    ["casting-foundation-recipe"] = "casting-foundation",
    ["casting-landfill-recipe"] = "casting-landfill",
    -- ["casting-rail-recipe"] = "casting-rail",
    ["lava-to-wall-recipe"] = "casting-wall",
    -- aai recipes
    ["lava-to-stone-wall-recipe"]= "casting-stone-wall",
    ["lava-to-steel-wall-recipe"]= "casting-steel-wall",
    ["lava-to-sand-recipe"]= "lava-to-sand",
    ["sand-to-lava-recipe"] = "sand-to-lava",
}
  }

-- Iterate through all surfaces and entities
for _, surface in pairs(game.surfaces) do
    for _, entity in pairs(surface.find_entities_filtered{type = "assembling-machine"}) do
        if entity.valid and entity.get_recipe() then
            local current_recipe = entity.get_recipe().name
            if recipe_renames[current_recipe] then
                entity.set_recipe(recipe_renames[current_recipe])
            end
        end
    end
end