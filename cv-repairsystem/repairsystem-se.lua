local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("cv-repair:repairButton",function(button,price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveMoney("cash", price) then
        TriggerClientEvent("cv-repair:repair", src,button)
    end
end)
