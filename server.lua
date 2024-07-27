local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

-- Start register 
RegisterServerEvent('wessy_autovote:vote')
AddEventHandler('wessy_autovote:vote', function()
	local _source = source
	local Character = VorpCore.getUser(_source).getUsedCharacter
	local charidentifier = Character.charIdentifier
	local steamidentifier = Character.identifier
	TriggerClientEvent("wessy_autovote:vote", _source, steamidentifier)
end)

RegisterServerEvent('wessy_autovote:claimed')
AddEventHandler('wessy_autovote:claimed', function()
	local _source = source
	VorpCore.NotifyLeft(_source ,"Belohnungs-System","Danke für deinen Vote! Du hast erfolgreich einen Loyalitäts-Token erhalten.","inventory_items_mp","provision_coin_1798_slv_dlr",10000,"COLOR_WHITE")
	VorpInv.addItem(_source, "loyaltytoken", 1)

	local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
	local firstname = Character.firstname or ""
    local lastname = Character.lastname or ""
    local Playername = firstname .. ' ' .. lastname
	print("^3" .. Playername .. "^7 hat erfolgreich gevotet!")
end)
