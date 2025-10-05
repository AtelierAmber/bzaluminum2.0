-- Matter recipes for Krastorio2
if mods["Krastorio2"] then
local util = require("data-util");
local matter = require("__Krastorio2__/prototypes/libraries/matter")

data:extend(
{
  {
    type = "technology",
    name = "aluminum-matter-processing",
    icons =
    {
      {
        icon = util.k2assets().."/technologies/matter-coal.png",
        icon_size = 256,
      },
      {
        icon = "__bzaluminum__/graphics/icons/aluminum-ore.png",
        icon_size = 64,
        scale = 1.4,
      }
    },
    prerequisites = {"kr-matter-processing"},
    unit =
  	{
      count = 350,
      ingredients =
      {
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"kr-matter-tech-card", 1}
      },
      time = 45
    }
  },
})

local flake_graphite_matter = 
	{
    material = {type="item", name="aluminum-ore", amount=10},
    matter_count = 5,
    energy_required = 1,
    need_stabilizer = false,
    unlocked_by_technology = "aluminum-matter-processing"
	}
matter.make_recipes(flake_graphite_matter)

local graphite_matter = 
	{
    material = {type="item", name="alumina", amount=10},
    matter_count = 7.5,
    energy_required = 2,
    only_deconversion = true,
    need_stabilizer = true,
    unlocked_by_technology = "aluminum-matter-processing"
	}
matter.make_recipes(graphite_matter)

local graphite_matter = 
	{
    material = {type="item", name="aluminum-plate", amount=10},
    matter_count = 10,
    energy_required = 3,
    only_deconversion = true,
    need_stabilizer = true,
    unlocked_by_technology = "aluminum-matter-processing"
	}
matter.make_recipes(graphite_matter)
end
