-- TODO refactor main_result lookup

local cat2items = marathomaton.get_items_from_category
local subgroup2items = marathomaton.get_items_by_subgroup
local i2r = marathomaton.get_recipes_from_item
local multiply = marathomaton.multiply

-- ore silos : 5x inputs
-- angels-warehouses: 5x upgrade? except for T1?
-- flare-stack and angels storage tanks and angels-pressure-tank: 5x inputs AND 4x steel? 8x inputs?

-- most petrochem buildings:
-- separators, gas/oil refineries, steam cracker, chem plants, angels-eletrolyser, air-filter: 4.5x upgrade? 4x upgrade?
-- special case for flare stack: additional 4x steel

-- valves, fluid splitter 2 & 3: 20x inputs

-- bio-processing-plant: ????

-- crushers, floatation cell, leaching plant, : 5x upgrade AND 0.5x stone-brick?
-- ore-refinery: 3x upgrade?
-- ore-sorting: 5x upgrade AND 0.5x stone brick?
-- hydro-plant: 2x upgrade?
-- ore-processing-machines, pellet press, casting-machine, sintering-oven, strand-casting-machine : 4x upgrade? 4x AND .5x stone-brick?
-- on average: most angels machines in the refining/metallurgy tabs -> 4x upgrade and .5x stone brick
-- to find what tab is a recipe in: lookup recipe.subgroup in data.item_groups[recipe.subgroup].group

---------------

-- easy way: every machine in refining/metallurgy -> 4x upgrade AND .5x stone brick, AND
-- ore silos 3x stone brick, AND
-- flare stack stay the same; only used for discarding resources, and otherwise more expensive than chem plants.
-- every building in barreling/pumps: 16x inputs


local group_set = {
  ['resource-refining'] =true,
  ['petrochem-refining']=true,
  ['angels-smelting']   =true,
}
-- why are liquifiers not working?
for recipe_name, recipe_obj in pairs(data.raw.recipe) do
  recipe_obj = recipe_obj['expensive']
  local subgroup = nil
  local placeable = false
  if recipe_obj ~= nil then
    subgroup = recipe_obj.subgroup

    -- look up the main result item
    local main_result = recipe_obj.result
    if main_result == nil then
      main_result = recipe_obj.main_product
    end
    if main_result == nil then
      if recipe_obj.results then
        for i, result_obj in ipairs(recipe_obj.results) do
          if result_obj and result_obj.amount == 1 then
            main_result = result_obj.name
            break
          end
        end
      end
    end
    -- determine whether its placeable
    if main_result ~= nil then
      local item = data.raw.item[main_result]
      if item ~= nil then
        if subgroup == nil then
          subgroup = item.subgroup
        end
        placeable = (item.place_result ~= nil)
      end
    end
  end
  -- log('got group ' .. serpent.block(group) .. ' and subgroup ' .. serpent.block(subgroup) .. ' for recipe name ' .. recipe_name)
  local group = ''
  if subgroup ~= nil and data.raw['item-subgroup'][subgroup] ~= nil then
    group = data.raw['item-subgroup'][subgroup].group
  end
  -- check if item result is placeable
  if placeable and recipe_obj then
    if group ~= nil and (group_set[group] ~= nil or recipe_obj.subgroup == 'angels-silos') then
      -- log('got group ' .. group .. ' and subgroup ' .. subgroup .. ' for recipe name ' .. recipe_name)
      -- modify the recipe
      multiply('__upgrade__', 4.0, recipe_name)
      if recipe_obj.subgroup == 'angels-silos' then
        multiply('stone-brick', 3.0, recipe_name)
      else
        multiply('stone-brick', 0.5, recipe_name)
      end
    end
    if group == 'angels-barrels' or group == 'angels-fluid-control' then
      multiply('__upgrade__', 16.0, recipe_name)
    end
  end
end
