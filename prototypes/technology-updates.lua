if data.raw["item"]["sand"] then
    local mapping = {
        ["lava-to-sand-recipe"] = {"lava-to-stone-tech"},
    }
    add_recipe_unlocks(mapping)
    -- additional condition
    if settings.startup["allow-stone-to-lava"].value then
        local mapping = {
            ["sand-to-lava-recipe"] = {"lava-to-stone-tech"}
        }
        add_recipe_unlocks(mapping)
    end
end


-- Inject the recipe unlock into the technology
local mapping = {
    -- ["casting-stone-wall"]  = {"lava-to-stone-tech"}, -- alt recipe to "lava-to-wall-recipe"
    ["casting-gate"]  = {"casting-wall-tech"},
    ["casting-stone-furnace"]  = {"lava-to-stone-tech"},
    ["casting-steel-furnace"]  = {"lava-to-stone-tech"},
    -- ["casting-rail"]  = {"lava-to-stone-tech"},
}
add_recipe_unlocks(mapping)