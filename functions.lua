function nethest.normal_to_netherpos(normal_pos)
	return {
		x = normal_pos.x / 8,
		y = normal_pos.y / 8 - 30800,
		z = normal_pos.z / 8
	}
end

function nethest.nether_to_normalpos(nether_pos)
	return {
		x = nether_pos.x * 8,
		y = (nether_pos.y + 30800) * 32,
		z = nether_pos.z * 8
	}
end

function nethest.is_nether_pos(pos)
	return pos.y < nethest.border
end

local function grid(value, gridwidth)
	value = math.floor(value / gridwidth) * gridwidth
end

function nethest.normal_to_portal_nether_pos(normal_pos)
	return {
		x = grid(normal_pos.x / 8, 8),
		y = grid(normal_pos.y / 32 - 30800, 8),
		z = grid(normal_pos.z / 8, 8)
	}
end

function nethest.nether_to_portal_normal_pos(nether_pos)
	return {
		x = grid(nether_pos.x * 8, 8),
		y = grid(nether_pos.y * 32 + 30800, 8),
		z = grid(nether_pos.z * 8, 8)
	}
end

-- When not in nether, object is moved to the nether, else out of it.
function nethest.switch_creature_nether(object)
	local pos = object:getpos()
	
	if nethest.is_nether_pos(pos) then
		if object:is_player() then
			object:override_day_night_ratio(nil)
			object:set_sky(nil, "regular")
		end

		pos = nethest.nether_to_normalpos(pos)
	else
		if object:is_player() then
			object:set_sky("0x803020", "plain")
			object:override_day_night_ratio(0.92)
		end

		pos = nethest.normal_to_netherpos(pos)
	end

	object:setpos(pos)
end

minetest.register_chatcommand("nether", {
	params = "",
	description = "go to the nether or get out of it",
	privs = {teleport=true},
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if player then
			nethest.switch_creature_nether(player)
		else
			return false, "Player not found"
		end
	end,
})

minetest.register_on_joinplayer(function(player)
	print("aha!")
	if nethest.is_nether_pos(player:getpos()) then
		player:set_sky("0x803020", "plain")
		player:override_day_night_ratio(0.92)
		print("set sky and dn-ratio")
	end
end)
