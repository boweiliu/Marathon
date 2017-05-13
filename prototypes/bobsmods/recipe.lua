local cat2items = marathomaton.get_items_from_category
local subgroup2items = marathomaton.get_items_by_subgroup
local item2recipes = marathomaton.get_recipes_from_item
local i2r = item2recipes
local multiply = marathomaton.multiply
local recipes

-- see recipe-circuit
recipes = item2recipes({'electronic-circuit'})
multiply('__time__', 0.0625, recipes)
multiply('__inputs__', 0.33333333333333, recipes)

-- also multiply "t2" requirements for turrets slightly
multiply({'steel-plate', 'steel-gear-wheel'}, 2.0, item2recipes(cat2items({'ammo-turret', 'electric-turret', 'fluid-turret'})))

-- seedling/wood recipes
-- goal is: pre-fertiliser, growing wood is energy deficit, and should only be done for the purpose of actually acquiring wood

multiply('__yield__', 0.5, 'bob-seedling')
local bob_wood = {'bob-basic-greenhouse-cycle', 'bob-advanced-greenhouse-cycle'}
multiply('__time__', 2.0, bob_wood)
multiply('__yield__', 0.66666, bob_wood)
if BI then
  local bio_wood = {'bi-Logs_Mk1', 'bi-Logs_Mk2', 'bi-Logs_Mk3'}
  multiply('__time__', 1.66666, bio_wood)
  local bio_coal = {'bi-coal', 'bi-coal-2'}
  multiply('__yield__', 0.6666, bio_coal)
end


-- bobgreenhouse: 1 wood -> ~2#5 seedling in 0.5s # HALVE YIELD
-- bioindustries: 1 wood -> 2 seedling, 1 pulp in 0.5s
--  assembler uses ~.18 MW for 1x crafting
-- bobgreenhouse: 10 seedling -> 10#15 wood, 90 s # DOUBLE TIME (now 40 MJ of fuel needed/cycle), 2/3 YIELD
-- : around 1 MJ/seedling
-- bobgreenhouse: 10 seedling, 5 fertiliser -> ~20#30 wood, 60s # DOUBLE TIME, 2/3 YIELD
--  greenhouse uses .133 MW for 1x crafting
-- bioindustries: 20 seedling -> 40 wood , 450 s # 1.6666x TIME (now 125 MJ of fuel needed/cycle) : runs profit of 13 MJ on .7 efficiency which is not enough to pay seedling costs
-- : around 2 MJ/seedling
-- bioindustries: 30 seedling, 10 fertiliser -> 75 wood, 260 s
-- bioindustries: 50 seedling, 5 a. fertiliser -> 150 wood, 150 s
--  bio-farm uses 0.1 MW for 1x crafting
-- 20 wood -> 18 charcoal (3 MJ) in 20 s
-- : makes wood worth 63 / 20 = 3.1 MJ
-- 40 pulp -> 18 charcoal (3 MJ) in 12.5 s
-- : makes pulp worth 64 / 40 = 1.6 MJ
-- 12 charcoal -> 8 coal (4 MJ) in 12 s # HALVE YIELD
-- : this makes charcoal worth 44/12 = 3.66 MJ
-- 12 charcoal -> 10 coal (4 MJ) in 18 s # HALVE YIELD
-- 15 coal -> 10 cokecoal (9 MJ) in 25 s # TIME 4x - coal now worth 4 -> 5 MJ
-- : this makes coal worth 5.7 MJ
--  cokery uses 0.09 MW for 1x crafting
-- 3 raw wood -> 12 cellulose fiber -> 2 wood pellets -> 1 wood bricks (12 MJ)
-- 3 raw wood -> 12 cellulose (.5 MJ) in 6s on 0.18 MW
-- 12 cellulose -> 2 pellets (6 MJ) in 4s on 0.18 MW
-- 2 pellets -> 1 brick (12 MJ) in 0.5s on 0.18 MW
-- : this recipe makes wood worth 3 MJ each (up from 2) # KEEP
--  assembler uses ~.18 MW for 1x crafting
-- algae: 100 co2 -> 40 green algae -> 20 cellulose -> 3.333 wood pellets -> 100 co2 + 1.93 wood pellets or about 11 MJ of wood bricks.
-- 100 co2 -> 40 green algae in 20s on 0.2MW
-- 40 green alg -> 20 cellulose in 72s on 0.06 MW
-- 20 cellulose -> 3.33 wood pellets in 6.66s on .18MW
-- 1.42 pellets -> 100 co2 in 16.8s on 0.06 MW
-- 1.9 pellets -> 0.95 bricks (12 MJ) in 0.5s on 0.18 MW 
-- but takes 11 MJ  / .6 = 18 MJ
--  algae farm uses 0.2 MW for 1x crafting
--  liquifier uses 0.06 MW for 1x crafting
