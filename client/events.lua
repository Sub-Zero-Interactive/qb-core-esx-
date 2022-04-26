-- Player load and unload handling
-- New method for checking if logged in across all scripts (optional)
-- if LocalPlayer.state['isLoggedIn'] then
-- RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
--     ShutdownLoadingScreenNui()
--     LocalPlayer.state:set('isLoggedIn', true, false)
--     if not QBConfig.Server.PVP then return end
--     SetCanAttackFriendly(PlayerPedId(), true, false)
--     NetworkSetFriendlyFireOption(true)
-- end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    LocalPlayer.state:set('isLoggedIn', false, false)
end)

RegisterNetEvent('QBCore:Notify', function(text, type, length)
    QBCore.Functions.Notify(text, type, length)
end)

RegisterNetEvent('QBCore:Client:TriggerCallback', function(name, ...)
    if QBCore.ServerCallbacks[name] then
        QBCore.ServerCallbacks[name](...)
        QBCore.ServerCallbacks[name] = nil
    end
end)

RegisterNetEvent('QBCore:Client:UseItem', function(item)
    TriggerServerEvent('QBCore:Server:UseItem', item)
end)

-- Me command
