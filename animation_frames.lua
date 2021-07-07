-- The smartshop manually renders inventorycubes, but we don't have enough information to slice a single frame of animation out, so all frames render simultaneously
-- We must manually provide the number of frames for any item we wish to render correctly, this is dirty, but it works


if minetest.get_modpath("tubelib") then
	local forceload_animation = minetest.registered_nodes["tubelib:forceload"].tiles[3].animation

	forceload_animation.frames_h = 4
	forceload_animation.frames_w = 1
end
