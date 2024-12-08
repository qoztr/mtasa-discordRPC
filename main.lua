local DiscordRPC = {
    title = "Test Server", -- Server Name
    appID = "", -- Discord Application ID
    logoName = "", -- Discord logo asset name
    timer = nil,
}

function DiscordRPC:init()
    if isDiscordRichPresenceConnected() then
        if not isTimer(self.timer) then
            setDiscordApplicationID(self.appID)
            self:show()
            self:update()
        end
    else
        if isTimer(self.timer) then
            killTimer(self.timer)
            self.timer = nil
        end
        resetDiscordRichPresenceData()
    end
end

function DiscordRPC:show()
    setDiscordRichPresenceAsset(self.logoName, self.title)
    setDiscordRichPresenceStartTime(1)
end

function DiscordRPC:update()
    setDiscordRichPresenceDetails(getPlayerName(localPlayer):gsub("#%x%x%x%x%x%x", ""))
    setDiscordRichPresenceState("In-Game: " ..#getElementsByType("player").. " Players")

    if not isTimer(self.timer) then
        self.timer = setTimer(function()
            self:update()
        end, 3000, 0)
    end
end

addEventHandler("onClientResourceStart", resourceRoot, function()
    DiscordRPC:init()
end)

addEventHandler("onClientResourceStop", resourceRoot, function()
    if isTimer(DiscordRichPresence.timer) then
        killTimer(DiscordRichPresence.timer)
    end

    resetDiscordRichPresenceData()
end)