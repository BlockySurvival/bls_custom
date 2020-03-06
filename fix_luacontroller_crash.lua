-- see https://github.com/BlockySurvival/issue-tracker/issues/180#issuecomment-595713591
-- I'm not certain this is actually the cause of any of our issues, but it seems like it could be.

local actual_unpack = unpack
function unpack(t, a, b)
	assert(not b or b < 2^30)
	return actual_unpack(t, a, b)
end
