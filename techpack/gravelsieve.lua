if not (
	    minetest.get_modpath("gravelsieve")
	and minetest.global_exists("gravelsieve")
) then return end

gravelsieve.set_probabilities(function ()
	local normal_gravel = "default:gravel"
	local sieved_gravel = "gravelsieve:sieved_gravel"
	local compressed_gravel = "gravelsieve:compressed_gravel"
	local sand = "default:sand"

	local gravel_probabilities = table.copy(gravelsieve.ore_probability)
	local overall_probability = 0
	for _,v in pairs(gravel_probabilities) do
		overall_probability = overall_probability+v
	end
	local remainder_probability = 0
	if overall_probability < 1 then
		remainder_probability = 1-overall_probability
	end

	gravel_probabilities[normal_gravel] = remainder_probability
	return {
		[compressed_gravel] = gravel_probabilities,
		[normal_gravel] = false,
		[sand] = { [sand] = 1 },
		[sieved_gravel] = { [sieved_gravel] = 1 }
	}
end)