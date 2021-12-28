
local S = minetest.get_translator("bls")

local votes = {}
local mod_storage = bls.mod_storage

local stored_votes = mod_storage:get_string('democracy:votes')
if stored_votes ~= "" then
	votes = minetest.deserialize(stored_votes)

	votes.test = {
		creator = "singleplayer",
		description = "test vote",
		options = {"a","b","c","d","e","f"},
		end_time = 1987347,
		votes = {
			a = {choice="a",reason="thing"},
			g = {choice="a",reason="thingsdfsdfg"},
			h = {choice="a",reason="thgan"},
			j = {choice="b",reason="thingtht"},
			k = {choice="f",reason="thingerwerdf"},
			l = {choice="f",reason="thingrgetg"},
			m = {choice="b"},
		}
	}
end
-- votes = {}

local function save_votes()
	mod_storage:set_string('democracy:votes', minetest.serialize(votes))
end

local time_units = {
	minute = 60,
	hour = 60 * 60,
	day = 60 * 60 * 24,
	week = 60 * 60 * 24 * 7,
	month = 60 * 60 * 24 * 30,
	year = 60 * 60 * 24 * 365,
}
-- abbreviations
time_units.min = time_units.minute
time_units.h = time_units.hour
time_units.d = time_units.day
time_units.w = time_units.week
time_units.m = time_units.month
time_units.y = time_units.year
-- plurals
time_units.mins = time_units.minute
time_units.minutes = time_units.minute
time_units.hours = time_units.hour
time_units.days = time_units.day
time_units.weeks = time_units.week
time_units.months = time_units.month
time_units.years = time_units.year

local function parse_timespans(text)
	local reading = nil
	local buffer = ""
	local spans = {}
	local current_span = {}
	local lower_text = text:lower().." "
	for i = 1, #lower_text do
		local char = lower_text:sub(i,i)
		local read_number = char:match('%d')
		local read_letter = char:match('[a-z]')
		if not read_number and reading == 'value' then
			current_span.value = tonumber(buffer)
			buffer = ""
			reading = nil
		elseif not read_letter and reading == 'unit' then
			current_span.unit = buffer
			buffer = ""
			reading = nil
			table.insert(spans, current_span)
			current_span = {}
		end
		if read_number then
			reading = 'value'
			buffer = buffer .. char
		elseif read_letter then
			reading = 'unit'
			buffer = buffer .. char
		end
	end
	local total = 0
	local errors = {}
	for _,span in ipairs(spans) do
		local err = false
		if not span.unit then
			table.insert(errors, S("Timespan has no unit"))
			err = true
		elseif not time_units[span.unit] then
			table.insert(errors, span.unit..S(" is not a valid time unit"))
			err = true
		elseif not span.value then
			table.insert(errors, S("Timespan has no value"))
			err = true
		end
		if not err then
			total = total + (time_units[span.unit] * span.value)
		end
	end
	if #errors ~= 0 then
		return nil, errors
	end
	return total
end

local function vote_results(name, inverse)
	local counts = {}
	local ordered_counts = {}
	for _,option in ipairs(votes[name].options) do
		local count = {count=0,reasons={},option=option}
		counts[option] = count
		table.insert(ordered_counts, count)
	end
	for _,vote in pairs(votes[name].votes) do
		local count = counts[vote.choice]
		count.count = count.count + 1
		if vote.reason and vote.reason ~= "" then
			table.insert(count.reasons, vote.reason)
		end
	end
	table.sort(ordered_counts, function (a,b)
		if inverse then
			return a.count < b.count
		else
			return a.count > b.count
		end
	end)
	return ordered_counts
end

minetest.register_privilege('voter', 'allows players to vote on topics')
minetest.register_privilege('vote_maker', 'allows players create new topics to vote on')
minetest.register_privilege('vote_admin', 'allows players to inspect and edit any vote topic')


--[[
Commands:

/vote_new name duration description
Make a new vote with a unique name (no spaces), set how long it will last in hours (1h / 1hour) or days (1d / 1days), or m (1m / 1minute),, and provide a description.

/vote_add_option name option
Add an option to a vote you created.

/vote_extend name duration
Extend the duration of a vote you created to give it more time.

/vote_results name
List the results for a vote you have created.

/vote name option
Vote on a topic. Provide the unique name of the topic and your option, either as the full option or its number.

/vote_reason name reason
Give a reason for your vote. Provide the unique name of the topic and your reasoning.

/vote_list
List all the votes currently active.

/vote_options name
List all the options for the given vote.

]]

minetest.register_chatcommand('vote_new', {
	description = S("Make a new vote with a unique name (no spaces), set how long it will last, and provide a description."),
	params = "<name> <duration> <description>",
	privs = {vote_maker=true},
	func = function (player_name, param)
		local name, duration, description = param:match("^(%S+)%s+(%S+)%s*(.*)$")
		if not name or name == "" then
			return false, S("A name must be provided for the new vote.")
		end
		if votes[name] then
			return false, S("A vote by this name already exists, please choose a unique name.")
		end
		if not duration or duration == "" then
			return false, S("A duration must be provided for the new vote.")
		end
		local dur, errs = parse_timespans(duration)
		if errs then
			return false, S("There is a problem with the duration: ")..errs[1]
		end
		if not description or description == "" then
			return false, S("A description must be provided for the new vote.")
		end

		votes[name] = {
			creator = player_name,
			end_time = os.time()+dur,
			description = description,
			options = {},
			votes = {},
		}
		save_votes()
		return true, S("Your vote has been successfully created. You should add some options with").." '/vote_add_option "..name.." <option>'"
	end
})

minetest.register_chatcommand('vote_add_option', {
	description = S("Add an option to a vote you created."),
	params = "<name> <option>",
	privs = {vote_maker=true},
	func = function (player_name, param)
		local name, option = param:match("^(%S+)%s*(.*)$")
		if not name or name == "" then
			return false, S("A name must be provided to find the vote.")
		end
		if not votes[name] or (votes[name].creator ~= player_name and not minetest.check_player_privs(player_name, {vote_admin=true})) then
			return false, S("A vote by this name does not exist, or was not created by you.")
		end
		if votes[name].end_time < os.time() then
			return false, S("This vote has already ended.")
		end
		if not option or option == "" then
			return false, S("An option must be provided as the second argument.")
		end

		table.insert(votes[name].options, option)
		save_votes()

		return true, S("The option has been successfully added to the vote.")
	end
})

minetest.register_chatcommand('vote_extend', {
	description = S("Extend the duration of a vote you created to give it more time."),
	params = "<name> <duration>",
	privs = {vote_maker=true},
	func = function (player_name, param)
		local name, duration = param:match("^(%S+)%s*(.*)$")
		if not name or name == "" then
			return false, S("A name must be provided to find the vote.")
		end
		if not votes[name] or (votes[name].creator ~= player_name and not minetest.check_player_privs(player_name, {vote_admin=true})) then
			return false, S("A vote by this name does not exist, or was not created by you.")
		end
		if not duration or duration == "" then
			return false, S("A duration must be provided to extend the vote by.")
		end
		local dur, errs = parse_timespans(duration)
		if errs then
			return false, S("There is a problem with the duration: ")..errs[1]
		end

		votes[name].end_time = votes[name].end_time+dur
		save_votes()

		return true, S("The vote has been successfully extended.")
	end
})

minetest.register_chatcommand('vote_results', {
	description = S("List the results for a vote you have created."),
	params = "<name> <show reasons?>",
	privs = {vote_maker=true},
	func = function (player_name, param)
		local name, give_reasons = param:match("^(%S+)(.*)$")
		if not name or name == "" then
			return false, S("A name must be provided to find the vote.")
		end
		if not votes[name] or (votes[name].creator ~= player_name and not minetest.check_player_privs(player_name, {vote_admin=true})) then
			return false, S("A vote by this name does not exist, or was not created by you.")
		end
		if votes[name].end_time > os.time() and not minetest.check_player_privs(player_name, {vote_admin=true}) then
			return false, S("This vote has not yet ended.")
		end
		local trimmed_give_reasons = give_reasons and give_reasons:lower():trim()
		if trimmed_give_reasons == ""
		or trimmed_give_reasons == "false"
		or trimmed_give_reasons == "no"
		then give_reasons = nil end

		local ordered_counts = vote_results(name, true)
		local vote_str = S("Votes for ")..("'%s':"):format(votes[name].description)
		if #ordered_counts == 0 then
			return S("There are no votes on this topic yet.")
		else
			for _,count in ipairs(ordered_counts) do
				local reason_str = ""
				if give_reasons then
					for _,reason in ipairs(count.reasons) do
						reason_str = reason_str .. "\n\t\t\t"..reason
					end
				end
				vote_str = vote_str
						.. ("\n\t%i votes for '%s'"):format(count.count, count.option)
						.. ((give_reasons and #count.reasons ~= 0) and ("\n\t\treasons:"..reason_str) or "")
			end
		end

		return true, vote_str
	end
})

minetest.register_chatcommand('vote_inspect', {
	description = S("List the results for a vote, including the voters."),
	params = "<name> <show reasons?>",
	privs = {vote_admin=true},
	func = function (player_name, param)
		local name, give_reasons = param:match("^(%S+)(.*)$")
		if not name or name == "" then
			return false, S("A name must be provided to find the vote.")
		end
		if not votes[name] or not minetest.check_player_privs(player_name, {vote_admin=true}) then
			return false, S("A vote by this name does not exist, or was not created by you.")
		end
		local trimmed_give_reasons = give_reasons and give_reasons:lower():trim()
		if trimmed_give_reasons == ""
		or trimmed_give_reasons == "false"
		or trimmed_give_reasons == "no"
		then give_reasons = nil end

		local counts = {}
		local ordered_counts = {}
		for _,option in ipairs(votes[name].options) do
			local count = {count=0,reasons={},option=option}
			counts[option] = count
			table.insert(ordered_counts, count)
		end
		for voter,vote in pairs(votes[name].votes) do
			local count = counts[vote.choice]
			count.count = count.count + 1
			if vote.reason and vote.reason ~= "" then
				table.insert(count.reasons, voter..": "..vote.reason)
			else
				table.insert(count.reasons, voter)
			end
		end
		table.sort(ordered_counts, function (a,b)
			return a.count < b.count
		end)
		local vote_str = S("Votes for ")..("'%s':"):format(votes[name].description)
		if #ordered_counts == 0 then
			return S("There are no votes on this topic yet.")
		else
			for _,count in ipairs(ordered_counts) do
				local reason_str = ""
				if give_reasons then
					for _,reason in ipairs(count.reasons) do
						reason_str = reason_str .. "\n\t\t\t"..reason
					end
				end
				vote_str = vote_str
						.. ("\n\t%i votes for '%s'"):format(count.count, count.option)
						.. ((give_reasons and #count.reasons ~= 0) and ("\n\t\treasons:"..reason_str) or "")
			end
		end

		return true, vote_str
	end
})

minetest.register_chatcommand('vote_delete', {
	description = S("Delete one of your votes."),
	params = "<name>",
	privs = {vote_maker=true},
	func = function (player_name, param)
		local name = param:match("^(%S+)$")
		if not name or name == "" then
			return false, S("A name must be provided to find the vote.")
		end
		if not votes[name] or (votes[name].creator ~= player_name and not minetest.check_player_privs(player_name, {vote_admin=true})) then
			return false, S("A vote by this name does not exist, or was not created by you.")
		end

		votes[name] = nil
		save_votes()

		return true, S("The vote has been successfully deleted.")
	end
})

minetest.register_chatcommand('vote', {
	description = S("Vote on a topic. Provide the unique name of the topic and your option, either as the full option or its number."),
	params = "<name> <option>",
	privs = {voter=true},
	func = function (player_name, param)
		local name, option = param:match("^(%S+)%s*(.*)$")
		if not name or name == "" then
			return false, S("A name must be provided to find the vote.")
		end
		if not votes[name] then
			return false, S("A vote by this name does not exist.")
		end
		if votes[name].end_time < os.time() then
			return false, S("This vote has already ended.")
		end
		if not option or option == "" then
			return false, S("An option must be provided as the second argument.")
		end
		if option:match("^%d+$") and votes[name].options[tonumber(option)] then
			option = votes[name].options[tonumber(option)]
		else
			local valid = false
			for _,opt in ipairs(votes[name].options) do
				if opt == option then
					valid = true
					break
				end
			end
			if not valid then
				return false, S("The choice you made is not valid.")
			end
		end

		votes[name].votes[player_name] = votes[name].votes[player_name] or {}
		votes[name].votes[player_name].choice = option
		save_votes()

		return true, S("You have successfully voted '%s' on this topic.", option)
	end
})

minetest.register_chatcommand('vote_reason', {
	description = S("Give a reason for your vote. Provide the unique name of the topic and your reasoning."),
	params = "<name> <reason>",
	privs = {voter=true},
	func = function (player_name, param)
		local name, reason = param:match("^(%S+)%s*(.*)$")
		if not name or name == "" then
			return false, S("A name must be provided to find the vote.")
		end
		if not votes[name] then
			return false, S("A vote by this name does not exist.")
		end
		if votes[name].end_time < os.time() then
			return false, S("This vote has already ended.")
		end
		if not reason or reason == "" then
			return false, S("A reason must be provided as the second argument.")
		end

		votes[name].votes[player_name] = votes[name].votes[player_name] or {}
		votes[name].votes[player_name].reason = reason
		save_votes()

		return true, S("You have successfully provided a reason for your vote.")
	end
})

minetest.register_chatcommand('vote_list', {
	description = S("List all the votes currently active."),
	privs = {voter=true},
	func = function (player_name, param)
		local output = S("All currently active votes:")
		local any_votes = false
		local current_time = os.time()

		for name, vote in pairs(votes) do
			if vote.end_time > current_time then
				any_votes = true
				output = output.."\n\t"..name..": "..vote.description
			end
		end

		if not any_votes then
			return false, S("There are no topics to vote on right now.")
		end

		return true, output
	end
})

minetest.register_chatcommand('vote_options', {
	description = S("List all the options for the given vote."),
	params = "<name>",
	privs = {voter=true},
	func = function (player_name, param)
		local name = param:match("^(%S+)$")
		if not name or name == "" then
			return false, S("A name must be provided to find the vote.")
		end
		if not votes[name] then
			return false, S("A vote by this name does not exist.")
		end
		if votes[name].end_time < os.time() and not minetest.check_player_privs(player_name, {vote_admin=true}) then
			return false, S("This vote has already ended.")
		end
		local output = S("Options for ")..("'%s':"):format(votes[name].description)

		if #votes[name].options == 0 then
			return false, S("There are currently no options to choose from.")
		end

		for i, option in ipairs(votes[name].options) do
			output = output.."\n\t"..tostring(i)..": "..option
		end

		return true, output
	end
})

--[[
Interface outline:

GIVE REASON =
	Would you like to give a reason?
	Thank you, vote on something else?
		YES: Choose topic
		NO: EXIT

MAKE VOTE =
	List options
	GIVE REASON

Start
Choose topic
	Already voted?
		YES: You already voted (option) Would you like to:
			Change vote
				MAKE VOTE
			Change reason
				GIVE REASON
		NO:
			MAKE VOTE
]]
local function option_buttons(start_y, gen, get_val, render_button)
	local c = 0
	for name, def in pairs(gen) do
		c = c+1
	end
	local h = c
	local w = 1
	if c > 5 then
		h = math.ceil(c / 2)
		w = 2
	end

	local formspec = ""
	local i = 0
	for index, def in pairs(gen) do
		formspec = formspec..
		(render_button
			and render_button(tostring(index), math.floor(i/h)*6, start_y+(i%h))
			or ("button[%f,%f;6,1;%s;%s]"):format(
				math.floor(i/h)*6,
				start_y+(i%h),
				minetest.formspec_escape(tostring(index)),
				minetest.formspec_escape(get_val and get_val(def) or def)
			)
		)
		i = i+1
	end
	return formspec, w*6, h
end

local formprefix = "democracy:"
local show_formspec = nil
local vote_contexts = {}
local formspecs = {
	actions = {
		form = function ()
			return "size[4,4]"
				.."button[1,1;2,1;vote;"..minetest.formspec_escape(S("Vote")).."]"
				.."button[1,2;2,1;edit;"..minetest.formspec_escape(S("Your Topics")).."]"
				.. default.gui_bg..default.gui_bg_img..default.gui_slots
		end,
		handle = function (player_name, fields, formname)
			if fields.quit then
				vote_contexts[player_name] = nil
				return
			end
			vote_contexts[player_name] = {}
			if fields.edit then
				if minetest.check_player_privs(player_name, {vote_maker=true}) then
					show_formspec(player_name, "manage")
				else
					show_formspec(player_name, "error", S("You do not have the privilages required to make votes."))
				end
				return
			end
			if fields.vote then
				if minetest.check_player_privs(player_name, {voter=true}) then
					show_formspec(player_name, "choose")
				else
					show_formspec(player_name, "error", S("You do not have the privilages required to vote."))
				end
				return
			end
		end
	},
	choose = {
		form = function (player_name)
			local active_votes = {}
			local current_time = os.time()
			for name,vote in pairs(votes) do
				if vote.end_time > current_time then
					active_votes['vote:'..name] = vote
				end
			end
			local buttons, w, h = option_buttons(1, active_votes, function (def)
				return def.description .. (def.votes[player_name] and (' ('..S("Voted")..')') or '')
			end)
			return ("size[%f,%f]"):format(w, h+1)
					.. ('label[0,0;%s]'):format(minetest.formspec_escape(S("Choose a topic to vote on:")))
					.. (h == 0 and
						('label[0,0.5;%s]'):format(minetest.formspec_escape(S("There are no topics to vote on right now.")))
						or ""
					)
					.. buttons
					.. default.gui_bg..default.gui_bg_img..default.gui_slots
		end,
		handle = function (player_name, fields, formname)
			if fields.quit then
				vote_contexts[player_name] = nil
				return
			end
			local vote_name = nil
			for name,_ in pairs(fields) do
				vote_name = name:sub(6)
				break
			end
			if not vote_name then return end

			vote_contexts[player_name].vote_name = vote_name
			if votes[vote_name].votes[player_name] then
				show_formspec(player_name, "already_voted")
			else
				show_formspec(player_name, "make_vote")
			end
		end
	},
	already_voted = {
		form = function (player_name)
			local vote_name = vote_contexts[player_name].vote_name
			local choice = votes[vote_name].votes[player_name].choice
			return  "size[6,4]"
					.. ('label[0,0;%s]'):format(minetest.formspec_escape(S("You have already voted on this topic.")))
					.. ('label[0,0.3;%s]'):format(minetest.formspec_escape(S("You voted for:")))
					.. ('label[0,1;%s]'):format(minetest.formspec_escape(choice))
					.. ("button[0,2;6,1;vote;%s]"):format(minetest.formspec_escape(S("Change your vote")))
					.. ("button[0,3;6,1;reason;%s]"):format(minetest.formspec_escape(S("Change your reason")))
					.. default.gui_bg..default.gui_bg_img..default.gui_slots
		end,
		handle = function (player_name, fields, formname)
			if fields.quit then
				vote_contexts[player_name] = nil
				return
			end
			if fields.vote then
				show_formspec(player_name, "make_vote")
			elseif fields.reason then
				show_formspec(player_name, "give_reason")
			end
		end
	},
	make_vote = {
		form = function (player_name)
			local vote_name = vote_contexts[player_name].vote_name
			local vote_options = votes[vote_name].options
			local buttons, w, h = option_buttons(1, vote_options)
			return ("size[%f,%f]"):format(w, h+1)
					.. ('label[0,0;%s]'):format(minetest.formspec_escape(S("Choose one of the options:")))
					.. (h == 0 and
						('label[0,0.5;%s]'):format(minetest.formspec_escape(S("There are currently no options to choose from.")))
						or ""
					)
					.. buttons
					.. default.gui_bg..default.gui_bg_img..default.gui_slots
		end,
		handle = function (player_name, fields, formname)
			if fields.quit then
				vote_contexts[player_name] = nil
				return
			end
			if not minetest.check_player_privs(player_name, {voter=true}) then
				show_formspec(player_name, "error", S("You do not have the privilages required to vote."))
				return
			end
			local vote_choice_index = nil
			local vote_choice = nil
			for i,opt in pairs(fields) do
				vote_choice_index = tonumber(i)
				vote_choice = opt
				break
			end

			local vote_name = vote_contexts[player_name].vote_name
			if votes[vote_name].end_time < os.time() then
				show_formspec(player_name, "error", S("This vote has already ended."))
				return
			end
			local vote_options = votes[vote_name].options
			local existing_option = vote_options[vote_choice_index]

			if existing_option ~= vote_choice then
				vote_contexts[player_name] = nil
				-- minetest.log("error", )
				show_formspec(player_name, "error", S("There was a problem when making your vote. Please try again."))
				return
			end

			votes[vote_name].votes[player_name] = votes[vote_name].votes[player_name] or {}
			votes[vote_name].votes[player_name].choice = vote_choice
			save_votes()

			show_formspec(player_name, "give_reason")
		end
	},
	give_reason = {
		form = function (player_name)
			return "size[6,6]"
					.. ('label[0,0;%s]'):format(minetest.formspec_escape(S("Would you like to give a reason for your vote?")))
					.. ('textarea[0.3,1;6,4;reason;%s;]'):format(minetest.formspec_escape(S("Reason")))
					.. ("button[0,5;2,1;no;%s]"):format(minetest.formspec_escape(S("No")))
					.. ("button[2,5;4,1;continue;%s]"):format(minetest.formspec_escape(S("Save & Continue")))
					.. default.gui_bg..default.gui_bg_img..default.gui_slots
		end,
		handle = function (player_name, fields, formname)
			if fields.quit then
				vote_contexts[player_name] = nil
				return
			end
			if not minetest.check_player_privs(player_name, {voter=true}) then
				show_formspec(player_name, "error", S("You do not have the privilages required to vote."))
				return
			end
			if not fields.no and fields.reason ~= "" then
				local vote_name = vote_contexts[player_name].vote_name
				if votes[vote_name].end_time < os.time() then
					show_formspec(player_name, "error", S("This vote has already ended."))
					return
				end
				votes[vote_name].votes[player_name] = votes[vote_name].votes[player_name] or {}
				votes[vote_name].votes[player_name].reason = fields.reason
				save_votes()
			end

			show_formspec(player_name, "continue")
		end
	},
	continue = {
		form = function (player_name)
			return "size[6,3]"
					.. ('label[0,0;%s]'):format(minetest.formspec_escape(S("Thank you for your vote.")))
					.. ('label[0,0.3;%s]'):format(minetest.formspec_escape(S("Would you like to vote on something else?")))
					.. ("button[0,1;6,1;yes;%s]"):format(minetest.formspec_escape(S("Yes")))
					.. ("button[0,2;6,1;no;%s]"):format(minetest.formspec_escape(S("No")))
					.. default.gui_bg..default.gui_bg_img..default.gui_slots
		end,
		handle = function (player_name, fields, formname)
			vote_contexts[player_name] = nil
			if fields.yes then
				vote_contexts[player_name] = {}
				show_formspec(player_name, "choose")
			elseif fields.no then
				minetest.close_formspec(player_name, formname)
			end
		end
	},

	manage = {
		form = function (player_name, options)
			local player_votes = {}
			for name, vote in pairs(votes) do
				if vote.creator == player_name or minetest.check_player_privs(player_name, {vote_admin=true}) then
					player_votes['vote:'..name] = vote
				end
			end
			local buttons, w, h = option_buttons(2, player_votes, function (def)
				return def.description .. (def.votes[player_name] and (' ('..S("Voted")..')') or '')
			end)
			return ("size[%f,%f]"):format(w,h+2)
					.. ('label[0,0;%s]'):format(minetest.formspec_escape(S("Manage your votes.")))
					.. ("button[0,0.7;6,1;create;%s]"):format(minetest.formspec_escape(S("Create a new vote")))
					.. (h == 0 and ('label[0,1.7;%s]'):format(minetest.formspec_escape(S("You do not currently have any votes to manage."))) or buttons)
		end,
		handle = function (player_name, fields, formname)
			if fields.quit then return end
			if not minetest.check_player_privs(player_name, {vote_maker=true}) then
				show_formspec(player_name, "error", S("You do not have the privilages required to make votes."))
				return
			end
			if fields.create then
				show_formspec(player_name, "create")
				return
			end
			local vote_name = nil
			for name,_ in pairs(fields) do
				vote_name = name:sub(6)
				break
			end

			if vote_name and votes[vote_name] and (votes[vote_name].creator == player_name or minetest.check_player_privs(player_name, {vote_admin=true})) then
				vote_contexts[player_name] = { vote_name=vote_name }
				show_formspec(player_name, "edit")
				return
			end

			show_formspec(player_name, "error", S("The vote you chose is not valid."))
		end
	},
	edit = {
		form = function (player_name, options, errors)
			local vote_name = vote_contexts[player_name].vote_name

			local vote_str = ""
			if votes[vote_name].end_time < os.time() then
				local ordered_counts = vote_results(vote_name)
				if #ordered_counts == 0 then
					vote_str = S("There are no votes on this topic yet.")
				else
					for _,count in ipairs(ordered_counts) do
						local reason_str = ""
						for _,reason in ipairs(count.reasons) do
							reason_str = reason_str .. "\n\t\t"..reason
						end
						vote_str = vote_str
								.. ("%i votes for '%s'"):format(count.count, count.option)
								.. ((#count.reasons ~= 0) and ("\n\treasons:"..reason_str) or "")
								.. "\n\n"
					end
				end
			end
			return "size[6,7]"
					.. ('label[0,0;%s]'):format(minetest.formspec_escape(S("Editing your vote: ")..("'%s'"):format(vote_name)))
					.. ('label[0,0.3;%s]'):format(minetest.formspec_escape(S("Description: ")..("'%s'"):format(votes[vote_name].description)))
					-- always delete, extend
					.. ("button[0,0.8;6,1;delete;%s]"):format(minetest.formspec_escape(S("Delete this vote")))
					.. ("button[0,6;2,1;back;%s]"):format(minetest.formspec_escape(S("Back to list")))
					.. ("field[0.3,2.3;4,1;duration;%s;%s]button[4,2;2,1;extend;%s]"):format(
							minetest.formspec_escape(
								S("Duration")
								.. (errors and errors.duration and " ("..errors.duration..")" or "")
							),
							minetest.formspec_escape(options and options.duration or ""),
							minetest.formspec_escape(S("Extend vote"))
						)
					.. ((votes[vote_name].end_time > os.time())
						-- if active, add options
						and (('textarea[0.3,3.3;6,3;options;%s;%s]'):format(
							minetest.formspec_escape(
								S("Options (one per line)")
								.. (errors and errors.options and " ("..errors.options..")" or "")
							),
							minetest.formspec_escape(options and options.options or table.concat(votes[vote_name].options,"\n"))
						)
						.. ("button[4,6;2,1;save_options;%s]"):format(minetest.formspec_escape(S("Save options"))))
						-- if inactive, show results
						or ('textarea[0.3,3.3;6,3;results;%s;%s]'):format(
							minetest.formspec_escape(S("Results")),
							minetest.formspec_escape(vote_str)
						)
					)
		end,
		handle = function (player_name, fields, formname)
			if fields.quit then return end
			if not minetest.check_player_privs(player_name, {vote_maker=true}) then
				show_formspec(player_name, "error", S("You do not have the privilages required to make votes."))
				return
			end
			local has_errors = false
			local errors = {}
			local vote_name = vote_contexts[player_name].vote_name

			if not votes[vote_name] or (votes[vote_name].creator ~= player_name and not minetest.check_player_privs(player_name, {vote_admin=true})) then
				show_formspec(player_name, "error", S("A vote by this name does not exist, or was not created by you."))
				return
			end

			if fields.back then
				vote_contexts[player_name] = nil
				show_formspec(player_name, "manage")
				return
			elseif fields.delete then
				show_formspec(player_name, "confirm_delete")
				return
			elseif fields.save_options and fields.options then
				if votes[vote_name].end_time < os.time() then
					show_formspec(player_name, "error", S("This vote has already ended."))
					return
				end
				local new_options = string.split(fields.options, "\n")
				local new_options_indexed  = {}
				for _,option in ipairs(new_options) do
					new_options_indexed[option] = true
				end
				for _,option in ipairs(votes[vote_name].options) do
					if not new_options_indexed[option] then
						has_errors = true
						errors.options = S("You cannot remove any options.")
						break
					end
				end
				if not errors.options then
					votes[vote_name].options = new_options
					save_votes()

					show_formspec(player_name, "confirm_edit", S("The options have been updated."))
					return
				end
			elseif fields.extend then
				local duration, errs = parse_timespans(fields.duration)
				if errs then
					has_errors = true
					errors.duration = ""
					for i,e in ipairs(errs) do
						errors.duration = errors.duration .. e .. ". "
						if i == 2 then break end
					end
				else
					votes[vote_name].end_time = votes[vote_name].end_time+duration
					save_votes()

					show_formspec(player_name, "confirm_edit", S("The vote has been extended."))
					return
				end
			end
			if has_errors then
				show_formspec(player_name, "edit", fields, errors)
				return
			end
			show_formspec(player_name, "edit", fields)
		end
	},
	create = {
		form = function (player_name, options, errors)
			return "size[6,9]"
					.. ('label[0,0;%s]'):format(minetest.formspec_escape(S("Create a new vote:")))
					.. ("field[0.3,1;6,1;name;%s;%s]"):format(
							minetest.formspec_escape(
								S("Name")
								.. (errors and errors.name and " ("..errors.name..")" or "")
							),
							minetest.formspec_escape(options and options.name or "")
						)
					.. ("field[0.3,2;6,1;description;%s;%s]"):format(
							minetest.formspec_escape(
								S("Description")
								.. (errors and errors.description and " ("..errors.description..")" or "")
							),
							minetest.formspec_escape(options and options.description or "")
						)
					.. ("field[0.3,3;6,1;duration;%s;%s]"):format(
							minetest.formspec_escape(
								S("Duration")
								.. (errors and errors.duration and " ("..errors.duration..")" or "")
							),
							minetest.formspec_escape(options and options.duration or "1week")
						)
					.. ('textarea[0.3,4;6,5;options;%s;%s]'):format(
							minetest.formspec_escape(
								S("Options (one per line)")
								.. (errors and errors.options and " ("..errors.options..")" or "")
							),
							minetest.formspec_escape(options and options.options or "")
						)
					.. ("button[0,8.3;6,1;save;%s]"):format(minetest.formspec_escape(S("Save")))
					.. default.gui_bg..default.gui_bg_img..default.gui_slots
		end,
		handle = function (player_name, fields, formname)
			if fields.quit then return end
			if not minetest.check_player_privs(player_name, {vote_maker=true}) then
				show_formspec(player_name, "error", S("You do not have the privilages required to make votes."))
				return
			end
			local has_errors = false
			local errors = {}
			local options = {}
			local end_time = nil

			if fields.name == "" then
				has_errors = true
				errors.name = S("A unique name is required.")
			elseif votes[fields.name] then
				has_errors = true
				errors.name = S("This name is already taken.")
			elseif fields.name:find(" ") or fields.name:find("\n") then
				has_errors = true
				errors.name = S("The name cannot contain spaces.")
			end
			if fields.description == "" then
				has_errors = true
				errors.description = S("A description is required.")
			end
			if fields.duration == "" then
				has_errors = true
				errors.duration = S("A duration is required.")
			else
				local duration, errs = parse_timespans(fields.duration)
				if errs then
					has_errors = true
					errors.duration = ""
					for i,e in ipairs(errs) do
						errors.duration = errors.duration .. e .. ". "
						if i == 2 then break end
					end
				else
					end_time = os.time()+duration
				end
			end
			if fields.options == "" then
				has_errors = true
				errors.options = S("At least 2 options are required.")
			else
				options = string.split(fields.options, "\n")
				if #options < 2 then
					has_errors = true
					errors.options = S("At least 2 options are required.")
				end
			end

			if has_errors then
				show_formspec(player_name, "create", fields, errors)
			else
				votes[fields.name] = {
					creator = player_name,
					description = fields.description,
					options = options,
					end_time = end_time,
					votes = {}
				}
				save_votes()
				show_formspec(player_name, "manage")
			end
		end
	},
	confirm_edit = {
		form = function (player_name, message)
			return "size[6,2]"
					.. ('label[0,0.3;%s]'):format(minetest.formspec_escape(message))
					.. ("button[0,1;3,1;edit;%s]"):format(minetest.formspec_escape(S("Back to vote")))
					.. ("button[3,1;3,1;manage;%s]"):format(minetest.formspec_escape(S("Back to list")))
					.. default.gui_bg..default.gui_bg_img..default.gui_slots
		end,
		handle = function (player_name, fields, formname)
			if fields.quit then return end
			if fields.edit then
				show_formspec(player_name, "edit")
			elseif fields.manage then
				vote_contexts[player_name] = nil
				show_formspec(player_name, "manage")
			end
		end
	},
	confirm_delete = {
		form = function (player_name, message)
			return "size[6,2]"
					.. ('label[0,0.3;%s]'):format(minetest.formspec_escape(S("Are you sure you want to delete this vote?")))
					.. ("button[0,1;3,1;cancel;%s]"):format(minetest.formspec_escape(S("Cancel")))
					.. ("button[3,1;3,1;delete;%s]"):format(minetest.formspec_escape(S("Delete")))
					.. default.gui_bg..default.gui_bg_img..default.gui_slots
		end,
		handle = function (player_name, fields, formname)
			if fields.quit then return end
			if not minetest.check_player_privs(player_name, {vote_maker=true}) then
				show_formspec(player_name, "error", S("You do not have the privilages required to make votes."))
				return
			end
			if fields.cancel then
				show_formspec(player_name, "edit")
			elseif fields.delete then
				local vote_name = vote_contexts[player_name].vote_name
				if not votes[vote_name] or (votes[vote_name].creator ~= player_name and not minetest.check_player_privs(player_name, {vote_admin=true})) then
					show_formspec(player_name, "error", S("A vote by this name does not exist, or was not created by you."))
					return
				end
				votes[vote_name] = nil
				vote_contexts[player_name] = nil
				show_formspec(player_name, "manage")
			end
		end
	},
	error = {
		form = function (player_name, message)
			return "size[6,1]"
					.. ('label[0,0.3;%s]'):format(minetest.formspec_escape(message))
					.. default.gui_bg..default.gui_bg_img..default.gui_slots
		end,
		handle = function (player_name, fields, formname) end
	},
}

show_formspec = function (player_name, form, ...)
	return minetest.show_formspec(player_name, formprefix..form, formspecs[form].form(player_name, ...))
end

minetest.register_node(":democracy:voting_machine", {
	description=S("Voting Machine"),
	drawtype = "mesh",
	mesh = "voting_machine.obj",
	tiles = {"voting_machine.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3},
	on_rotate = minetest.get_modpath("screwdriver") and screwdriver.rotate_simple or nil,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", formspecs.actions.form())
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		formspecs.actions.handle(sender:get_player_name(), fields, formname)
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.above
		local above = vector.add(pos, {x=0,y=1,z=0})
		if minetest.is_protected(pos, placer:get_player_name()) or
		   minetest.is_protected(above, placer:get_player_name())
		then
			return itemstack
		end
		if minetest.get_node(above).name ~= "air" then
			minetest.chat_send_player(placer:get_player_name(), S("No room to place the voting machine"))
			return itemstack
		end
		local dir = placer:get_look_dir()
		local node = {name="democracy:voting_machine", param1=0, param2 = minetest.dir_to_facedir(dir)}
		minetest.set_node(pos, node)
		itemstack:take_item()
		return itemstack
	end
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname:sub(1,#formprefix) ~= formprefix then return end
	local form = formname:sub(#formprefix+1)
	return formspecs[form].handle(player:get_player_name(), fields, formname)
end)