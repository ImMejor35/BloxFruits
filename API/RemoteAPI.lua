local API = {}

API.RunService = game:GetService("RunService")
API.ReplicatedStorage = game:GetService("ReplicatedStorage")
API.VirtualUser = game:GetService("VirtualUser")

API.CombatFramework = require(PlayerAPI.LocalPlayer.PlayerScripts.CombatFramework)
API.CameraShaker = require(game:GetService("ReplicatedStorage"))

getgenv().Attack = false
API.ToggleAttack = function()
    Attack = not Attack
    return Attack
end
getgenv().FastAttack = false
API.RunService.RenderStepped:Connect(function()
    if FastAttack then
        local ActiveController = API.CombatFramework.activeController
        ActiveController.attacking = false
        ActiveController.blocking = false
        ActiveController.timeToNextAttack = tick() - 1
        ActiveController.timeToNextBlock = 0
        ActiveController.increment = 3
        ActiveController.hitboxMagnitude = 120
        PlayerAPI.getCharacter().Stun.Value = 0
        PlayerAPI.getCharacter().Humanoid.Sit = false
    end
    if Attack then
        API.VirtualUser:CaptureController()
        API.VirtualUser:Button1Down(Vector2.new(1280, 672))
        API.CameraShaker:Stop()
    end
end)

API.ToggleFastAttack = function()
    FastAttack = not FastAttack
    return FastAttack
end

return API
