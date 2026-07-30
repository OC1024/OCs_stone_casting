local constants = {}

constants.stone_amount = 40  -- should be a muliple of 2 or 10
constants.stone_energy = 0.6 -- per item. crystalising lava to stone
constants.melting_amount  = 50 -- stone per lava melting cycle
constants.melting_energy  = 32/50 -- per item. melting stone to lava
constants.melting_efficiency = settings.startup["lava-melting-efficiency"].value/100 -- nerfing factor, in percent

return constants
