data:extend({
  {
    type = "recipe",
    name = "lab",

    energy_required = 20,
    ingredients = {
      {"electronic-circuit", 25},
      {"iron-gear-wheel", 25},
      {"basic-transport-belt", 20},
    },
    result = "lab",
  },
  {
    type = "recipe",
    name = "science-pack-1",

    energy_required = 10,
    ingredients = {
      {"copper-plate", 30},
      {"iron-gear-wheel", 5},
    },
    result = "science-pack-1",
  },
  {
    type = "recipe",
    name = "science-pack-2",

    energy_required = 15,
    ingredients = {
      {"basic-inserter", 5},
      {"basic-transport-belt", 5},
    },
    result = "science-pack-2",
  },
  {
    type = "recipe",
    name = "science-pack-3",
    enabled = false,

    energy_required = 30,
    ingredients = {
      {"battery", 5},
      {"advanced-circuit", 5},
      {"smart-inserter", 5},
      {"steel-plate", 5},
    },
    result = "science-pack-3",
  },
})
