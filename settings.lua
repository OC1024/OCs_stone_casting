data:extend({
  {
    type = "bool-setting",
    name = "allow-casting-foundation",
    setting_type = "startup",
    order = "a",
    default_value = true
  },
  {
    type = "bool-setting",
    name = "allow-stone-to-lava",
    setting_type = "startup",
    order = "b",
    default_value = true
  },
  {
    type = "int-setting",
    name = "lava-melting-efficiency",
    setting_type = "startup",
    order = "c",
    default_value = 25, -- in percent
    minimum_value = 1,
    maximum_value = 100,
  },
  {
    type = "bool-setting",
    name = "complex-lava-mode",
    setting_type = "startup",
    order = "y",
    default_value = false
  },
  {
    type = "bool-setting",
    name = "expensive-lava-mode",
    setting_type = "startup",
    order = "z",
    default_value = false
  },
})
