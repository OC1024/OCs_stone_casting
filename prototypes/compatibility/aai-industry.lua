if not mods["aai-industry"] then
    return
end

log("Overriding concrete recipes from this mod, such that it is alingt with AAI Industry.")
data:extend({
    { -- lava-to-stone-wall-recipe
        type = "recipe",
        name = "lava-to-stone-wall-recipe",
        icons = {
        {
            icon = "__aai-industry__/graphics/icons/stone-wall.png",
            icon_size = 64,
            icon_mipmaps = 4,
        },
        {
            icon = "__OCs_base_assets__/graphics/icons/overlayer-recipe-lava-droplet.png",
            icon_size = 64,
            icon_mipmaps = 4,
        }
        },
        category = "metallurgy",
        enabled = false,
        energy_required = 8, -- amount*time: 2*0.5 iron-stick + 10*0.5 lava-to-sand
        ingredients = {
        {type = "fluid", name = "lava", amount = 320, fluidbox_multiplier = 4} --2iron-sticks + 10sand + 5brick =160lava
        },
        results = {
        {type = "item", name = "stone-wall", amount = 2}
        },
        allow_productivity = false,
        show_amount_in_title = false,
    },
    { -- lava-to-steel-wall-recipe
        type = "recipe",
        name = "lava-to-steel-wall-recipe",
        icons = {
        {
            icon = "__aai-industry__/graphics/icons/steel-wall.png",
            icon_size = 64,
            icon_mipmaps = 4,
        },
        {
            icon = "__OCs_base_assets__/graphics/icons/overlayer-recipe-lava-droplet.png",
            icon_size = 64,
            icon_mipmaps = 4,
        }
        },
        category = "metallurgy",
        enabled = false,
        energy_required = 32, -- amount*time: 2*8 concrete-wall + 5*3.2 steel 2*1 steel-wall
        ingredients = {
        {type = "fluid", name = "lava", amount = 420, fluidbox_multiplier = 4} -- 1wall + 5steel= 210lava
        },
        results = {
        {type = "item", name = "stone-wall", amount = 2}
        },
        allow_productivity = false,
        show_amount_in_title = false
    },
})
local recipe_modifications = {
    { -- lava-to-walls-recipe (concrete wall)
    recipe = "lava-to-walls-recipe",
    ingredients = {
        {type = "fluid", name = "lava", amount = 400, fluidbox_multiplier = 4} -- 12concrete + 1 stone wall
    },
    -- results = {
    --   {type = "item", name = "wall", amount = 1},
    -- },
    description = "Adapted for AAI Industry balance",
    },
    { -- casting-concrete-recipe
    recipe = "casting-concrete-recipe",
    ingredients = {
        {type = "fluid", name = "water", amount = 400, fluidbox_multiplier = 2},
        {type = "fluid", name = "lava", amount = 640, fluidbox_multiplier = 2} -- 10lava/stone: 10sand * 5brick + 2iron-stick (easymode: 10lava=2iron-stick). volume x4
    },
    results = {
        {type = "item", name = "concrete", amount = 40},
    },
    description = "Adapted for AAI Industry balance",
    },
    { -- casting-refined-concrete-recipe
    recipe = "casting-refined-concrete-recipe",
    ingredients = {
        {type = "fluid", name = "water", amount = 600, fluidbox_multiplier = 2},
        {type = "fluid", name = "lava", amount = 780, fluidbox_multiplier = 2} -- 20concrete +1steel+8iron-stick (easymode: 40lava=8iron-stick)=390. volume x2
    },
    results = {
        {type = "item", name = "refined-concrete", amount = 20}
    },
    description = "Adapted for AAI Industry balance",
    }
}
replace_multiple_recipes((recipe_modifications)) -- do all replacements at once with the helper function


-- remove normal lava-to-stone recipes lava-to stone tech
remove_recipes_from_tech("lava-to-stone-tech", {"lava-to-stone-wall","lava-to-steel-wall"})

-- Add the lava-to-wall recipes to the corresponding wall technologies
mapping  = {
    ["lava-to-stone-wall-recipe"] = {"stone-walls"},
    ["lava-to-wall-recipe"] = {"concrete-walls"},
    ["lava-to-steel-wall-recipe"] = {"steel-walls"},
}
add_recipe_unlocks(mapping)
log("Changed techs due to AAI Industry being active.")
