local _ = require("gettext")
local Device = require("device")
local InfoMessage = require("ui/widget/infomessage")
local UIManager = require("ui/uimanager")
local Screen = Device.screen
local T = require("ffi/util").template

local items = {}
for i=0, Screen.wf_level_max do
    local info
    if i == 0 then
        info = _("Level 0: High quality, slow")
    elseif i == Screen.wf_level_max then
        info = T(_("Level %1: Low quality, fast"), i)
    else
        info = T(_("Level %1"), i)
    end

    table.insert(items, {
        text = info,
        checked_func = function() return Screen.wf_level == i end,
        callback = function()
            Screen.wf_level = i
            G_reader_settings:saveSetting("wf_level", i)
            UIManager:show(InfoMessage:new{
                text = _("This will take effect on next restart."),
            })
        end,
    })
end

return {
    text = _("Update aggressiveness"),
    sub_item_table = items,
}

