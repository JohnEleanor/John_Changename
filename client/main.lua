local r = GetCurrentResourceName()
local display = false





RegisterNetEvent('John_Changename:cl-OpenUI')
AddEventHandler('John_Changename:cl-OpenUI', function(display)
    exports.nc_inventory:CloseInventory()
    OpenUI(not display)
end)

RegisterNUICallback("exit", function(data)
    OpenUI(false)
end)


RegisterNUICallback("success", function(data)

    OpenUI(false)

    TriggerServerEvent(r..':sv-sql', data.fName,data.lName)

end)




function OpenUI(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = 'ui',
        display = bool
    })

end

