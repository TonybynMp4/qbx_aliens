QBCore = exports['qb-core']:GetCoreObject()
local entity

local function spawnUFO()
    local ufomodel = `p_spinning_anus_s`
    RequestModel(ufomodel)
    while not HasModelLoaded(ufomodel) do
        Wait(10)
    end

    TriggerServerEvent('qb-weathersync:server:setWeather', 'THUNDER')
    TriggerServerEvent('qb-weathersync:server:setTime', 23, 0)

    local ufo = CreateObject(ufomodel, vector3(1228.69, 2148.47, 131.51), true, false)
    SetEntityCollision(ufo, true, true)
    local ufo2 = CreateObject(ufomodel, vector3(1239.13, 2218.41, 160.44), true, false)
    SetEntityCollision(ufo, true, true)
    local ufo3 = CreateObject(ufomodel, vector3(1231.49, 2102.06, 163.06), true, false)
    SetEntityCollision(ufo, true, true)
    Wait(15000)
    DeleteEntity(ufo)
    DeleteEntity(ufo2)
    DeleteEntity(ufo3)
end

CreateThread(function()
    while true do
        Wait(500)
		local plyCoords = GetEntityCoords(PlayerPedId(), false)
		local dist = #(plyCoords - vector3(1369.97, 2184.43, 97.86))
        if dist <= 50.0 then
            if not DoesEntityExist(entity) then
                local model = `a_m_m_indian_01`
                RequestModel(model)
				while not HasModelLoaded(model) do
					Wait(10)
				end
				entity = CreatePed(26, model, vector3(1369.97, 2184.43, 96.86), 92.44, true, false)
				SetEntityHeading(entity, 1.8)
                SetEntityInvincible(entity, true)
                FreezeEntityPosition(entity, true)
				SetBlockingOfNonTemporaryEvents(entity, true)
				TaskStartScenarioInPlace(entity, "WORLD_HUMAN_AA_SMOKE", 0, false)
			end
                exports['qb-target']:AddTargetEntity(entity, {
                    options = {
                        {
                            action = function()
                                if IsPedAPlayer(entity) then return false end
                                spawnUFO()
                            end,
                            icon = "fas fa-circle-check",
                            label = "Spawn UFO",
                        },
                    },
                    distance = 3.0
                })
        elseif DoesEntityExist(entity) then
			DeleteEntity(entity)
		else
			Wait(1500)
		end
    end
end)