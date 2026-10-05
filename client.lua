local ESX = exports['es_extended']:getSharedObject()

local isTaxiJob = false
local isOnDuty = false
local currentFare = 0
local fareStartLocation = nil

-- Function to check if player is a taxi driver
local function isTaxiDriver()
    local playerData = ESX.GetPlayerData()
    return playerData.job and playerData.job.name == Config.TaxiJobName and playerData.job.grade_name == Config.TaxiJobGrade
end

-- Function to toggle taxi job status
local function toggleTaxiJob()
    if isTaxiJob then
        isTaxiJob = false
        isOnDuty = false
        ESX.ShowNotification('You are no longer a taxi driver.')
    else
        if isTaxiDriver() then
            isTaxiJob = true
            ESX.ShowNotification('You are now a taxi driver.')
        else
            ESX.ShowNotification('You are not a taxi driver.')
        end
    end
end

-- Function to toggle duty status
local function toggleDuty()
    if isTaxiJob then
        isOnDuty = not isOnDuty
        if isOnDuty then
            ESX.ShowNotification('You are now on duty.')
        else
            ESX.ShowNotification('You are now off duty.')
        end
    else
        ESX.ShowNotification('You are not a taxi driver.')
    end
end

-- Function to start a fare
local function startFare()
    if isTaxiJob and isOnDuty then
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if DoesEntityExist(vehicle) and GetVehicleClass(vehicle) == 18 then
            fareStartLocation = GetEntityCoords(playerPed)
            ESX.ShowNotification('Fare started.')
        else
            ESX.ShowNotification('You must be in a taxi to start a fare.')
        end
    else
        ESX.ShowNotification('You are not on duty.')
    end
end

-- Function to end a fare
local function endFare()
    if isTaxiJob and isOnDuty and fareStartLocation then
        local playerPed = PlayerPedId()
        local fareEndLocation = GetEntityCoords(playerPed)
        local distance = #(fareStartLocation - fareEndLocation)
        local fare = math.max(Config.MinimumFare, Config.BaseFare + (distance * Config.PerMileRate))
        currentFare = fare
        fareStartLocation = nil
        ESX.ShowNotification('Fare ended. Total fare: ~g~$' .. fare)
        TriggerServerEvent('taxi:completeFare', fare)
    else
        ESX.ShowNotification('No fare in progress.')
    end
end

-- Register commands
RegisterCommand('toggletaxi', toggleTaxiJob, false)
RegisterCommand('toggleduty', toggleDuty, false)
RegisterCommand('startfare', startFare, false)
RegisterCommand('endfare', endFare, false)

-- Create blip for taxi job
Citizen.CreateThread(function()
    local blip = AddBlipForCoord(Config.TaxiJobMarker.position.x, Config.TaxiJobMarker.position.y, Config.TaxiJobMarker.position.z)
    SetBlipSprite(blip, Config.TaxiJobBlip.sprite)
    SetBlipColour(blip, Config.TaxiJobBlip.color)
    SetBlipScale(blip, Config.TaxiJobBlip.scale)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(Config.TaxiJobBlip.label)
    EndTextCommandSetBlipName(blip)
end)

-- Create marker for taxi job
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local distance = #(playerCoords - Config.TaxiJobMarker.position)
        if distance < 10.0 then
            DrawMarker(Config.TaxiJobMarker.type, Config.TaxiJobMarker.position.x, Config.TaxiJobMarker.position.y, Config.TaxiJobMarker.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.TaxiJobMarker.scale.x, Config.TaxiJobMarker.scale.y, Config.TaxiJobMarker.scale.z, Config.TaxiJobMarker.color.r, Config.TaxiJobMarker.color.g, Config.TaxiJobMarker.color.b, Config.TaxiJobMarker.color.a, false, true, 2, nil, nil, false)
            if distance < 1.5 then
                ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to interact with the taxi job.')
                if IsControlJustReleased(0, 38) then
                    if isTaxiJob then
                        toggleDuty()
                    else
                        toggleTaxiJob()
                    end
                end
            end
        end
    end
end)

-- Handle player spawn
AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    if isTaxiDriver() then
        isTaxiJob = true
        ESX.ShowNotification('You are a taxi driver. Use /toggletaxi to toggle your status.')
    end
end)

-- Handle job change
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    if job.name == Config.TaxiJobName and job.grade_name == Config.TaxiJobGrade then
        isTaxiJob = true
        ESX.ShowNotification('You are now a taxi driver.')
    else
        isTaxiJob = false
        isOnDuty = false
        ESX.ShowNotification('You are no longer a taxi driver.')
    end
end)