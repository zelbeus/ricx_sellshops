data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

local TEXTS = Config.Texts

RegisterServerEvent('ricx_shopsell:sell')
AddEventHandler('ricx_shopsell:sell', function(label, name, price)
    local _source = source

    local _itemname = tostring(name)
    local _price = tonumber(price)

    local itemData = data.getItem(_source, _itemname)
    local ItemInfo = data.getItemData(_itemname)

    local count = itemData.ItemAmount
    local _label = tostring(label) or ItemInfo.label

    local sellprice 

    if count == nil then
        TriggerClientEvent("Notification:left_sellshop", _source, TEXTS.NotifTitle, TEXTS.DontHave.." ".._label.." "..TEXTS.ToSell, 'menu_textures', 'stamp_locked_rank', 2000)
        return
    end
    if count >= 1 then
        TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
            itemData.RemoveItem(count)
            sellprice = _price*count
            user.addMoney(sellprice)
        end)
        TriggerClientEvent("Notification:left_sellshop", _source, TEXTS.NotifTitle, TEXTS.YouSold.." ".._label.." ("..count..")".."\n~COLOR_GOLD~+$"..sellprice, "scoretimer_textures", "scoretimer_generic_tick", 2000)
    else
        TriggerClientEvent("Notification:left_sellshop", _source, TEXTS.NotifTitle, TEXTS.DontHave.." ".._label.." "..TEXTS.ToSell, 'menu_textures', 'stamp_locked_rank', 2000)
    end
end)