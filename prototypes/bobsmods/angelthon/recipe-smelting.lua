local cat2items = marathomaton.get_items_from_category
local subgroup2items = marathomaton.get_items_by_subgroup
local i2r = marathomaton.get_recipes_from_item
local multiply = marathomaton.multiply
local AMF = marathomaton.adjust_multiplier_factor

-- 0.5x stone yield everywhere (e.g. ore-sorting-t1)
marathomaton.modify_all_yields(0.5, 'stone-crushed')

-- crushed stone -> stone : from 2 crushed to 3 crushed
multiply('stone-crushed', 1.5, 'stone-crushed')

-- find all recipes of ore-sorting-t2: 0.6x all fluids
for recipe_name, recipe_obj in pairs(data.raw.recipe) do
  local cat = recipe_obj.category
  if cat == 'ore-sorting-t2' then
    -- find results which are fluids
    local results = recipe_obj.results
    for _, result_obj in ipairs(results) do
      if result_obj.type == 'fluid' then
        -- 0.6x result fluid
        result_obj.amount = result_obj.amount * AMF(0.6)
        -- log('changed amount of ' .. serpent.block(result_obj)  .. ' in ' .. recipe_name)
      end
    end
  end
end

-- experimental!!
-- make casting slightly more efficient so as to incentivize copper -> ingot -> molten -> plate
-- over ordinary copper ore -> plate.
-- stats: iron through molten is +25% prod, through processed is +50%, through pellet is +87%
-- copper through molten is +0% , through processsed is +25%, through pellet is +50%
-- this will improve productivities by a further 11% across the board

for recipe_name, recipe_obj in pairs(data.raw.recipe) do
  if recipe_obj.category == 'casting' then
    multiply('__inputs__', 0.9, recipe_name)
  end
end



-- angels-powdered-x : no change afaik
-- make stone creation 1.5x harder (i.e. 0.66x stone yield everywhere)
-- ore crushing : 0.5x yield for stone-crushed, 0.75x time requirements
-- angelsore*-crushed-processing : 2x yield and 2x inputs??? why
-- hdyro (angelsore*-chunk) : ore inputs/outputs * 4 ??? or water/sulfur/geode * 0.25 ? and time * 0.75
-- crystals : acid * 0.25 ? 

-- in other words:
-- recipe.category == 'ore-sorting':  * 1.2 time
-- recipe.category == 'ore-sorting-t*' : *(1.5,2,2.25,2.5) time , 1 thru 4 ( this is ore -> crushed/chunks/crystals )
-- TODO recipe.subgroup == 'ore-sorting-advanced' : ?? 2x time? ( mix ores -> single ore)
-- stone-crushed: 0.5x yield everywhere
-- crushed stone -> stone : 0.66x yield 
-- wastewater production : 0.6x yield  (??)
-- water usage and acid usage: stable
-- geode production: stable


---- smelting times: (already covered in ../recipe-smelting.lua, documented here for reference)
-- 2x *-ore-processing
-- 2x *-processed-processing
-- 1.66x *-ore-smelting
-- 2x processed-*-smelting
-- 1.66x pellet-*-smelting
-- 2x molten-*-smelting
-- 2x roll-*-casting

-- 2x inputs AND 2x yield (why???) 'angels-*-plate'
-- angels-solder????


