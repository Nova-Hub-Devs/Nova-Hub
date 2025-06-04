local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/memejames/elerium-v2-ui-library//main/Library", true))()

local window = library:AddWindow("Nova Hub | Blox Fruits | Paid Version | by ttvkaiser & FLX_Liam", {
	main_color = Color3.fromRGB(43, 10, 61), -- Color
	min_size = Vector2.new(600, 600), -- Size of the gui
	can_resize = true, -- true or false
})

local Home = window:AddTab("Home")
local Main = window:AddTab("Main")
local Farm = window:AddTab("Farm")
local ESP = window:AddTab("ESP+")
local Teleport = window:AddTab("Teleport")
local Misc = window:AddTab("Misc")
local Stats = window:AddTab("Stats")
local Credits = window:AddTab("Credits")
local Settings = window:AddTab("Settings")

Home:AddLabel("Local Player Configurations")

-- Variable to store walkspeed value
local walkspeedValue = 16 -- default walkspeed

-- TextBox to set walkspeed value
Home:AddTextBox("Enter walkspeed", function(text)
	local number = tonumber(text)
	if number then
		walkspeedValue = number
	end
end)

-- Switch to toggle walkspeed
local walkspeedswitch = Home:AddSwitch("Set Walkspeed", function(enabled)
	local player = game.Players.LocalPlayer
	if player and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
		local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
		if enabled then
			humanoid.WalkSpeed = walkspeedValue
		else
			humanoid.WalkSpeed = 16 -- reset to normal
		end
	end
end)

walkspeedswitch:Set(false)

-- Store jump power value
local jumppowerValue = 50 -- default jump power

-- TextBox to enter jump power
Home:AddTextBox("Enter jumpower", function(text)
	local number = tonumber(text)
	if number then
		jumppowerValue = number
	end
end)

-- Switch to toggle jump power
local jumpowerswitch = Home:AddSwitch("Set Jumpower", function(enabled)
	local player = game.Players.LocalPlayer
	if player and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
		local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
		if enabled then
			humanoid.JumpPower = jumppowerValue
		else
			humanoid.JumpPower = 50 -- reset to normal
		end
	end
end)

jumpowerswitch:Set(false)

local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local infiniteJumpEnabled = false

local infjumpswitch = Home:AddSwitch("Infinite Jumps", function(bool)
	infiniteJumpEnabled = bool
end)
infjumpswitch:Set(false)

-- Listen for jump input
UIS.JumpRequest:Connect(function()
	if infiniteJumpEnabled then
		local character = player.Character
		if character and character:FindFirstChildOfClass("Humanoid") then
			character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local noclipEnabled = false

local noclipswitch = Home:AddSwitch("No Clip", function(bool)
	noclipEnabled = bool
end)
noclipswitch:Set(false)

-- Run every frame to apply no-clip
RunService.Stepped:Connect(function()
	if noclipEnabled and player.Character then
		for _, part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide == true then
				part.CanCollide = false
			end
		end
	end
end)

Main:AddLabel("Configurations")

local selecttooldropdown = Main:AddDropdown("Select one to use for farming", function(text)
	if text == "Mars" then  -- Code
		print("o")
	elseif text == "Earth" then
	print("k")
	elseif text == "Iridocyclitis" then
	print("Weeeee")
	end
end)
local melee = selecttooldropdown:Add("Melee")  -- Options 
local sword = selecttooldropdown:Add("Sword")
local gun = selecttooldropdown:Add("Gun")
local bloxfruits = selecttooldropdown:Add("Blox Fruits")

local fastattackswitch = Main:AddSwitch("Fast Attack", function(bool)
  
end)
fastattackswitch:Set(false)

local fastattackv2switch = Main:AddSwitch("Fast Attack v2", function(bool)
  
end)
fastattackv2switch:Set(false)

local specplayerdropdown = Main:AddDropdown("Select Farm", function(text)
	if text == "Mars" then  -- Code
		print("o")
	elseif text == "Earth" then
	print("k")
	elseif text == "Iridocyclitis" then
	print("Weeeee")
	end
end)
local up = specplayerdropdown:Add("Up & Basic")  -- Options 
local orbit = specplayerdropdown:Add("Orbit")
local side = specplayerdropdown:Add("Side")

local farmwayswitch = Main:AddSwitch("Set Farming Way", function(bool)
  
end)
farmwayswitch:Set(false)

Main:AddLabel("-------------------------------------------------------------------------------------------------")

Main:AddLabel("Spectate Players")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local selectedPlayerName = nil
local spectating = false

-- Dropdown with actual player names
local specplayerdropdown = Main:AddDropdown("Select Player", function(name)
	selectedPlayerName = name
	if spectating then
		local target = Players:FindFirstChild(name)
		if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
			workspace.CurrentCamera.CameraSubject = target.Character.HumanoidRootPart
		end
	end
end)

-- Populate the dropdown with current players
for _, player in ipairs(Players:GetPlayers()) do
	if player ~= LocalPlayer then
		specplayerdropdown:Add(player.Name)
	end
end

-- Update the dropdown when players join/leave
Players.PlayerAdded:Connect(function(player)
	if player ~= LocalPlayer then
		specplayerdropdown:Add(player.Name)
	end
end)

Players.PlayerRemoving:Connect(function(player)
	if player ~= LocalPlayer then
		specplayerdropdown:Remove(player.Name)
	end
end)

-- Switch to spectate
local specplayerswitch = Main:AddSwitch("Spectate Player", function(bool)
	spectating = bool
	if spectating and selectedPlayerName then
		local target = Players:FindFirstChild(selectedPlayerName)
		if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
			workspace.CurrentCamera.CameraSubject = target.Character.HumanoidRootPart
		end
	else
		if LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
			workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
		end
	end
end)
specplayerswitch:Set(false)

Main:AddLabel("-------------------------------------------------------------------------------------------------")

Main:AddLabel("Auto Bounty")

local findplayerdropdown = Main:AddDropdown("Select Player", function(text)
	if text == "Mars" then  -- Code
		print("o")
	elseif text == "Earth" then
	print("k")
	elseif text == "Iridocyclitis" then
	print("Weeeee")
	end
end)
local mars = findplayerdropdown:Add("Mars")  -- Options 
local earth = findplayerdropdown:Add("Earth")
local not_a_planet = findplayerdropdown:Add("Iridocyclitis")

local gotoplayerswitch = Main:AddSwitch("Go to Player", function(bool)
  
end)
gotoplayerswitch:Set(false)

local regulardamageplayerswitch = Main:AddSwitch("Regular Damages Player", function(bool)
  
end)
regulardamageplayerswitch:Set(false)

local fastdamageplayerswitch = Main:AddSwitch("Fast Damages Player", function(bool)
  
end)
fastdamageplayerswitch:Set(false)

Main:AddLabel("-------------------------------------------------------------------------------------------------")

Farm:AddLabel("Auto Farm")

local takequestswitch = Farm:AddSwitch("Auto Take Quest", function(bool)
  
end)
takequestswitch:Set(false)

local autofarmyeswitch = Farm:AddSwitch("Auto Farm (Only Works when Auto Take Quest is enabled)", function(bool)
  
end)
autofarmyeswitch:Set(false)

local autofarmnoswitch = Farm:AddSwitch("Auto Farm (No Quest)", function(bool)
  
end)
autofarmnoswitch:Set(false)

Farm:AddLabel("-------------------------------------------------------------------------------------------------")

Farm:AddLabel("Auto Farm Mastery")

local farmmasterydropdown = Farm:AddDropdown("Choose What to Farm", function(text)
	if text == "Mars" then  -- Code
		print("o")
	elseif text == "Earth" then
	print("k")
	elseif text == "Iridocyclitis" then
	print("Weeeee")
	end
end)
local melee = farmmasterydropdown:Add("Melee")  -- Options 
local sword = farmmasterydropdown:Add("Sword")
local gun = farmmasterydropdown:Add("Gun")
local bloxfruits = farmmasterydropdown:Add("Blox Fruits")

local movesetdropdown = Farm:AddDropdown("What moves to use", function(text)
	if text == "Mars" then  -- Code
		print("o")
	elseif text == "Earth" then
	print("k")
	elseif text == "Iridocyclitis" then
	print("Weeeee")
	end
end)
local z = movesetdropdown:Add("Z")  -- Options 
local x = movesetdropdown:Add("X")
local c = movesetdropdown:Add("C")
local v = movesetdropdown:Add("V")
local f = movesetdropdown:Add("F")

local farmmasteryswitch = Farm:AddSwitch("Farm Mastery (Farms at the best place in current Sea)", function(bool)
  
end)
farmmasteryswitch:Set(false)

local farmnearestswitch = Farm:AddSwitch("Farm Nearest", function(bool)
  
end)
farmnearestswitch:Set(false)

Farm:AddLabel("-------------------------------------------------------------------------------------------------")

Farm:AddLabel("Auto Raids (Second & Third Sea Only!)")

local raidchipsdropdown = Farm:AddDropdown("Choose Raid Chip", function(text)
	if text == "Mars" then  -- Code
		print("o")
	elseif text == "Earth" then
	print("k")
	elseif text == "Iridocyclitis" then
	print("Weeeee")
	end
end)
local flame = raidchipsdropdown:Add("Flame")  -- Options 
local ice = raidchipsdropdown:Add("Ice")
local sand = raidchipsdropdown:Add("Sand")
local dark = raidchipsdropdown:Add("Dark")
local light = raidchipsdropdown:Add("Light")
local magma = raidchipsdropdown:Add("Magma")
local quake = raidchipsdropdown:Add("Quake")
local buddha = raidchipsdropdown:Add("Buddha")
local spider = raidchipsdropdown:Add("Spider")
local rumble = raidchipsdropdown:Add("Rumble")
local phoenix = raidchipsdropdown:Add("Phoenix")
local dough = raidchipsdropdown:Add("Dough")

local buychipswitch = Farm:AddSwitch("Buy Raid Chip", function(bool)
  
end)
buychipswitch:Set(false)

local autobuychipswitch = Farm:AddSwitch("Auto Buy Chip", function(bool)
  
end)
autobuychipswitch:Set(false)

local autofarmraidswitch = Farm:AddSwitch("Auto Farm Raid", function(bool)
  
end)
autofarmraidswitch:Set(false)

-- Gameplay Enhancers
Misc:AddLabel("Gameplay Enhancers")

Misc:AddButton("Teleport to Random Sea Beast", function()
    local beasts = {}
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v.Name:lower():find("sea beast") then
            table.insert(beasts, v)
        end
    end
    if #beasts > 0 then
        local chosen = beasts[math.random(1, #beasts)]
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = chosen.PrimaryPart.CFrame + Vector3.new(0, 10, 0)
    end
end)

Misc:AddButton("Rejoin Server", function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

Misc:AddButton("Teleport to Nearest NPC", function()
    local character = game.Players.LocalPlayer.Character
    local closestNPC, shortest = nil, math.huge

    for _, npc in pairs(workspace:GetDescendants()) do
        if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
            local dist = (npc.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
            if dist < shortest then
                shortest = dist
                closestNPC = npc
            end
        end
    end

    if closestNPC then
        character.HumanoidRootPart.CFrame = closestNPC.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
    end
end)

local killauraswitch = Misc:AddSwitch("Kill Aura (NPCs)", function(bool)
    _G.KillAura = bool
    while _G.KillAura do
        task.wait(0.3)
        for _, npc in pairs(workspace:GetDescendants()) do
            if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
                if (npc.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 20 then
                    game:GetService("ReplicatedStorage").Remotes.Damage:FireServer(npc)
                end
            end
        end
    end
end)
killauraswitch:Set(false)

Misc:AddTextBox("Dash Speed Modifier", function(text)
    local speed = tonumber(text)
    if speed then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = speed
        end
    end
end)

-- Inventory & Items
Misc:AddLabel("Inventory & Items")

local autostore = Misc:AddSwitch("Auto Store Fruits", function(bool)
    _G.AutoStoreFruits = bool
    while _G.AutoStoreFruits do
        task.wait(5)
        for _, fruit in pairs(workspace:GetChildren()) do
            if fruit:IsA("Tool") and fruit.Name:lower():find("fruit") then
                game:GetService("ReplicatedStorage").Remotes.StoreFruit:InvokeServer(fruit)
            end
        end
    end
end)
autostore:Set(false)

local fruitnotify = Misc:AddSwitch("Fruit Notifier", function(bool)
    _G.FruitNotify = bool
    while _G.FruitNotify do
        task.wait(5)
        for _, fruit in pairs(workspace:GetChildren()) do
            if fruit:IsA("Tool") and fruit.Name:lower():find("fruit") then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Fruit Detected!",
                    Text = fruit.Name,
                    Duration = 5
                })
            end
        end
    end
end)
fruitnotify:Set(false)

Misc:AddButton("Open All Chests Nearby", function()
    for _, chest in pairs(workspace:GetDescendants()) do
        if chest:IsA("Model") and chest.Name:lower():find("chest") then
            if chest:FindFirstChild("Open") then
                fireclickdetector(chest.Open.ClickDetector)
            end
        end
    end
end)

local autoswap = Misc:AddSwitch("Auto Swap to Best Weapon", function(bool)
    _G.AutoBestWeapon = bool
    while _G.AutoBestWeapon do
        task.wait(3)
        local best = nil
        local damage = 0
        for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("Damage") then
                if tool.Damage.Value > damage then
                    damage = tool.Damage.Value
                    best = tool
                end
            end
        end
        if best then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(best)
        end
    end
end)
autoswap:Set(false)

-- Player Mods
Misc:AddLabel("Player Mods")

local flytoggle = Misc:AddSwitch("Sit / Float / Fly", function(bool)
    if bool then
        local player = game.Players.LocalPlayer
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local bv = Instance.new("BodyVelocity", hrp)
            bv.Velocity = Vector3.new(0, 50, 0)
            bv.MaxForce = Vector3.new(0, math.huge, 0)
            bv.Name = "FloatForce"
        end
    else
        local float = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("FloatForce")
        if float then
            float:Destroy()
        end
    end
end)
flytoggle:Set(false)

Misc:AddTextBox("Custom Title Editor", function(text)
    local player = game.Players.LocalPlayer
    if player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("HUD") then
        local title = player.PlayerGui.HUD:FindFirstChild("TitleLabel")
        if title then
            title.Text = text
        end
    end
end)

Misc:AddSlider("WalkSpeed", {
    min = 16,
    max = 200,
    default = 16
}, function(val)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val
end)

Misc:AddSlider("JumpPower", {
    min = 50,
    max = 200,
    default = 50
}, function(val)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = val
end)

Misc:AddButton("Reset Character", function()
    game.Players.LocalPlayer.Character:BreakJoints()
end)

-- Chat & Fun
Misc:AddLabel("Chat & Fun")

Misc:AddTextBox("Auto Chat Spam", function(text)
    _G.ChatSpam = true
    while _G.ChatSpam do
        wait(2)
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(text, "All")
    end
end)

local fakechat = Misc:AddSwitch("Fake Chat", function(bool)
    if bool then
        print("Fake Chat Enabled") -- Placeholder for fake chat injection
    else
        print("Fake Chat Disabled")
    end
end)
fakechat:Set(false)

Misc:AddButton("Rickroll Everyone", function()
    for _, player in pairs(game.Players:GetPlayers()) do
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
            player.Name .. " is now listening to Never Gonna Give You Up! 🎵",
            "All"
        )
    end
end)

Farm:AddLabel("-------------------------------------------------------------------------------------------------")

-- Time Stats
Stats:AddLabel("Time Played:")
local dLabel = Stats:AddLabel("Days: 0")
local hLabel = Stats:AddLabel("Hours: 0")
local mLabel = Stats:AddLabel("Minutes: 0")
local sLabel = Stats:AddLabel("Seconds: 0")

-- Session Stats
Stats:AddLabel("Session Stats:")
local sessionMoneyLabel = Stats:AddLabel("Money Earned: $0")
local sessionBountyLabel = Stats:AddLabel("Bounty Earned: 0")

-- Overall Stats
Stats:AddLabel("Overall Stats:")
local totalMoneyLabel = Stats:AddLabel("Total Money: $0")
local totalBountyLabel = Stats:AddLabel("Total Bounty: 0")

-- Variables for tracking
local seconds = 0
local sessionMoney = 0
local sessionBounty = 0
local totalMoney = 1000000 -- Replace with saved total if needed
local totalBounty = 50000  -- Replace with saved total if needed

-- Time & Stats Update Loop
task.spawn(function()
	while true do
		task.wait(1)
		seconds += 1
		local mins = math.floor(seconds / 60)
		local hrs = math.floor(mins / 60)
		local days = math.floor(hrs / 24)

		dLabel:Set("Days: " .. days)
		hLabel:Set("Hours: " .. (hrs % 24))
		mLabel:Set("Minutes: " .. (mins % 60))
		sLabel:Set("Seconds: " .. (seconds % 60))

		-- Example simulation of earned money and bounty
		sessionMoney += math.random(100, 1000)
		sessionBounty += math.random(5, 20)

		totalMoney += sessionMoney
		totalBounty += sessionBounty

		sessionMoneyLabel:Set("Money Earned: $" .. sessionMoney)
		sessionBountyLabel:Set("Bounty Earned: " .. sessionBounty)

		totalMoneyLabel:Set("Total Money: $" .. totalMoney)
		totalBountyLabel:Set("Total Bounty: " .. totalBounty)
	end
end)

Credits:AddLabel("Nova Hub was proudly created by:")
Credits:AddLabel("ttvkaiser (Lead Developer & Visionary)")
Credits:AddLabel("FLX_Liam (Core Developer & Systems Architect)")
Credits:AddLabel("")
Credits:AddLabel("After the unfortunate takedown of Dragon Hub,")
Credits:AddLabel("we decided to rise from the ashes and start fresh.")
Credits:AddLabel("Nova Hub was born from the passion and effort")
Credits:AddLabel("of two dedicated developers who didn’t give up.")
Credits:AddLabel("")
Credits:AddLabel("We’re incredibly proud of what we’ve built.")
Credits:AddLabel("This new journey is only the beginning.")
Credits:AddLabel("Thank you to everyone supporting Nova Hub.")
Credits:AddLabel("More updates and features are coming soon!")

Settings:AddLabel("General Configurations")

-- Auto Reconnect (Rejoin if disconnected or kicked to menu)
local autoreconnectswitch = Settings:AddSwitch("Auto Reconnect", function(bool)
    getgenv().AutoReconnect = bool
end)
autoreconnectswitch:Set(false)

Settings:AddButton("Auto Hop Servers", function()
    local TPS = game:GetService("TeleportService")
    local PlaceID = game.PlaceId
    TPS:Teleport(PlaceID, game.Players.LocalPlayer)
end)

Settings:AddLabel("Performance Enhancers")

Settings:AddButton("FPS Booster", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") then
                    v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("Decal") then
            v.Transparency = 1
        end
    end
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)

Settings:AddButton("Auto Graphics", function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
end)

Settings:AddButton("Anti Lag Mode", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        elseif v:IsA("Explosion") then
            v.Visible = false
        end
    end
    game:GetService("Lighting").FogEnd = 1000000
end)

Settings:AddLabel("Safety Settings")

Settings:AddButton("Anti AFK", function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end)

-- Kick if a mod joins
local kickonmodswitch = Settings:AddSwitch("Auto Kicks you when mod Joins", function(bool)
    getgenv().KickOnModJoin = bool
end)
kickonmodswitch:Set(false)

-- Auto leave if suspicious user or keywords are found
local autoleaveswitch = Settings:AddSwitch("Auto Leaves When Danger Detected", function(bool)
    getgenv().AutoLeaveDanger = bool
end)
autoleaveswitch:Set(false)

-- Monitor players for mod names (sample detection logic)
game.Players.PlayerAdded:Connect(function(player)
    if getgenv().KickOnModJoin or getgenv().AutoLeaveDanger then
        local name = player.Name:lower()
        local displayName = player.DisplayName:lower()
        local suspiciousKeywords = { "mod", "admin", "staff", "dev", "moderator" }

        for _, keyword in ipairs(suspiciousKeywords) do
            if name:find(keyword) or displayName:find(keyword) then
                if getgenv().KickOnModJoin then
                    game.Players.LocalPlayer:Kick("Moderator joined. Auto-kicked.")
                elseif getgenv().AutoLeaveDanger then
                    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
                end
            end
        end
    end
end)

Settings:AddLabel("Script")
Settings:AddLabel("Current Version: v.2.0.8")
