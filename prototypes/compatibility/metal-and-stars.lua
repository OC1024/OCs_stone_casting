local oc_tech      = require("__OCs_base_assets__.prototypes.utils.oc_tech")
local constants    = require("prototypes.utils.constants")
local stone_amount = constants.stone_amount
local stone_energy = constants.stone_energy       -- crafting time per item
local melt_amount  = constants.melting_amount     -- stone per melting cycle
local melt_energy  = constants.melting_energy     -- crafting time per item
local melt_eff     = constants.melting_efficiency -- nerfing factor

for tech_name, _ in pairs(data.raw.technology) do
  if string.match(tech_name, "^railgun%-ammo%-productivity%-?%d*$") then
    oc_tech.add_productivity_bonus(tech_name, "oc-casting-rail", 0.1)
  end
end

data:extend({
  { -- lava to quartz-sand/silica-sand
    type = "recipe",
    name = "lava-to-silica-sand",
    categories = { "metallurgy" },
    icons = {
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
    energy_required = stone_amount * stone_energy, -- like the other lava-to-sand recipes
    ingredients = {
      { type = "fluid", name = "lava", amount = stone_amount * 10, fluidbox_multiplier = 4 },
    },
    results = {
      { type = "item", name = "silica-sand", amount = stone_amount * 2 }, -- guess like aai sand
    },
    allow_productivity = true,
    show_amount_in_title = false,
  },
})
if settings.startup["allow-stone-to-lava"].value then
  data:extend({
    { -- stone to lava
      type = "recipe",
      name = "silica-sand-to-lava",
      icons = {
        {
          icon = "__space-age__/graphics/icons/fluid/lava.png",
          icon_size = 64,
          icon_mipmaps = 4,
        },
        {
          icon = "__common-prototypes-graphics__/icons/items/silica-sand-1.png",
          icon_size = 64,
          icon_mipmaps = 4,
          scale = 0.375,
          shift = { 0, 32 * 0.375 } -- move to lower edge
        },
      },
      categories = { "metallurgy" },
      group = "intermediate-products",
      subgroup = "vulcanus-processes",
      order = "a[melting]-a[lava-c]-c",
      enabled = false,
      energy_required = melt_amount * melt_energy * 0.5,
      -- like other sand-to-lava, half of stone-to-lava
      ingredients = {
        { type = "item", name = "silica-sand", amount = melt_amount * 2, itembox_multiplyer = 4 }, -- 2sand per stone
      },
      results = {
        { type = "fluid", name = "lava", amount = melt_amount * 10 * melt_eff, fluidbox_multiplier = 4 },
      },
      allow_productivity = true,
      show_amount_in_title = false,
    },
  })
end

local mapping = {
  ["lava-to-silica-sand"] = { "lava-to-stone-tech" },
  ["silica-sand-to-lava"] = { "lava-to-stone-tech" }, -- if existent
}
oc_tech.add_recipe_unlocks(mapping)
