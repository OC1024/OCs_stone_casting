
local oc_helper = require("__OCs_base_assets__.prototypes.utils.helper")

for tech_name, _ in pairs(data.raw.technology) do
  if string.match(tech_name, "^railgun%-ammo%-productivity%-?%d*$") then
    oc_helper.add_productivity_bonus(tech_name, "casting-rail", 0.1)
  end
end

-- if item["silica-sand"] then
data:extend({
  { -- lava to quartz-sand/silica-sand
    type = "recipe",
    name = "lava-to-silica-sand",
    category = "metallurgy",
    icons =
    {
      {
        icon = "__common-prototypes-graphics__/icons/items/silica-sand-1.png",
        icon_size = 64,
        icon_mipmaps = 4
      },
      {
        icon = "__OCs_base_assets__/graphics/icons/overlayer-recipe-lava-droplet.png",
        icon_size = 64,
        icon_mipmaps = 4,
      }
    },
    enabled = false,
    energy_required = 24, -- like the other lava-to-sand recipes
    ingredients = {
      { type = "fluid", name = "lava", amount = 400, fluidbox_multiplier = 4 },
    },
    results = {
      { type = "item", name = "silica-sand", amount = 80 }, -- guess like aai sand
    },
    allow_productivity = true,
    show_amount_in_title = false,
  },
})
local mapping = {
  ["lava-to-silica-sand"] = { "lava-to-stone-tech" }
}
oc_helper.add_recipe_unlocks(mapping)
-- end
