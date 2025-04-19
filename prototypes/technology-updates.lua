if data.raw["item"]["sand"] then
    mapping = {
        ["lava-to-sand-recipe"] = {"lava-to-stone-tech"},
    }
    add_recipe_unlocks(mapping)
    -- additional condition
    if settings.startup["allow-stone-to-lava"].value then
        mapping = {
            ["sand-to-lava-recipe"] = {"lava-to-stone-tech"}
        }
        add_recipe_unlocks(mapping)
    end
end

