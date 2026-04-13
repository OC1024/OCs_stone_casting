local generator_api = require("__OCs_base_assets__.prototypes.utils.api")-- pepare the generator
local oc_helper = require("__OCs_base_assets__.prototypes.utils.helper")

if data.raw["item"]["sand"] then
    data:extend({
        { -- lava to sand
            type = "recipe",
            name = "lava-to-sand",
            icons =
            {
                {
                    icon = "__OCs_base_assets__/graphics/icons/sand.png", -- sand icon stolen from Kastorio2.
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
            energy_required = 24,                                                         --24 for 40 stone, 0.5*40 grinding sand (free)
            ingredients = {
                { type = "fluid", name = "lava", amount = 400, fluidbox_multiplier = 4 }, -- 40 stone
            },
            results = {
                { type = "item", name = "sand", amount = 80 }, -- 2sand per stone
            },
            allow_productivity = true,
            show_amount_in_title = false,
        },
        { -- sand to lava
            type = "recipe",
            name = "sand-to-lava",
            icon = "__OCs_stone_casting__/graphics/icons/lava-sand.png",
            icon_size = 64,
            icon_mipmaps = 4,
            category = "metallurgy",
            group = "intermediate-products",
            subgroup = "vulcanus-processes",
            order = "a[melting]-a[lava-c]",
            enabled = false,
            energy_required = 16,                                                       --twice as fast as stone-to-lava since sand is smaller
            ingredients = {
                { type = "item", name = "sand", amount = 100, itembox_multiplyer = 4 }, -- 2sand per stone
            },
            results = {
                { type = "fluid", name = "lava", amount = 250, fluidbox_multiplier = 4 }, -- 40stone/2 making it less efficient
            },
            allow_productivity = false,
            show_amount_in_title = false,
        },
    })
end


-- add new alterative recipes for the generator to use
local new_alt_recipes = {
  ["sand"] = {"lava-to-sand","sand"},
}
generator_api.register_category_alt_recipes("metallurgy", new_alt_recipes)

-- create new recipes
local casting_dict = {
    ["maraxsis-glass-panes"] = "metallurgy",
}
generator_api.batch_generator(casting_dict)

-- add recipes to technology
local mapping = {
    ["lava-to-sand"] = { "lava-to-stone-tech" },
    ["casting-maraxsis-glass-panes"] = { "lava-to-stone-tech" },
}
if settings.startup["allow-stone-to-lava"].value then
    mapping["sand-to-lava"] = { "lava-to-stone-tech" }
end
oc_helper.add_recipe_unlocks(mapping)

-- add glass productivity for the casting recipe
for tech_name, _ in pairs(data.raw.technology) do
    if string.match(tech_name, "^glass%-productivity%-%d+$") then
        oc_helper.add_productivity_bonus(tech_name, "casting-maraxsis-glass-planes", 0.1)
        log("Added productivity bonus for casting-foundation to tech: " .. tech_name)
    end
end
