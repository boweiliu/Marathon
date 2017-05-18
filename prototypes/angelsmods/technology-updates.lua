

if settings.startup['marathomaton_fixup_angels_smelting_tech_order'].value == true and angelsmods then
  for tech_name, tech_obj in pairs(data.raw.technology) do
    local l = #tech_name
    if string.sub(tech_name,1,7) == 'angels-' and string.sub(tech_name,l-11+1,l) == '-smelting-1' then
      local metal = string.sub(tech_name, 8, l-11)
      if data.raw.technology[metal .. '-processing'] then
        -- add it to prerequisites
        if tech_obj and tech_obj.prerequisites then
          table.insert(tech_obj.prerequisites, metal .. '-processing')
        end
      end
      if metal == 'chrome' or metal == 'manganese' then
        if tech_obj and tech_obj.prerequisites then
          table.insert(tech_obj.prerequisites, 'nodule-processing')
        end
      end
    end
  end
end
  
if bobmods and bobmods.lib and settings.startup["marathomaton_rebalance_angels_bio_artifacts"].value == true and angelsmods and angelsmods.bioprocessing then
  bobmods.lib.tech.add_recipe_unlock('water-washing', 'solid-calcium-carbonate-from-limestone')
  bobmods.lib.tech.add_recipe_unlock('bio-processing-alien', 'alien-bacteria-from-goo')
end

