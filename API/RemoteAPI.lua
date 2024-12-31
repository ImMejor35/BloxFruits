local API = {}

API.Net = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net")

API.Attack = function(target, key)
    API.Net["RE/RegisterAttack"]:FireServer(key)
    API.Net["RE/RegisterHit"]:FireServer(target, {})
    return true
end

return API
