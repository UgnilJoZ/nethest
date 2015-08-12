local densenoise_offset = 1 - 2 * (minetest.setting_get("nethest_air_ratio") or 0.75)

local np_density = {
	offset = densenoise_offset,
	scale = 1,
	spread = {x=32, y=24, z=32},
	octaves = 3,
	seeddiff = 42,
	persist = 0.6,
	flags = "eased"
}

local function gen_nether_chunk(minp,maxp, seed)
	-- content ids
	local c_air = minetest.get_content_id("air")
	local c_rack= minetest.get_content_id("nethest:rack")
	local c_lava= minetest.get_content_id("default:lava_source")
	-- read chunk data
	local vm = minetest.get_voxel_manip()
	local emin, emax = vm:read_from_map(minp, maxp)
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()
	local chulens = {x=emax.x-emin.x+1, y=emax.y-emin.y+1, z=emax.z-emin.z+1}

	-- generate noise data
	local density_map = minetest.get_perlin_map(np_density, chulens):get3dMap_flat({x=emin.x, y=emin.y, z=emin.z})

	-- initialize data index
	local nixyz = 0

	-- iterate through data and fill with materials
	for z = emin.z,emax.z do
		for y = emin.y,emax.y do
			for x = emin.x,emax.x do
				nixyz = nixyz + 1
				local density = density_map[nixyz]
				-- which material?
				if density < 0 then
					if y > -30872 then
						data[nixyz] = c_air
					else
						data[nixyz] = c_lava
					end
				else
					data[nixyz] = c_rack
				end
			end-- for x
		end-- for y
	end-- for z
	vm:set_data(data)
	vm:set_lighting({day=12, night=15})
	vm:calc_lighting()-- how to set the light to a uniform value?
	vm:write_to_map(data)
end

minetest.register_on_generated(function(minp,maxp,seed)
	if minp.y < 30488 then
		gen_nether_chunk(minp,maxp,seed)
	end
end)
