local PlayerAPI = loadstring(game:HttpGet("https://raw.github.com/ImMejor35/BloxFruits/refs/heads/main/PlayerAPI.lua"))()

local function toggleNoclip(Toggle: boolean)
    for i,v in pairs(PlayerAPI.getCharacter():GetChildren()) do
        if v.ClassName == "Part" then
            v.CanCollide = not Toggle
        end
    end
end

local API = {}
API.DefaultSpeed = 300
local function Teleport(Goal: CFrame, Speed)
    if not Speed then
        Speed = API.DefaultSpeed
    end
    toggleNoclip(true)
    local RootPart = PlayerAPI.getCharacter().HumanoidRootPart
    local Magnitude = (RootPart.Position - Goal.Position).Magnitude

    RootPart.CFrame = RootPart.CFrame
    
    while not (Magnitude < 1) do
        local Direction = (Goal.Position - RootPart.Position).unit
        RootPart.CFrame = RootPart.CFrame + Direction * (Speed * wait())
        Magnitude = (RootPart.Position - Goal.Position).Magnitude
    end
    toggleNoclip(false)
end
API.Teleport = Teleport

wait = task.wait
return API
