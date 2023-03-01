ESX = exports['es_extended']:getSharedObject()
local r = GetCurrentResourceName()



RegisterNetEvent(r..':sv-sql')
AddEventHandler(r..':sv-sql', function(f,l)
    
	local xPlayer = ESX.GetPlayerFromId(source)
    local Identifier = ESX.GetPlayerFromId(source).identifier
    local firstname = f
    local lastname = l

    
    local res = MySQL.Sync.fetchAll('SELECT *  FROM `users` WHERE identifier = @identifier', {
        ['@identifier'] = Identifier
    })

    local NamebeforeChange = res[1].firstname ..' '.. res[1].lastname
    local NameAffterChange = firstname..' '..lastname


    MySQL.query('UPDATE users SET firstname = ?,lastname = ? WHERE identifier = ? ', {firstname, lastname, Identifier}, function(affectedRows)
        if affectedRows then 
            exports.nc_discordlogs:Discord({
                webhook = 'IC_CHANGENAME',  -- ใส่ชื่อ webhook ที่ต้องการใน Config.Webhooks
                xPlayer = xPlayer,  -- ในฝั่ง Server ต้องใส่ xPlayer ทุกครั้ง
                -- xTarget = xTarget,  -- ในฝั่ง Server, xPlayer ของผู้ถูกกระทำ
                title = 'เปลี่ยนชื่อ TWITTER',  -- หัวเรื่องที่ต้องการแสดงใน discord
                message = 'ผู้เล่น'.. NamebeforeChange .. 'เปลี่ยนชื่อ เป็น' .. NameAffterChange,
                -- message คือ title ที่จะนำหน้าด้วยชื่อผู้เล่น (หากใช้งาน title และ message พร้อมกัน จะแสดงค่าเป็น title แทน)
                -- ตัวอย่าง: message = 'hello world!' ผลลัพท์ที่ได้จะเป็น title ที่แสดง => ชื่อผู้เล่น hello world!,
                description = 'ผู้เล่น `'.. NamebeforeChange .. '` เปลี่ยนชื่อ IC เป็น `' .. NameAffterChange..'`',  -- คำอธิบายรายละเอียด (optional)
                fields = {  -- แสดงค่า fields (optional)
                    {  -- filed ฝั่งซ้าย
                        name = 'ชื่อเก่า',  -- title ของ field
                        value = '```ansi\n [2;32m'..NamebeforeChange..'[0m[2;31m[0m```',  -- คำอธิบาย ของ field
                        inline = true  -- แสดง field ให้อยู่บรรทัดเดียวกันหรือไม่
                    },
                    {  -- filed ฝั่งขวา
                        name = 'ชื่อใหม่',  -- title ของ field
                        value = '```ansi\n [2;31m[1;31m'..NameAffterChange..'[0m[2;31m[0m[2;31m[0m```',  -- คำอธิบาย ของ field
                        inline = true  -- แสดง field ให้อยู่บรรทัดเดียวกันหรือไม่
                    }
                },
                imageURL = 'https://wallpapers-clan.com/wp-content/uploads/2022/08/meme-gif-pfp-1.gif',  -- URL รูปภาพที่ต้องการ (optional)
                color = 'ff0000',  -- สีของ Embed (optional) เป็น Hex Code | Default: 'ffffff'
        })
            xPlayer.removeInventoryItem('card_changename', 1)

        end
    end)



end)


ESX.RegisterUsableItem('card_changename', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('John_Changename:cl-OpenUI',source, false)

end)
