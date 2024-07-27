local isVoting = false
local mySteamId

RegisterCommand("vote",function()
    print(isVoting)
    if isVoting then
        SetNuiFocus(false, false)
        SendNUIMessage({
            action = 'close',
            resourceName = GetCurrentResourceName()
        })
        isVoting = false
    else
        isVoting = true
        TriggerServerEvent("wessy_autovote:vote")
    end
	
end)

RegisterNetEvent("wessy_autovote:vote")
AddEventHandler("wessy_autovote:vote", function(steamid)
	mySteamId = steamid
	SetNuiFocus(true, true)
    SendNUIMessage({
		action = "vote",
        resourceName = GetCurrentResourceName(),
		steamid = mySteamId
	})
end)

function closed()
    isVoting = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'close',
        resourceName = GetCurrentResourceName(),
		steamid = mySteamId
    })
end

-- Callback function for closing menu
RegisterNUICallback('closemenu', function(data, cb)
    -- Clear focus and destroy UI
    closed()
    -- Send ACK to callback function
    cb('ok')
end)

-- Callback function for claim menu
RegisterNUICallback('claimed', function(data, cb)

    local success = data["success"]
    local claimed = data["claimed"]

    --print(success, claimed)

    if success == true and claimed == 1 then
        TriggerServerEvent("wessy_autovote:claimed")
    end

    cb('ok')
end)