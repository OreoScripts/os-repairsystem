local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("os-repair:repairButton",function(button,price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveMoney("cash", price) then
        TriggerClientEvent("os-repair:repair", src,button)
    end
end)
