-- Constants


-- Auto Chest Utils
local UncheckedChests = {}
local FirstRun = true

local function DistanceFromPlrSort(ObjectList: table)
    local RootPart = PlayerAPI.getCharacter().LowerTorso
    table.sort(ObjectList, function(ChestA, ChestB)
        local RootPos = RootPart.Position
        local DistanceA = (RootPos - ChestA.Position).Magnitude
        local DistanceB = (RootPos - ChestB.Position).Magnitude
        return DistanceA < DistanceB
    end)
end
local function getChestsSorted()
    if FirstRun then
        FirstRun = false
        local Objects = game:GetDescendants()
        for i, Object in pairs(Objects) do
            if Object.Name:find("Chest") and Object.ClassName == "Part" then
                table.insert(UncheckedChests, Object)
            end
        end
    end
    local Chests = {}
    for i, Chest in pairs(UncheckedChests) do
        if Chest:FindFirstChild("TouchInterest") then
            table.insert(Chests, Chest)
        end
    end
    DistanceFromPlrSort(Chests)
    return Chests
end

local function main() -- Run Once
    local CombatController = require(game:GetService("ReplicatedStorage").Controllers.CombatController)
    for i,v in pairs(CombatController) do
        print(i,v)
    end
    print("Main Loaded.")
end
local LoopRan = false
local function mainloop() -- Repeat Constantly
    if Options.ChestAutoFarm then
        local Chests = getChestsSorted()
        if #Chests > 0 then
            TeleportAPI.Teleport(Chests[1].CFrame)
        else
            -- You can put serverhop here
        end
    end
    if Options.AutoAttack then
        local Character = PlayerAPI.getCharacter()
        for i, Tool: Tool in pairs(PlayerAPI.LocalPlayer.Backpack:GetChildren()) do
            if Tool.ToolTip == Options.Weapon then
                Tool.Parent = Character
            end
        end

    end
    if LoopRan ~= true then
        LoopRan = true
        print("Main Loop Working.")
    end
end

wait = task.wait
loadstring(game:HttpGet("https://github.com/ImMejor35/BloxFruits/raw/refs/heads/main/API/APILoader.lua"))()
main()
print("Main Loaded.")
while wait() do mainloop(); end