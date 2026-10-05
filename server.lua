local ESX = exports['es_extended']:getSharedObject()

-- Function to handle fare completion
RegisterNetEvent('taxi:completeFare')
AddEventHandler('taxi:completeFare', function(fare)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local playerId = xPlayer.identifier
        local totalEarnings = fare
        local totalRides = 1
        
        -- Update player's taxi job data
        MySQL.Async.execute('INSERT INTO taxi_job (player_id, total_earnings, total_rides) VALUES (@player_id, @total_earnings, @total_rides) ON DUPLICATE KEY UPDATE total_earnings = total_earnings + @total_earnings, total_rides = total_rides + @total_rides', {
            ['@player_id'] = playerId,
            ['@total_earnings'] = totalEarnings,
            ['@total_rides'] = totalRides
        }, function(rowsChanged)
            if rowsChanged > 0 then
                xPlayer.addAccountMoney('bank', totalEarnings)
                TriggerClientEvent('esx:showNotification', source, 'You have earned ~g~$' .. totalEarnings .. '~s~ for the fare.')
            else
                TriggerClientEvent('esx:showNotification', source, 'Failed to update taxi job data.')
            end
        end)
    end
end)

-- Function to get player's taxi job data
ESX.RegisterServerCallback('taxi:getPlayerData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local playerId = xPlayer.identifier
        MySQL.Async.fetchScalar('SELECT total_earnings FROM taxi_job WHERE player_id = @player_id', {
            ['@player_id'] = playerId
        }, function(totalEarnings)
            cb(totalEarnings or 0)
        end)
    else
        cb(0)
    end
end)