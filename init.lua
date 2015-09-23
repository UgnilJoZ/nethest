nethest = {}
nethest.border = -30488

-- Boilerplate to support localized strings if intllib mod is installed.
if (minetest.get_modpath("intllib")) then
 	dofile(minetest.get_modpath("intllib").."/intllib.lua")
	S = intllib.Getter(minetest.get_current_modname())
else
	S = function ( s ) return s end
end-- Boilerplate

dofile(minetest.get_modpath("nethest").."/functions.lua")
dofile(minetest.get_modpath("nethest").."/nodes.lua")
dofile(minetest.get_modpath("nethest").."/mapgen.lua")
