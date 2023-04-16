local QBCore = exports['qb-core']:GetCoreObject()

local PlayerData = {}

local isLoggedIn = LocalPlayer.state.isLoggedIn

local blips = {}


CreateThread(function()
    if QBCore.Functions.GetPlayerData().job then
        PlayerData = QBCore.Functions.GetPlayerData()
    end
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded",function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)
  
RegisterNetEvent("QBCore:Player:SetPlayerData",function(var)
    PlayerData = var
end)


RegisterNetEvent("cv-repair:open",function(notopen)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    local vehicleseat = GetPedInVehicleSeat(vehicle, -1)
    if vehicleseat == ped and vehicle then
        local fullprice = math.floor((1000 - GetVehicleBodyHealth(vehicle)) + (1000 - GetVehicleEngineHealth(vehicle)) + GetVehicleDirtLevel(vehicle) / 50 * 1500)
        if notopen == nil then notopen = true end
        SendNUIMessage({
            action = "openui",
            bodyprice = math.floor(1000 - GetVehicleBodyHealth(vehicle)),
            bodypercent = math.floor(GetVehicleBodyHealth(vehicle) / 10),
            engineprice = math.floor(1000 - GetVehicleEngineHealth(vehicle)),
            enginepercent = math.floor(GetVehicleEngineHealth(vehicle) / 10),
            dirtprice = math.floor(GetVehicleDirtLevel(vehicle) / 50 * 1500),
            dirtpercent =  math.floor((GetVehicleDirtLevel(vehicle) / 15.0) * 100.0),
            fullprice = fullprice - (fullprice * 10 / 100),
            open = notopen
        })
        SetNuiFocus(true,true)
    end
end)

RegisterNUICallback("UseButton", function(data, cb)
    if PlayerData.money.cash < data.price then QBCore.Functions.Notify("You don't have enough money", "error") cb(false) return end
    TriggerServerEvent("cv-repair:repairButton", data.button, data.price)
    cb(true)
end)

RegisterNetEvent("cv-repair:repair",function(button)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)

    if button == "full" then
        SetVehicleFixed(vehicle)
    elseif button == "body" then
        local EngineHealth = GetVehicleEngineHealth(vehicle)
        local DirtLevel = GetVehicleDirtLevel(vehicle)
        SetVehicleFixed(vehicle)
        SetVehicleEngineHealth(vehicle, EngineHealth)
        SetVehicleDirtLevel(vehicle, DirtLevel)
    elseif button == "engine" then
        SetVehicleEngineHealth(vehicle, 1000.0)
    elseif button == "dirt" then
        SetVehicleDirtLevel(vehicle, 0.0)
    end
    SendNUIMessage({
        action = "update",
        button = button
    })
    TriggerServerEvent("cv-repair:open", false)
end)

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
    exports['qb-core']:DrawText("[E] Bennys")
end)


local function createBlip(options)
    if not options.coords or type(options.coords) ~= 'table' and type(options.coords) ~= 'vector3' then return error(('createBlip() expected coords in a vector3 or table but received %s'):format(options.coords)) end
    local blip = AddBlipForCoord(options.coords.x, options.coords.y, options.coords.z)
    SetBlipSprite(blip, options.sprite or 1)
    SetBlipDisplay(blip, options.display or 4)
    SetBlipScale(blip, options.scale or 1.0)
    SetBlipColour(blip, options.colour or 1)
    SetBlipAsShortRange(blip, options.shortRange or false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(options.title or 'No Title Given')
    EndTextCommandSetBlipName(blip)
    return blip
end

local function deleteBlips()
    if not next(blips) then return end
    for i = 1, #blips do
        local blip = blips[i]
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end
    blips = {}
end

local function initBlips()
    for i = 1, #Config.Mechanics do
        local bennys = Config.Mechanics[i]
        if bennys.showBlip then
            blips[#blips + 1] = createBlip({
                coords = bennys.coords,
                sprite = bennys.blipData.sprite,
                display = bennys.blipData.display,
                scale = bennys.blipData.scale,
                colour = bennys.blipData.colour,
                shortRange = true,
                title = bennys.blipData.title
            })
        end
    end
end



---Bennys
AddEventHandler("polyzonehelper:enter", function(zone)
    if zone ~= "bennys" then return end
    if IsPedSittingInAnyVehicle(PlayerPedId()) then 
    exports['qb-core']:DrawText("[E] Bennys")
    OpenBennys()
    end
end)

AddEventHandler("polyzonehelper:exit", function(zone)
    if zone ~= "bennys" then return end

    exports['qb-core']:HideText()
    listening = false
end)

Citizen.CreateThread(function()
    exports["polyzonehelper"]:AddBoxZone("bennys", Config.Mechanics[1].coords, 2, 2, {
        debugPoly = false,
        heading=0,
        Config.Mechanics[1].minZ,
        Config.Mechanics[1].maxZ
    })
end)

function OpenBennys()
    listening = true

        while listening do
            if IsControlJustPressed(0, 38) then
                TriggerEvent("cv-repair:open")
                exports['qb-core']:HideText()
            end
            Wait(0)
        end
end


