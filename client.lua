-- ©Apollo https://discord.gg/7Km9ATw
local pedcheck = true
command = 'pedcheck'


-- Toggle Apollo Pedcheck
RegisterCommand(command, function(source)
        name = GetPlayerName(source)
        if pedcheck then
          pedcheck = false
          ClearPedTasksImmediately(GetPlayerPed(-1))
          TriggerEvent('chatMessage', "", {255, 0, 0}, "^7Apollo ped check toggled off by^1 " .. name)
        elseif not pedcheck then
          pedcheck = true
          TriggerEvent('chatMessage', "", {255, 0, 0}, "^7Apollo ped check toggled on by^1 " .. name)
          TriggerEvent("pedCheck")
        end
end)

-- Ped check event
RegisterNetEvent('pedCheck')
AddEventHandler('pedCheck',function()
CreateThread(function()
        while pedcheck == true do
        if IsPedInAnyVehicle(PlayerPedId(), true) and IsPedModel(GetPlayerPed(-1),GetHashKey("spawn_ped")) then
        TriggerEvent('pedinvehicle')
        elseif IsPedArmed(GetPlayerPed(-1), 7) and IsPedModel(GetPlayerPed(-1),GetHashKey("spawn_ped")) then
        TriggerEvent('disablemovement')
        elseif IsPedWalking(GetPlayerPed(-1), true) and IsPedModel(GetPlayerPed(-1),GetHashKey("spawn_ped")) then
        TriggerEvent('disablemovement')
        elseif IsPedRunning(GetPlayerPed(-1), true) and IsPedModel(GetPlayerPed(-1),GetHashKey("spawn_ped")) then
        TriggerEvent('disablemovement')
        else
                Citizen.Wait(500)
                end
                Wait(0)
             end
        end)
end)


-- Disable drive movement event
RegisterNetEvent('pedinvehicle')
AddEventHandler('pedinvehicle',function()
        DisableControlAction(0, 59, true) -- Disable steering in vehicle
        DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
        DisableControlAction(0, 72, true) -- Disable reversing in vehicle
        DisplayNotification("You ~r~need ~w~to change your ~r~skin~w~! ⚠️~n~If you want to drive!")
end)

-- Disable ped movement event
RegisterNetEvent('disablemovement')
AddEventHandler('disablemovement',function()
        TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CLIPBOARD", 0, true)
        DisplayNotification("You ~r~need ~w~to change your ~r~skin~w~! ⚠️~n~If you want to play!")
        PlaySoundFrontend(-1, "DELETE","HUD_DEATHMATCH_SOUNDSET", 1)
        Citizen.Wait(500)
end)

--Display notification code
---DisplayNotification("Test")
function DisplayNotification( text )
        SetNotificationTextEntry( "STRING" )
        AddTextComponentString( text )
        DrawNotification( false, false )
end
    
-- Make sure ped check is enabled
CreateThread(function()
        while true do
        if pedcheck then
        Citizen.Wait(500)
        TriggerEvent("pedCheck")
        end
        Citizen.Wait(500)
   end
end)

-- ©Apollo https://discord.gg/7Km9ATw