minetest.register_node("nethest:rack", {
	description = S("Nether Rack"),
	tiles = {"nethest_rack.png"},
	is_ground_content = true,
	drop = {
		max_items = 1,
		items = {{
			rarity = 3,
			items = {"nether:rack"},
		}}
	},
	groups = {cracky=3,level=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nethest:glowstone", {
	description = S("Glowstone"),
	tiles = {"nethest_glowstone.png"},
	is_ground_content = true,
	light_source = 13,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})


minetest.register_alias("nether_rack", "nethest:rack")
minetest.register_alias("glowstone", "nethest:glowstone")
