-- A do-nothing "structural" node, to ensure all digtron nodes that are supposed to be connected to each other can be connected to each other.
minetest.register_node("digtron:structure", {
	description = "Digger Structure",
	groups = {cracky = 3, stone = 1, digtron = 1},
	drop = 'digtron:structure',
	tiles = {"digtron_plate.png"},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{0.3125, 0.3125, -0.5, 0.5, 0.5, 0.5},
			{0.3125, -0.5, -0.5, 0.5, -0.3125, 0.5},
			{-0.5, 0.3125, -0.5, -0.3125, 0.5, 0.5},
			{-0.5, -0.5, -0.5, -0.3125, -0.3125, 0.5},
			{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.5},
			{-0.3125, -0.5, 0.3125, 0.3125, -0.3125, 0.5},
			{-0.5, -0.3125, 0.3125, -0.3125, 0.3125, 0.5},
			{0.3125, -0.3125, 0.3125, 0.5, 0.3125, 0.5},
			{-0.5, -0.3125, -0.5, -0.3125, 0.3125, -0.3125},
			{0.3125, -0.3125, -0.5, 0.5, 0.3125, -0.3125},
			{-0.3125, 0.3125, -0.5, 0.3125, 0.5, -0.3125},
			{-0.3125, -0.5, -0.5, 0.3125, -0.3125, -0.3125},
		}
	},
})

-- A modest light source that will move with the digtron, handy for working in a tunnel you aren't bothering to install permanent lights in.
minetest.register_node("digtron:light", {
	description = "Digger Light",
	groups = {cracky = 3, stone = 1, digtron = 1},
	drop = 'digtron:light',
	tiles = {"digtron_light.png"},
	drawtype = "nodebox",
	paramtype = "light",
	light_source = 10,
	paramtype2 = "wallmounted",
	node_box = {
		type = "wallmounted",
		wall_top = {-0.25, 0.3125, -0.25, 0.25, 0.5, 0.25},
		wall_bottom = {-0.25, -0.3125, -0.25, 0.25, -0.5, 0.25},
		wall_side = {-0.5, -0.25, -0.25, -0.1875, 0.25, 0.25},
	},
})

-- Storage buffer. Builder nodes draw from this inventory and digger nodes deposit into it.
-- Note that inventories are digtron group 2.
minetest.register_node("digtron:inventory",
{
	description = "Digtron Inventory Hopper",
	groups = {cracky = 3, stone = 1, digtron = 2},
	drop = 'digtron:inventory',
	paramtype2= 'facedir',
	tiles = {"digtron_inventory.png"},

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", 
			"size[8,9]" ..
			default.gui_bg ..
			default.gui_bg_img ..
			default.gui_slots ..
			"list[current_name;main;0,0.3;8,4;]" ..
			"list[current_player;main;0,4.85;8,1;]" ..
			"list[current_player;main;0,6.08;8,3;8]" ..
			"listring[current_name;main]" ..
			"listring[current_player;main]" ..
			default.get_hotbar_bg(0,4.85)
		)
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end,
	
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
})