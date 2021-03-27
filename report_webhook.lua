local http = assert(...)
local webhook_url = minetest.settings:get("secure.bls.report_webhook_url")

-- Don't do anything if no webhook is configured
if not webhook_url or webhook_url == "" or
        not minetest.registered_chatcommands["report"] then
    return
end

local function send_webhook(player_name, report)
    local data = minetest.write_json({
        embeds = {
            {
                title = "Report from " .. player_name,
                description = report
            }
        }
    })
    http.fetch({
        url = webhook_url,
        method = "POST",
        extra_headers = {"Content-Type: application/json"},
        data = data,
        post_data = data
    }, function() end)
end

local old_func = minetest.registered_chatcommands["report"].func
minetest.override_chatcommand("report", {
    func = function(name, param)
        local ok, msg = old_func(name, param)
        if ok then
            send_webhook(name, param)
        end
        return ok, msg
    end,
})
