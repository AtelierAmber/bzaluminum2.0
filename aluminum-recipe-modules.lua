local util = require("data-util")

for i, recipe in pairs(util.me.recipes) do
  if data.raw.recipe[recipe] then
    local rec_def = data.raw.recipe[recipe]
    local cat = rec_def.allowed_module_categories or {}
    table.insert(cat, "productivity")
    rec_def.allowed_module_categories = cat
    -- for j, module in pairs(data.raw.module) do
    --   if module.effect then
    --     for effect_name, effect in pairs(module.effect) do
    --       if effect_name == "productivity" and effect.bonus > 0 and module.limitation and #module.limitation > 0 then
    --         table.insert(module.limitation, recipe)
    --       end
    --     end
    --   end
    -- end
  end
end
