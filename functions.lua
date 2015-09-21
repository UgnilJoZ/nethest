function nethest.normal_to_netherpos(normal_pos)
	local pos = normal_pos
	pos.x = pos.x / 8
	pos.y = pos.y / 32 - 30800
	pos.z = pos.z / 8
	return pos
end

function nethest.nether_to_normalpos(nether_pos)
	local pos = nether_pos
	pos.x = pos.x * 8
	pos.y = (pos.y + 30800) * 32
	pos.z = pos.z * 8
	return pos
end

function nethest.is_nether_pos(pos)
	return pos.y < nethest.border
end

-- When not in nether, object is moved to the nether, else out of it.
function nethest.switch_creature_nether(object)
	local pos = object:getpos()
	
	if object:is_player() then

		if not nethest.is_nether_pos(pos) then
			object:set_sky("0x803020", "plain")
			pos = nethest.normal_to_netherpos(pos)
			object:override_day_night_ratio(0.92)
		else
			object:override_day_night_ratio(nil)
			pos = nethest.nether_to_normalpos(pos)
			object:set_sky(nil, "regular")
		end

		object:setpos(pos)
	end
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
