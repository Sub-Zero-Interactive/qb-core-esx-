-- Event Handler

AddEventHandler('chatMessage', function(source, _, message)
    if string.sub(message, 1, 1) == '/' then
        CancelEvent()
        return
    end
end)


RegisterNetEvent('QBCore:ToggleDuty', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not Player then return end
    if xPlayer.job.duty then
        xPlayer.setDuty(false)
        TriggerClientEvent('QBCore:Notify', src, Lang:t('info.off_duty'))
    else
        xPlayer.setDuty(true)
        TriggerClientEvent('QBCore:Notify', src, Lang:t('info.on_duty'))
    end
end)

-- Items

RegisterNetEvent('QBCore:Server:UseItem', function(item)
    local src = source
    if not item or item.count <= 0 then return end
    ESX.UseItem(src, item)
end)

RegisterNetEvent('QBCore:Server:RemoveItem', function(itemName, amount, slot)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    xPlayer.removeInventoryItem(itemName, amount)
end)

RegisterNetEvent('QBCore:Server:AddItem', function(itemName, amount, slot, info)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end
    xPlayer.addInventoryItem(itemName, amount, slot)
end)

-- Has Item Callback (can also use client function - QBCore.Functions.HasItem(item))

ESX.RegisterServerCallback('QBCore:HasItem', function(source, cb, items, amount)
    local retval = false
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return cb(false) end
    if type(items) == 'table' then
        local count = 0
        local finalcount = 0
        for k, v in pairs(items) do
            if type(k) == 'string' then
                finalcount = 0
                for i, _ in pairs(items) do finalcount += 1 end
                local item = xPlayer.getInventoryItem(k)
                if item then
                    if item.count >= v then
                        count += 1
                        if count == finalcount then
                            retval = true
                        end
                    end
                end
            else
                finalcount = #items
                local item = xPlayer.getInventoryItem(k)
                if item then
                    if amount then
                        if item.count >= amount then
                            count += 1
                            if count == finalcount then
                                retval = true
                            end
                        end
                    else
                        count += 1
                        if count == finalcount then
                            retval = true
                        end
                    end
                end
            end
        end
    else
        local item = xPlayer.getInventoryItem(items)
        if not item then return cb(false) end
        if amount then
            if item.amount >= amount then
                retval = true
            end
        else
            retval = true
        end
    end
    cb(retval)
end)
