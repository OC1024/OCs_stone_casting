if mods["aai-industry"] then
    -- remove normal lava-to-stone recipes lava-to stone tech
    remove_recipes_from_tech("lava-to-stone-tech", {"lava-to-stone-wall","lava-to-steel-wall"})

    -- Add the lava-to-wall recipes to the corresponding wall technologies
    mapping  = {
        ["lava-to-wall-recipe"] = {"stone-walls"},
        ["concrete-walls"] = {"lava-to-concrete-wall-recipe"},
        ["steel-walls"] = {"lava-to-steel-wall-recipe"},
    }
    add_recipe_unlocks(mapping)
    log("Changed techs due to AAI Industry being active.")
-- else
--     log("Warning: AAI Industry mod is not active. Skipping specialized lava-to-wall recipes.")
end