local Yung = loadstring(game:HttpGet("https://raw.githubusercontent.com/Lior4410/techoko.cc/main/sourcev2.lua"))()
local Circle2222 = Yung:New3DCircle()
Circle2222.Visible = false
Circle2222.ZIndex = 1
Circle2222.Transparency = 1
Circle2222.Color = Color3.fromRGB(299, 214, 209)
Circle2222.Thickness = 1
--// tables
local aiming = {
    targetaim = {
        enabled = false,
        targeting = false,
        view = false,
        chat = false,
        win11 = false,
        autoshoot = false,
        autoprediction = false,
        key = Enum.KeyCode.Q,
        prediction = 0.13,
        hitpart = "LowerTorso"
    },
    tracers = {
        enabled = false,
        showprediction = false,
        rainbow = false,
        colour = Color3.fromRGB(255, 255, 255),
        from = "Penis",
        RainbowFov = false
    },
    orbit = {
        enabled = false,
        visualization = false,
        vc = Color3.fromRGB(255, 255, 255),
        speed = 2,
        distance = 10
    },
    visualization = {
        part = false,
        circle = false,
        mode = "Part",
        partcolour = Color3.fromRGB(255, 255, 255),
        circlecolour = Color3.fromRGB(255, 255, 255)
    },
    fov = {
        enabled = false,
        filled = false,
        thickness = 2,
        sides = 350,
        radius = 50,
        colour = Color3.fromRGB(255, 255, 255),
        option = "Circle"
    },
    od = {
        unlockko = false,
        tpko = false,
        stompko = false,
        stomptime = 3
    }
}

local CurrentCamera = game:GetService("Workspace").CurrentCamera
local LocalMouse = game.Players.LocalPlayer:GetMouse()

local circle = Drawing.new("Circle")
circle.Color = Color3.fromRGB(255, 255, 255)
circle.Thickness = 2
circle.NumSides = 350
circle.Transparency = 0.6
circle.Radius = 70
circle.Visible = false
circle.Filled = false

local circlev = Drawing.new("Circle")
circlev.Color = Color3.fromRGB(255, 255, 255)
circlev.Thickness = 2
circlev.NumSides = 350
circlev.Transparency = 0.6
circlev.Radius = 50
circlev.Visible = false
circlev.Filled = false

local line = Drawing.new("Line")
line.Visible = false
line.From = Vector2.new(0, 0)
line.To = Vector2.new(200, 200)
_G.SpecterL = Color3.fromRGB(255, 255, 255)
line.Color = _G.SpecterL
line.Thickness = 1.26
line.Transparency = 1.

-- not mine lol
function getClosestPlayerToCursor()
    local ClosestDistance, ClosestPlayer = math.huge, nil
    for _, Player in next, game:GetService("Players"):GetPlayers() do
        local ISNTKNOCKED = Player.Character:WaitForChild("BodyEffects")["K.O"].Value ~= true
        local ISNTGRABBED = Player.Character:FindFirstChild("GRABBING_COINSTRAINT") == nil

        if Player ~= game.Players.LocalPlayer then
            local Character = Player.Character
            if Character and Character.Humanoid.Health > 1 and ISNTKNOCKED and ISNTGRABBED then
                local Position, IsVisibleOnViewPort =
                    CurrentCamera:WorldToViewportPoint(Character.HumanoidRootPart.Position)
                if IsVisibleOnViewPort then
                    local Distance =
                        (Vector2.new(LocalMouse.X, LocalMouse.Y) - Vector2.new(Position.X, Position.Y)).Magnitude
                    if Distance < ClosestDistance then
                        ClosestPlayer = Player
                        ClosestDistance = Distance
                    end
                end
            end
        end
    end
    return ClosestPlayer, ClosestDistance
end

game:GetService("UserInputService").InputBegan:Connect(
    function(keyinput, stupid)
        if keyinput.KeyCode == aiming.targetaim.key then
            aiming.targetaim.targeting = not aiming.targetaim.targeting
            if aiming.targetaim.targeting then
                target = getClosestPlayerToCursor()
                targetplr = tostring(target)

                if aiming.targetaim.chat == true then
                    local args = {
                        [1] = "Targeting " .. tostring(targetplr),
                        [2] = "All"
                    }

                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        unpack(args)
                    )
                end

                if aiming.targetaim.view == true then
                    if game.Players[targetplr].Character:FindFirstChild("Humanoid") then
                        CurrentCamera.CameraSubject = game.Players[targetplr].Character.Humanoid
                    end
                end

                if aiming.targetaim.win11 == true then
                    local win11locked = Instance.new("Sound")
                    win11locked.Name = "q"
                    win11locked.Volume = aiming.targetaim.win11volume
                    win11locked.SoundId = "rbxassetid://11334614655"
                    win11locked.Parent = game:GetService("SoundService")
                    win11locked.Playing = true
                end

                if targetplr ~= nil and aiming.visualization.mode == "Part" then
                    local ipar = Instance.new("Part", game.Workspace)
                    ipar.Name = "uwu"
                    ipar.Anchored = true
                    ipar.CanCollide = false
                    ipar.Transparency = 0
                    ipar.Parent = game.Workspace
                    ipar.Shape = Enum.PartType.Ball
                    ipar.Size = Vector3.new(3,4, 4)
                    ipar.Color = Color3.fromRGB(2141, 133, 465)
                    ipar.Material = "Neon"
                    spawn(
                        function()
                            game:GetService("RunService").Stepped:Connect(
                                function()
                                    ipar.Position =
                                        game.Players[targetplr].Character.HumanoidRootPart.Position +
                                        (game.Players[targetplr].Character.LowerTorso.Velocity *
                                            aiming.targetaim.prediction)
                                end
                            )
                        end
                    )
                end

                if aiming.tracers.rainbow == true then 
                    spawn(function()
                    for i = 0, 1, 0.001 do
                        line.Color = Color3.fromHSV(i, 1, 1)
                        task.wait()
                    end
                    end)
                end 



                if aiming.orbit.enabled == true then
                    spawn(
                        function()
                            repeat
                                task.wait()

                                for i = 0, 360, aiming.orbit.speed do
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                        CFrame.new(game.Players[targetplr].Character.HumanoidRootPart.Position) *
                                        CFrame.Angles(0, math.rad(i), 0) *
                                        CFrame.new(aiming.orbit.distance, 0, 0)
                                    task.wait()
                                end
                            until game.Players[targetplr].Character.Humanoid.health < 1 or aiming.orbit.enabled == false or
                                aiming.targetaim.targeting == false
                        end
                    )
                end
            elseif not aiming.targetaim.targeting then
                if aiming.targetaim.chat == true then
                    local args = {
                        [1] = "Untargeting " .. tostring(targetplr),
                        [2] = "All"
                    }

                    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(
                        unpack(args)
                    )
                end

                if aiming.targetaim.view == true then
                    CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
                end

                if aiming.visualization.mode == "Part" then
                    local vvv = game:GetService("Workspace").uwu
                    vvv:Destroy()
                end

                if aiming.targetaim.win11 == true then
                    local win11unlocked = Instance.new("Sound")
                    win11unlocked.Name = "Penis"
                    win11unlocked.Volume = aiming.targetaim.win11volume
                    win11unlocked.SoundId = "rbxassetid://11334615503"
                    win11unlocked.Parent = game:GetService("SoundService")
                    win11unlocked.Playing = true
                end
            end
        end
    end
)
getgenv().SilentKeyy = 'q'
getgenv().PredictionAmmount = 0.137
--// Service Handler \\--
local GetService = setmetatable({}, {
    __index = function(self, key)
        return game:GetService(key)
    end
})
--// Services \\--
local RunService = GetService.RunService
local Players = GetService.Players
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CurrentCamera = workspace.CurrentCamera
local UserInputService = GetService.UserInputService
local Unpack = table.unpack
local GuiInset = GetService.GuiService:GetGuiInset()
local Insert = table.insert
local Network = GetService.NetworkClient
local StarterGui = GetService.StarterGui
local tweenService = GetService.TweenService
local ReplicatedStorage = GetService.ReplicatedStorage
local http = GetService.HttpService
local lighting = GetService.Lighting


--// Start \\--
local PuppySettings = {
    SilentAim = {
        Enabled = false,
        UseFOV = false,
        ShowFOV = false,
        FOVColor = Color3.new(0.603921, 0.011764, 1),
		DOTColor = Color3.fromRGB(0, 71, 212),
        WallCheck = false,
        KnockedCheck = false,
		PingPred1 = false,
		PingPred2 = false,
        GrabbedCheck = false,
        ShowHitbox = false,
        NotificationMode = false,
        AirShotMode = false,
        UseNearestDistance = false,
		RandomHitbox = false,
        Hitboxes = "HumanoidRootPart",
		Selected = nil
    },
    SilentAimSettings = {
        MovementPrediction = false,
        MovementPredictionAmount = getgenv().PredictionAmmount,
        HitChance = false,
        HitChanceAmount = {
            HitPercent = 100,
            NotHitPercent = 0
        }
    },
	Aimbot = {
		Enabled = false,
		Prediction = false,
		Hitboxes = "HumanoidRootPart"
	},
    AimbotSettings = {
		Mode = "Camera",
		Smoothness = false,
		SmoothnessAmmount = 0.0334,
		PredictionVelocity = 10
    },
	AntiAim = {
		Enabled = false,
		Desync = false,
		Legit = false,
		FPSUnlocked = false,
		LegitAAKey = Enum.KeyCode.Z,
		DesyncValues = {
			Velocity = -100,
			CFrame = -100
		}
	},
	BackTracking = {
		Enabled = false
	},
	AutoPeak = {
		Enabled = false,
		APKey = Enum.KeyCode.N,
	},
	AutoClicker = {
		Enabled = false,
		Keybind = Enum.KeyCode.B
	},
	Misc = {
	CFrameSpeed = {
		Enabled = false,
		Bhop = false,
		Keybind = Enum.KeyCode.V,
		Speed = 1,
	},
	Strafe = false,
	Antislow = false,
	},
    FOV = {
        FOVFilled = false,
        Transparency = 9,
        SilentAimSize = 100,
        Thickness = 2
    },
	Esp = {
		Enabled = false,
		Bones = false,
	},
	TriggerBot = {
        Enabled = false,
		DelayAmount = 0
    },
    TargetGui = {
        Enabled = false
    },
    Whitelist = {
        Players = {},
        Friends = {},
        Holder = "",
        Enabled = false,
        CrewEnabled = false,
        FriendsWhitelist = false
    },
}
local PuppyStorage = {
    GetStrafeAngle = 0,
    BHoping = false,
    Side = "Right",
    StoredRange = 10,
    HeldSpace = false,
    GetPrediction = 0.165,
    Instance = {},
    Equipable = false,
    FPSBeat = 0,
    GetTime = 0,
    Macro = false
}
local PuppyModule = {
    Instance = {}
}
local SilentAimFOV = Drawing.new("Circle")
SilentAimFOV.Thickness = 2

--//Auto Clicker
getgenv().Clicking = false
game:service('UserInputService').InputBegan:connect(function(Key, IsChat)
	if IsChat then return end 
	if Key.KeyCode == PuppySettings.AutoClicker.Keybind and PuppySettings.AutoClicker.Enabled == true then
		getgenv().Clicking = not getgenv().Clicking
	end
end)

--// Legit AA
getgenv().LegitAA = false
getgenv().CFSpeed = false

game:service('UserInputService').InputBegan:connect(function(Key, IsChat)
	if IsChat then return end
	if Key.KeyCode == PuppySettings.AntiAim.LegitAAKey and PuppySettings.AntiAim.Legit == true and PuppySettings.AntiAim.Enabled == true then
		getgenv().LegitAA = not getgenv().LegitAA
	end
end)

game:service('UserInputService').InputBegan:connect(function(Key, IsChat)
	if IsChat then return end
	if Key.KeyCode == PuppySettings.Misc.CFrameSpeed.Keybind and PuppySettings.Misc.CFrameSpeed.Enabled == true then
		getgenv().CFSpeed = not getgenv().CFSpeed
	end
end)
    
function Find(Data)
   getgenv().Target = nil
    for i, v in next, Players:GetPlayers() do
        if v.Name ~= LocalPlayer.Name and v.Name:lower():match('^'.. NoSpace(Data):lower()) then
            getgenv().Target = v.Name
        end
    end
    
    return getgenv().Target
end

function IsNetwork(GetPlayer)
	return GetPlayer and GetPlayer.Character and GetPlayer.Character:FindFirstChild("HumanoidRootPart") ~= nil and GetPlayer.Character:FindFirstChild("Humanoid") ~= nil and GetPlayer.Character:FindFirstChild("Head") ~= nil and true or false
end

function Knocked(GetPlayer)
    if IsNetwork(GetPlayer) then
        return GetPlayer.Character.BodyEffects["K.O"].Value and true or false
    end
    return false
end

function Grabbing(GetPlayer)
    if IsNetwork(GetPlayer) then
        return GetPlayer.Character:FindFirstChild("GRABBING_CONSTRAINT") and true or false
    end
    return false
end

function Alive(Player)
    if Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") ~= nil and Player.Character:FindFirstChild("Humanoid") ~= nil and Player.Character:FindFirstChild("Head") ~= nil then
        return true
    end
    return false
end

function CameraCheck(GetPosition, IgnoredList)
    if IsNetwork(LocalPlayer) then
        return #CurrentCamera:GetPartsObscuringTarget({LocalPlayer.Character.Head.Position, GetPosition}, IgnoredList) == 0 and true or false
    end
end

function WallCheck(OriginPart, Part)
    if IsNetwork(LocalPlayer) then
        local IgnoreList = {CurrentCamera, LocalPlayer.Character, OriginPart.Parent}
        local Parts = CurrentCamera:GetPartsObscuringTarget(
            {
                OriginPart.Position, 
                Part.Position
            },
            IgnoreList
        )
    
        for i, v in pairs(Parts) do
            if v.Transparency >= 0.3 then
                PuppyStorage.Instance[#PuppyStorage.Instance + 1] = v
            end
    
            if v.Material == Enum.Material.Glass then
                PuppyStorage.Instance[#PuppyStorage.Instance + 1] = v
            end
        end
    
        return #Parts == 0
    end
    return true
end

function NilBody()
    if Alive(LocalPlayer) then
        for i, v in pairs(LocalPlayer.Character:GetChildren()) do
            if v:IsA("BasePart") or v:IsA("Part") or v:IsA("MeshPart") then
                if v.Name ~= "HumanoidRootPart" then
                    v:Destroy()
                end
            end
        end
    end
end

function NearestDistance()
    local Target = nil
    local Distance = math.huge
    for i, v in next, Players:GetPlayers() do
        if v ~= LocalPlayer and Alive(LocalPlayer) and Alive(v) then
            local DistanceFromPlayer = (v.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if Distance > DistanceFromPlayer then
                if (not PuppySettings.Whitelist.FriendsWhitelist or not table.find(PuppySettings.Whitelist.Friends, v.Name)) and (not PuppySettings.Whitelist.CrewEnabled or v:FindFirstChild("DataFolder") and v.DataFolder.Information:FindFirstChild("Crew") and not tonumber(v.DataFolder.Information.Crew.Value) == tonumber(LocalPlayer.DataFolder.Information.Crew.Value)) and (not PuppySettings.Whitelist.Enabled or not table.find(PuppySettings.Whitelist.Players, v.Name)) and (not PuppySettings.SilentAim.WallCheck or WallCheck(v.Character.HumanoidRootPart, LocalPlayer.Character.HumanoidRootPart)) then
                    Target = v
                    Distance = DistanceFromPlayer
                end
            end
        end
    end

    return Target, Distance
end

function NearestMouse()
    local Target = nil
    local Distance = math.huge
    for i, v in next, Players:GetPlayers() do
        if v ~= LocalPlayer and Alive(LocalPlayer) and Alive(v) then
            local RootPosition, RootVisible = CurrentCamera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            local DistanceFromMouse = (Vector2.new(RootPosition.X, RootPosition.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
            if RootVisible and Distance > DistanceFromMouse then
                if (not PuppySettings.Whitelist.FriendsWhitelist or not table.find(PuppySettings.Whitelist.Friends, v.Name)) and (not PuppySettings.Whitelist.CrewEnabled or v:FindFirstChild("DataFolder") and v.DataFolder.Information:FindFirstChild("Crew") and not tonumber(v.DataFolder.Information.Crew.Value) == tonumber(LocalPlayer.DataFolder.Information.Crew.Value)) and (not PuppySettings.Whitelist.Enabled or not table.find(PuppySettings.Whitelist.Players, v.Name)) and (not PuppySettings.SilentAim.WallCheck or WallCheck(v.Character.HumanoidRootPart, LocalPlayer.Character.HumanoidRootPart)) then
                    Target = v
                    Distance = DistanceFromMouse
                end
            end
        end
    end

    return Target, Distance
end

function NearestType(Type)
    if Type == "Distance" then
        return NearestDistance()
    elseif Type == "Mouse" then
        return NearestMouse()
    end
end

function ChanceTable(Table)
    local Chance = 0
    for i, v in pairs(Table) do
        Chance = Chance + v
    end
    Chance = math.random(0, Chance)
    for i, v in pairs(Table) do
        Chance = Chance - v
        if Chance <= 0 then
            return i
        end
    end	
end

function RandomTable(Table)
    local Values = 0
    for i, v in pairs(Table) do
        Values = i
    end
    
    return Table[math.random(1, Values)]
end

local Plr
local Pos
local enabled = false
local placemarker = Instance.new("Part", game.Workspace)

function makemarker(Parent, Adornee, Color, Size, Size2)
    local e = Instance.new("BillboardGui", Parent)
    e.Name = "PP"
    e.Adornee = Adornee
    e.Size = UDim2.new(Size, Size2, Size, Size2)
    e.AlwaysOnTop = true
    local a = Instance.new("Frame", e)
    a.Size = UDim2.new(1, 0, 1, 0)
    a.Transparency = 0
    a.BackgroundTransparency = 0
    a.BackgroundColor3 = Color
    local g = Instance.new("UICorner", a)
    g.CornerRadius = UDim.new(50, 50)
    return(e)
end

spawn(function()
    placemarker.Anchored = true
    placemarker.CanCollide = false
    placemarker.Size = Vector3.new(8, 8, 8)
    placemarker.Transparency = 0.79
    makemarker(placemarker, placemarker, PuppySettings.SilentAim.DOTColor, 0.40, 0)
end)    

getgenv().islocked = false
Mouse.KeyDown:connect(function(key)
    if key:lower() == getgenv().SilentKeyy then 
        if getgenv().islocked == false and PuppySettings.SilentAim.Enabled and PuppySettings.SilentAim.UseFOV == false then
            if enabled == true then
            else
                enabled = true
            end
            getgenv().islocked = true
            if PuppySettings.SilentAim.UseNearestDistance then
				local NearestTarget, NearestPos = NearestDistance()
				if NearestTarget and (not PuppySettings.SilentAim.UseFOV or PuppySettings.FOV.SilentAimSize > NearestPos) and (not PuppySettings.SilentAim.KnockedCheck or not Knocked(NearestTarget)) and (not PuppySettings.SilentAim.grabbedCheck or not Grabbed(NearestTarget)) and (not PuppySettings.SilentAim.WallCheck or WallCheck(NearestTarget.Character.HumanoidRootPart, LocalPlayer.Character.HumanoidRootPart)) then
                Plr = NearestDistance()
                Pos = NearestPos
				end
            else
				local NearestTarget, NearestPos = NearestMouse()
				if NearestTarget and (not PuppySettings.SilentAim.UseFOV or PuppySettings.FOV.SilentAimSize > NearestPos) and (not PuppySettings.SilentAim.KnockedCheck or not Knocked(NearestTarget)) and (not PuppySettings.SilentAim.grabbedCheck or not Grabbed(NearestTarget)) and (not PuppySettings.SilentAim.WallCheck or WallCheck(NearestTarget.Character.HumanoidRootPart, LocalPlayer.Character.HumanoidRootPart)) then
                Plr = NearestMouse()
                Pos = NearestPos
				end
            end
            if PuppySettings.SilentAim.NotificationMode and Plr ~= game.Players.LocalPlayer then
                Notify({
                    Title = "Puppyware",
                    Description = "Locked Onto: "..Plr.DisplayName,
                    Duration = 3
                })
            end
        elseif getgenv().islocked == true and PuppySettings.SilentAim.Enabled then
            getgenv().islocked = false
            enabled = false
			Plr = game.Players.LocalPlayer
            if PuppySettings.SilentAim.NotificationMode then
                Notify({
                    Title = "Puppyware",
                    Description = "Unlocked",
                    Duration = 3
                })
            end
        end
    end
end)

--//Random Hitbox
local PuppyHitboxes = {
	"Head","UpperTorso","LowerTorso"
}

game:GetService("RunService").Heartbeat:Connect(function()
	if PuppySettings.AntiAim.Enabled == true and PuppySettings.AntiAim.Desync == true then
		game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector * PuppySettings.AntiAim.DesyncValues.Velocity
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(PuppySettings.AntiAim.DesyncValues.CFrame), 0)
	end -- Anti Aim Desync
	if PuppySettings.Misc.Antislow then
	    getgenv().DeletePart = game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild('NoJumping') or player.Character.BodyEffects.Movement:FindFirstChild('ReduceWalk') or player.Character.BodyEffects.Movement:FindFirstChild('NoWalkSpeed')
		if getgenv().DeletePart then getgenv().DeletePart:Destroy() end
		if game.Players.LocalPlayer.Character.BodyEffects.Reload.Value == true then game.Players.LocalPlayer.Character.BodyEffects.Reload.Value = false end
	end -- Anti Slow
	if PuppySettings.Misc.CFrameSpeed.Bhop and LocalPlayer.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
		LocalPlayer.Character.Humanoid:ChangeState("Jumping")
	end -- Bhop
	if PuppySettings.Misc.Strafe then
		if LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 and LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
			LocalPlayer.Character:TranslateBy(LocalPlaping.Character.Humanoid.MoveDirection / 3.1)
		end
	end -- Strafe
	if PuppySettings.SilentAimSettings.PingPred1 and PuppySettings.SilentAim.Enabled then
		getgenv().ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
		getgenv().Value = tostring(getgenv().ping)
		getgenv().pingValue = getgenv().Value:split(" ")
		local PingNumber = getgenv().pingValue[1]
		getgenv().PredictionAmmount = PingNumber / 1000 + getgenv().Prediction
		print(getgenv().PredictionAmmount)
	end -- Ping Prediction 1
	if PuppySettings.SilentAimSettings.PingPred1 and not PuppySettings.SilentAimSettings.PingPred2 and PuppySettings.SilentAim.Enabled then
		pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
		split = string.split(pingvalue,'(')
		ping = tonumber(split[1])
	   if ping < 130 then
		   PredictionValue = 0.151
	   elseif ping < 125 then
		   PredictionValue = 0.149
	   elseif ping < 110 then
		   PredictionValue = 0.146
	   elseif ping < 105 then
		   PredictionValue = 0.138
	   elseif ping < 90 then
		   PredictionValue = 0.136
	   elseif ping < 80 then
		   PredictionValue = 0.134
	   elseif ping < 70 then
		   PredictionValue = 0.131
	   elseif ping < 60 then
		   PredictionValue = 0.1229
	   elseif ping < 50 then
		   PredictionValue = 0.1225
	   elseif ping < 40 then
		   PredictionValue = 0.1256
	   end
	end -- Ping Prediction 2
	if PuppySettings.SilentAim.ShowFOV then
		SilentAimFOV.Visible = true
        SilentAimFOV.Radius = PuppySettings.FOV.SilentAimSize
        SilentAimFOV.Filled = PuppySettings.FOV.FOVFilled
        SilentAimFOV.Transparency = PuppySettings.FOV.Transparency
        SilentAimFOV.NumSides = 100
        SilentAimFOV.Thickness = PuppySettings.FOV.Thickness
        SilentAimFOV.Color = PuppySettings.SilentAim.FOVColor
        SilentAimFOV.Position = Vector2.new(Mouse.X, Mouse.Y + GuiInset.Y)
    else
        SilentAimFOV.Visible = false
    end -- fov
	if PuppySettings.TriggerBot.Enabled then
		for i, v in next, Players:GetPlayers() do 
			if Alive(v) then 
				if Mouse.Target:IsDescendantOf(v.Character) and PuppySettings.TriggerBot.Enabled == true then 
					mouse1press()
					wait()
					mouse1release()
					wait(PuppySettings.TriggerBot.DelayAmount)
				end 
			end
		end
	end -- tb
    if PuppySettings.SilentAim.UseFOV == true and PuppySettings.SilentAim.Enabled then
        wait()
        enabled = true
        if PuppySettings.SilentAim.UseNearestDistance then
            local NearestTarget, NearestPos = NearestDistance()
            if NearestTarget and (not PuppySettings.SilentAim.UseFOV or PuppySettings.FOV.SilentAimSize > NearestPos) and (not PuppySettings.SilentAim.KnockedCheck or not Knocked(NearestTarget)) and (not PuppySettings.SilentAim.grabbedCheck or not Grabbed(NearestTarget)) and (not PuppySettings.SilentAim.WallCheck or WallCheck(NearestTarget.Character.HumanoidRootPart, LocalPlayer.Character.HumanoidRootPart)) then
                Plr = NearestDistance()
                Pos = NearestPos
            end
        else
            local NearestTarget, NearestPos = NearestMouse()
            if NearestTarget and (not PuppySettings.SilentAim.UseFOV or PuppySettings.FOV.SilentAimSize > NearestPos) and (not PuppySettings.SilentAim.KnockedCheck or not Knocked(NearestTarget)) and (not PuppySettings.SilentAim.grabbedCheck or not Grabbed(NearestTarget)) and (not PuppySettings.SilentAim.WallCheck or WallCheck(NearestTarget.Character.HumanoidRootPart, LocalPlayer.Character.HumanoidRootPart)) then
                Plr = NearestMouse()
                Pos = NearestPos
            end
        end
    end -- use fov 
    if PuppySettings.SilentAim.Enabled and enabled and Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart") and Plr ~= game.Players.LocalPlayer and PuppySettings.SilentAim.ShowHitbox then
        if PuppySettings.SilentAim.RandomHitbox then
            placemarker.CFrame = CFrame.new(Plr.Character[RandomTable(PuppyHitboxes)].Position + (Plr.Character[RandomTable(PuppyHitboxes)].Velocity * PuppySettings.SilentAimSettings.MovementPredictionAmount))
		else
            placemarker.CFrame = CFrame.new(Plr.Character[PuppySettings.SilentAim.Hitboxes].Position + (Plr.Character[PuppySettings.SilentAim.Hitboxes].Velocity * PuppySettings.SilentAimSettings.MovementPredictionAmount))
		end
    else
        placemarker.CFrame = CFrame.new(0, 9999, 0)
    end -- hitbox / dot
    if getgenv().LegitAA then
        if PuppySettings.AntiAim.FPSUnlocked == true then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.Humanoid.MoveDirection * -0.3
        else
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.Humanoid.MoveDirection * -0.5
        end
    end -- legit aa
    if getgenv().CFSpeed then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + game.Players.LocalPlayer.Character.Humanoid.MoveDirection * PuppySettings.Misc.CFrameSpeed.Speed
    end -- cfspeed
    if getgenv().Clicking then
        mouse1click() 
        wait(0.001)
    end -- Auto Clicker
end)

if game.PlaceId == 5602055394 then -- da hood modded
	local mt = getrawmetatable(game)
	local old = mt.__namecall
	setreadonly(mt, false)
	mt.__namecall = newcclosure(function(...) --// LPH JIT
		local args = {...}
		if PuppySettings.SilentAim.Enabled and ChanceTable(PuppySettings.SilentAimSettings.HitChanceAmount) == "HitPercent" and enabled and Plr ~= game.Players.LocalPlayer and (not PuppySettings.SilentAim.UseFOV or PuppySettings.FOV.SilentAimSize > Pos) and getnamecallmethod() == "FireServer" and args[2] == "MousePos" then
			if PuppySettings.SilentAim.RandomHitbox then
				args[3] = Plr.Character[RandomTable(PuppyHitboxes)].Position + (Plr.Character[RandomTable(PuppyHitboxes)].Velocity * PuppySettings.SilentAimSettings.MovementPredictionAmount)
			else
				args[3] = Plr.Character[PuppySettings.SilentAim.Hitboxes].Position + (Plr.Character[PuppySettings.SilentAim.Hitboxes].Velocity * PuppySettings.SilentAimSettings.MovementPredictionAmount)
			end
			return old(unpack(args))
		end
		return old(...)
	end)
else -- da hood
	local mt = getrawmetatable(game)
	local old = mt.__namecall
	setreadonly(mt, false)
	mt.__namecall = newcclosure(function(...) --// LPH JIT
		local args = {...}
		if PuppySettings.SilentAim.Enabled and ChanceTable(PuppySettings.SilentAimSettings.HitChanceAmount) == "HitPercent" and enabled and Plr ~= game.Players.LocalPlayer and (not PuppySettings.SilentAim.UseFOV or PuppySettings.FOV.SilentAimSize > Pos) and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
			if PuppySettings.SilentAim.RandomHitbox then
				args[3] = Plr.Character[RandomTable(PuppyHitboxes)].Position + (Plr.Character[RandomTable(PuppyHitboxes)].Velocity * PuppySettings.SilentAimSettings.MovementPredictionAmount)
			else
				args[3] = Plr.Character[PuppySettings.SilentAim.Hitboxes].Position + (Plr.Character[PuppySettings.SilentAim.Hitboxes].Velocity * PuppySettings.SilentAimSettings.MovementPredictionAmount)
			end
			return old(unpack(args))
		end
		return old(...)
	end)
end

--// Anti

local gm = getrawmetatable(game)
setreadonly(gm, false)
local namecall = gm.__namecall
gm.__namecall = newcclosure( function(self, ...)
	local args = {...}
	if not checkcaller() and getnamecallmethod() == "FireServer" and tostring(self) == "MainEvent" then
		if tostring(getcallingscript()) ~= "Framework" then
			return
        end
    end
    if not checkcaller() and getnamecallmethod() == "Kick" then
		return
    end
	return namecall(self, unpack(args))
end)

local libary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Lior4410/techoko.cc/main/library.lua"))()
local Window = libary:new({name = "techoko.lua", accent =Color3.fromRGB(0.603921, 0.011764, 1), textsize = 13})

local AimingTab = Window:page({name = "Aiming I"})
local RageTab = Window:page({name = "Aiming II"})
local VisualTab = Window:page({name = "Visauls"})
local MiscTab = Window:page({name = "Misc"})
local ConfigSection = Window:page({name = "Settings"})


local ConfigSection = ConfigSection:section({name = "Config",side = "right", size = 250})
local ConfigLoader = ConfigSection:configloader({folder = ""})


local SAimSection = AimingTab:section({name = "RageBot", side = "left",size = 323})

local EAimSection = AimingTab:section({name = "TargetStrafe", side = "Right",size = 150})

local RAimSection = AimingTab:section({name = "Visualization", side = "Right",size = 62})

local KAimSection = AimingTab:section({name = "FOV Adjustments", side = "Right",size = 186})

local OAimSection = AimingTab:section({name = "On Death", side = "left",size = 121})

local LAimSection = AimingTab:section({name = "Auto Shoot When Locked", side = "left",size = 43})

local TAimSection = AimingTab:section({name = "Extra", side = "right",size = 78})


local MAimSection = MiscTab:section({name = "AA", side = "Right",size = 299})

local section1 = MiscTab:section({name = "Misc", side = "Left",size = 222})

local vis = VisualTab:section({name = "Visuals Settings",side = "right",size = 165})




    





SAimSection:toggle({name = "Enabled", def = false, callback = function(Boolean)
    aiming.targetaim.enabled = Boolean
end})

SAimSection:toggle({name = "Draw FOV", def = false, callback = function(Boolean)
    aiming.fov.enabled = Boolean
end})

SAimSection:colorpicker({name = "FOV Color", cpname = "", def = Color3.new(0.603921, 0.011764, 1), callback = function(color)
    aiming.fov.colour = color
end})


SAimSection:textbox({name = " Prediction",def = "0.11",placeholder = "",callback = function(bool)
    aiming.targetaim.prediction = bool
 end})
 SAimSection:dropdown({name = "Hitbox", def = "HumanoidRootPart", max = 4, options = {"Head","UpperTorso","HumanoidRootPart"}, callback = function(part)
    aiming.targetaim.hitpart = part
end})
SAimSection:toggle({name = "Ping Based Prediction", def = false, callback = function(Boolean)
    aiming.targetaim.autoprediction = Boolean
end})
SAimSection:toggle({name = "View Opponent", def = false, callback = function(Boolean)
    aiming.targetaim.view = Boolean
end})
SAimSection:toggle({name = "Chat Mode", def = false, callback = function(Boolean)
    aiming.targetaim.chat = Boolean
end})
SAimSection:toggle({name = "Tracers", def = false, callback = function(Boolean)
    aiming.tracers.enabled = Boolean
end})
SAimSection:colorpicker({name = "Tracer Color", cpname = "", def = Color3.new(0.603921, 0.011764, 1), callback = function(color)
    aiming.tracers.colour = color
end})
SAimSection:toggle({name = "Rainbow Tracer", def = false, callback = function(Boolean)
    aiming.tracers.rainbow = Boolean
end})

SAimSection:dropdown({name = "Tracer home", def = "Penis", max = 4, options = {"Head","Torso", "Cursor", "Penis"}, callback = function(part)
    aiming.tracers.from = part
end})
EAimSection:toggle({name = "Enabled", def = false, callback = function(Boolean)
    aiming.orbit.enabled = Boolean
end})

EAimSection:toggle({name = "Visualize Path", def = false, callback = function(Boolean)
    aiming.orbit.visualization = Boolean
end})
EAimSection:colorpicker({name = "Visualize Path Color", cpname = "", def = Color3.new(0.603921, 0.011764, 1), callback = function(color)
    aiming.orbit.vc = color
end})

EAimSection:slider({name = "Speed", def = 0, max = 100, min = 2, rounding = true, callback = function(Value)
    aiming.orbit.speed = Value
end})


EAimSection:slider({name = "Distance", def = 0, max = 100, min = 0, rounding = true, callback = function(Value)
    aiming.orbit.distance = Value
end})
RAimSection:dropdown({name = "Options", def = "Circle", max = 4, options = {"Circle","Part"}, callback = function(part)
    aiming.visualization.mode = part
end})

KAimSection:toggle({name = "FOV Filled", def = false, callback = function(v)
    aiming.fov.filled = v
end})


KAimSection:slider({name = "FOV Thickness", def = 0, max = 100, min = 2, rounding = true, callback = function(v)
   aiming.fov.thickness = v
end})

KAimSection:slider({name = "FOV Radius", def = 0, max = 100, min = 2, rounding = true, callback = function(v)
   aiming.fov.radius = v
end})

KAimSection:slider({name = "FOV Sides", def = 0, max = 100, min = 2, rounding = true, callback = function(v)
   circle.NumSides = v
end})

KAimSection:dropdown({name = "Shape", def = "Circle", max = 4, options = {"Circle","Hexagon", "Square", "Custom"}, callback = function(part)
    aiming.fov.option = part
end})

OAimSection:toggle({name = "Unlock When Knocked", def = false, callback = function(Boolean)
    aiming.od.unlockko = Boolean
end})
OAimSection:toggle({name = "Teleport When Knocked", def = false, callback = function(Boolean)
    aiming.od.tpko = Boolean
end})
OAimSection:toggle({name = "Stomp After Knocked", def = false, callback = function(Boolean)
    aiming.od.stompko = Boolean
end})
OAimSection:slider({name = "Stomp Interval", def = 0, max = 100, min = 2, rounding = true, callback = function(Value)
    aiming.od.stomptime = Value
end})

LAimSection:toggle({name = "Enabled", def = false, callback = function(Boolean)
    aiming.targetaim.autoshoot = Boolean
end})
TAimSection:toggle({name = "Windows 11 Mode (Not Working For a time)", def = false, callback = function(Boolean)
    aiming.targetaim.win11 = Boolean
end})
TAimSection:slider({name = "Windows 11 Volume", def = 0, max = 100, min = 2, rounding = true, callback = function(v)
    aiming.targetaim.win11volume = v
 end})



 
    
    












































local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall =
    newcclosure(
    function(...)
        local args = {...}
        if
            targetplr ~= nil and aiming.targetaim.enabled and targetplr and aiming.targetaim.targeting == true and
                aiming.targetaim.enabled == true and
                getnamecallmethod() == "FireServer" and
                args[2] == "UpdateMousePos"
         then
            args[3] =
                game.Players[targetplr].Character[aiming.targetaim.hitpart].Position +
                (game.Players[targetplr].Character.LowerTorso.Velocity * aiming.targetaim.prediction)
            return old(unpack(args))
        end
        return old(...)
    end
)

--// main Code

spawn(
    function()
        game:GetService("RunService").Stepped:Connect(
            function()
                --- fov
                spawn(
                    function()
                        circle.Position = Vector2.new(LocalMouse.X, LocalMouse.Y + 35)
                    end
                )

                spawn(
                    function()
                        if aiming.fov.option == "Circle" then
                            aiming.fov.side = 350
                            circle.NumSides = 350
                            aiming.fov.side = 350
                        elseif aiming.fov.option == "Hexagon" then
                            aiming.fov.side = 6
                            circle.NumSides = 6
                            aiming.fov.side = 6
                        elseif aiming.fov.option == "Square" then
                            aiming.fov.side = 4
                            circle.NumSides = 4
                            aiming.fov.side = 4
                        else
                        end
                    end
                )

                spawn(
                    function()
                        if aiming.fov.enabled == true then
                            circle.Visible = true
                        else
                            circle.Visible = false
                        end
                    end
                )

                spawn(
                    function()
                        circle.Color = aiming.fov.colour
                    end
                )

                spawn(
                    function()
                        circle.Filled = aiming.fov.filled
                    end
                )

                spawn(
                    function()
                        circle.Radius = aiming.fov.radius
                    end
                )

                spawn(
                    function()
                        circle.Thickness = aiming.fov.thickness
                    end
                )

                --- targetaim

                spawn(
                    function()
                        if aiming.targetaim.autoprediction == true then
                            local pingvalue =
                                game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
                            local split = string.split(pingvalue, "(")
                            local ping = tonumber(split[1])
                            
                            
                            if ping < 130 then
                                aiming.targetaim.prediction = 0.151
                            elseif ping < 125 then
                                aiming.targetaim.prediction = 0.149
                            elseif ping < 110 then
                                aiming.targetaim.prediction = 0.146
                            elseif ping < 105 then
                                aiming.targetaim.prediction = 0.138
                            elseif ping < 90 then
                                aiming.targetaim.prediction = 0.136
                            elseif ping < 80 then
                                aiming.targetaim.prediction = 0.134
                            elseif ping < 70 then
                                aiming.targetaim.prediction = 0.131
                            elseif ping < 60 then
                                aiming.targetaim.prediction = 0.1229
                            elseif ping < 50 then
                                aiming.targetaim.prediction = 0.1225
                            elseif ping < 40 then
                                aiming.targetaim.prediction = 0.1256
                            end
                        
                        end
                    end
                )
                spawn(
                    function()
                        if aiming.tracers.rainbow == true then 
                            
                        else
                        line.Color = aiming.tracers.colour
                        end
                    end
                )

                spawn(
                    function()
                        if aiming.targetaim.enabled and aiming.targetaim.targeting and aiming.tracers.enabled == true then
                            local plrp =
                                CurrentCamera:WorldToViewportPoint(
                                game.Players[targetplr].Character[aiming.targetaim.hitpart].Position
                            )
                            local headt =
                                CurrentCamera:WorldToViewportPoint(game.Players.LocalPlayer.Character.Head.Position)
                            local torsot =
                                CurrentCamera:WorldToViewportPoint(
                                game.Players.LocalPlayer.Character.UpperTorso.Position
                            )
                            local penist =
                                CurrentCamera:WorldToViewportPoint(
                                game.Players.LocalPlayer.Character.LowerTorso.Position
                            )
                            local mouset = CurrentCamera:WorldToViewportPoint(LocalMouse.Hit.Position)

                            line.Visible = true

                            if aiming.tracers.from == "Penis" then
                                line.From = Vector2.new(penist.X, penist.Y)
                                line.To = Vector2.new(plrp.X, plrp.Y)
                            end

                            if aiming.tracers.from == "Head" then
                                line.From = Vector2.new(headt.X, headt.Y)
                                line.To = Vector2.new(plrp.X, plrp.Y)
                            end

                            if aiming.tracers.from == "Torso" then
                                line.From = Vector2.new(torsot.X, torsot.Y)
                                line.To = Vector2.new(plrp.X, plrp.Y)
                            end

                            if aiming.tracers.from == "Cursor" then
                                line.From = Vector2.new(mouset.X, mouset.Y)
                                line.To = Vector2.new(plrp.X, plrp.Y)
                            end
                        else
                            line.Visible = false
                        end
                    end
                )

                if aiming.od.unlockko and aiming.targetaim.targeting and aiming.targetaim.enabled == true then
                    if game.Players[targetplr].Character.Humanoid.health < 1 then
                        aiming.targetaim.targeting = false
                    end
                end

                if aiming.od.tpko == true then
                    if game.Players[targetplr].Character.Humanoid.health < 0.99 then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                            game.Players[targetplr].Character.LowerTorso.CFrame
                    end
                end

                if
                    aiming.targetaim.targeting == true and aiming.targetaim.enabled == true and
                        aiming.orbit.enabled == true and
                        aiming.orbit.visualization == true
                 then
                    Circle2222.Color =  aiming.orbit.vc
                    Circle2222.Visible = true
                    Circle2222.Radius = aiming.orbit.distance
                    Circle2222.Position = game.Players[targetplr].Character.HumanoidRootPart.Position
                else
                    Circle2222.Visible = false
                end

                if aiming.visualization.mode == "Circle" then
                    if aiming.targetaim.targeting and aiming.targetaim.enabled == true then
                        local narcan =
                            CurrentCamera:WorldToViewportPoint(
                            game.Players[targetplr].Character.HumanoidRootPart.Position
                        )
                        circlev.Position = Vector2.new(narcan.X, narcan.Y)
                        circlev.Visible = true
                    else
                        circlev.Visible = false
                    end
                end

                if aiming.targetaim.autoshoot and aiming.targetaim.targeting and aiming.targetaim.enabled == true then
                    mouse1click()
                end
            end
        )
    end
)

-- shit auto stomp srry
spawn(
    function()
        while task.wait() do
            if aiming.targetaim.targeting and aiming.targetaim.enabled and aiming.od.stompko == true then
                if game.Players[targetplr].Character.Humanoid.health < 0 then
                    if aiming.od.stompko == true then
                        spawn(
                            function()
                                wait(aiming.od.stomptime)
                                local args = {
                                    [1] = "Stomp"
                                }

                                game:GetService("ReplicatedStorage").MainEvent:FireServer(unpack(args))
                            end
                        )
                    end
                end
            end
        end
    end
)

--[[


local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Lior4410/techoko.cc/main/ui.lua"))()

local Window = library:CreateWindow("HoodReligions", Vector2.new(492, 665), Enum.KeyCode.RightShift) -- arg 1 is the name, arg 2 is the size in X-Y and RightShift is the bind.

local ExampleTab = Window:CreateTab("Example") --// tab (self explanatory) "ExampleTab" can be re named to anything you'd like 

--// Sector1 is where ur toggle's / buttons will be going remember that 

local Sector1 = ExampleTab:CreateSector("Example", "left") --// left is the side it goes on, example is the label of the box if u wanna put it on the right side change it to Right

--// toggles "Toggle" "ToggleSpeed" "Toggle this or that" it can be what ever Remember Ur Top Is Called "Sector1" so yeah 

local ToggleSpeed = Sector1:AddToggle("Toggle Name", false, function()
   --// toggle script here 
end)

--Buttons that's all u really need to see

local button = Sector1:AddButton("Button Name", function()
    print("Test") --// place script u wanna put for ur button lol
end)


local dropdownScripts = Sector1:AddDropdown("Aim Part", {"HumanoidRootPart", "Random", "LowerTorso"}, "Head", function() 
    --// script here i guess
end)

--// Slider's 

local JumpPowerr = Sector1:AddSlider("JumpPower", 50, 0, 500, 5, function(value) 
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
end)

local Speed = Sector1:AddSlider("Speed", 16, 0, 500, 5, function(value) 
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)


local Fov = Sector1:AddSlider("Fov", 70, 0, 120, 5, function(value) 
    game:GetService'Workspace'.Camera.FieldOfView = value
end)


]]


local SAimSection = RageTab:section({name = "Silent Aim", side = "left",size = 320})
SAimSection:toggle({name = "Silent Aim Enabled", def = false, callback = function(Boolean)
    PuppySettings.SilentAim.Enabled = Boolean
end})

SAimSection:textbox({name = " Prediction",def = "0.11",placeholder = "",callback = function(bool)
    PredictionValue = bool
 end})

 SAimSection:toggle({name = "Show FOV", def = false, callback = function(Boolean)
    PuppySettings.SilentAim.ShowFOV = Boolean
end})

SAimSection:colorpicker({name = "Dot Color", cpname = "", def = Color3.new(0.603921, 0.011764, 1), callback = function(color)
    PuppySettings.SilentAim.DOTColor = color
end})

SAimSection:toggle({name = "Wall Check", def = false, callback = function(Boolean)
    PuppySettings.SilentAim.WallCheck = Boolean
end})

SAimSection:toggle({name = "Knocked Check", def = false, callback = function(Boolean)
    PuppySettings.SilentAim.KnockedCheck = Boolean
end})

SAimSection:toggle({name = "Grabbed Check", def = false, callback = function(Boolean)
    PuppySettings.SilentAim.GrabbedCheck = Boolean
end})

SAimSection:toggle({name = "Blatant Mode", def = false, callback = function(Boolean)
    PuppySettings.SilentAim.ShowHitbox = Boolean
end})

SAimSection:toggle({name = "Notification Mode", def = false, callback = function(Boolean)
    PuppySettings.SilentAim.NotificationMode = Boolean
end})

SAimSection:toggle({name = "Hit Airshots", def = false, callback = function(Boolean)
    PuppySettings.SilentAim.AirShotMode = Boolean
end})

SAimSection:toggle({name = "Use Nearest Distance", def = false, callback = function(Boolean)
    PuppySettings.SilentAim.UseNearestDistance = Boolean
end})

SAimSection:dropdown({name = "Hitbox", def = "HumanoidRootPart", max = 4, options = {"Head","UpperTorso","HumanoidRootPart"}, callback = function(part)
    PuppySettings.SilentAim.Hitboxes = part
end})

SAimSection:toggle({name = "Random Hitbox", def = false, callback = function(Boolean)
    PuppySettings.SilentAim.RandomHitbox = Boolean
end})

-- Aimbot Section --
local AimbotSection = RageTab:section({name = "AimBot", side = "right",size = 113})
AimbotSection:toggle({name = "Aimbot Enabled", def = false, callback = function(Boolean)
    PuppySettings.Aimbot.Enabled = Boolean
end})

AimbotSection:toggle({name = "Prediction", def = false, callback = function(Boolean)
    PuppySettings.Aimbot.Prediction = Boolean
end})

AimbotSection:dropdown({name = "Aim Hitbox", def = "HumanoidRootPart", max = 4, options = {"Head","UpperTorso","HumanoidRootPart"}, callback = function(part)
    PuppySettings.Aimbot.Hitboxes = part
end})

-- Silent FOV Section --
local AimbotFOVSection = RageTab:section({name = "FOV", side = "right",size = 150})
AimbotFOVSection:toggle({name = "FOV Filled", def = false, callback = function(Boolean)
    PuppySettings.FOV.FOVFilled = Boolean
end})

AimbotFOVSection:slider({name = "Silent FOV Size", def = 100, max = 500, min = 10, rounding = true, callback = function(Value)
    PuppySettings.FOV.SilentAimSize = Value
end})

AimbotFOVSection:slider({name = "Silent FOV Transparency", def = 9, max = 9, min = 1, rounding = true, callback = function(Value)
    PuppySettings.FOV.Transparency = tonumber("0." .. Value)
end})

AimbotFOVSection:slider({name = "FOV Thickness", def = 2, max = 10, min = 1, rounding = true, callback = function(Value)
    PuppySettings.FOV.Thickness = Value
end})

AimbotFOVSection:colorpicker({name = "FOV Color", cpname = "", def = Color3.new(0.603921, 0.011764, 1), callback = function(color)
    PuppySettings.SilentAim.FOVColor = color
end})

-- Aimbot Settings Section --

local AimbotSettings = RageTab:section({name = "Aimbot Settings", side = "right",size = 150})

AimbotSettings:dropdown({name = "Aim Assist Type", def = "Camera", max = 4, options = {"Camera","Mouse",}, callback = function(part)
    PuppySettings.AimbotSettings.Mode = part
end})

AimbotSettings:toggle({name = "Smoothness", def = false, callback = function(Boolean)
    PuppySettings.AimbotSettings.Smoothness = Boolean
end})

AimbotSettings:slider({name = "Smoothness Ammount", def = 2, max = 10, min = 1, rounding = true, callback = function(Value)
    PuppySettings.AimbotSettings.SmoothnessAmmount = Value
end})

AimbotSettings:slider({name = "Prediction Velocity", def = 10, max = 60, min = 10, rounding = true, callback = function(Value)
    PuppySettings.AimbotSettings.PredictionVelocity = Value
end})

-- Silent Aim Settings Section --
local SilentAimSettings = RageTab:section({name = "Silent Aim Settings", side = "left",size = 130})

SilentAimSettings:toggle({name = "Hit Chance", def = false, callback = function(Boolean)
    PuppySettings.SilentAimSettings.HitChance = Boolean
end})

SilentAimSettings:toggle({name = "Ping Prediction (1)", def = false, callback = function(Boolean)
    PuppySettings.SilentAimSettings.PingPred1 = Boolean
end})


SilentAimSettings:slider({name = "Hit Chnace Amm", def = 100, max = 100, min = 0, rounding = true, callback = function(Value)
    PuppySettings.SilentAimSettings.HitChanceAmount.HitPercent = tonumber(Value)
    PuppySettings.SilentAimSettings.HitChanceAmount.NotHitPercent = tonumber(100 - PuppySettings.SilentAimSettings.HitChanceAmount.HitPercent)
end})

-- Trigger Bot Section -- 
local TriggerbotSection = RageTab:section({name = "Trigger Bot", side = "right",size = 80})

TriggerbotSection:toggle({name = "Trigger Bot Enabled", def = false, callback = function(Boolean)
	PuppySettings.TriggerBot.Enabled = Boolean
end})

TriggerbotSection:slider({name = "Delay (Ammount)", def = 0, max = 60, min = 0, rounding = true, callback = function(Value)
	PuppySettings.TriggerBot.DelayAmount = Value
end})

-- Anti Aim Section --

MAimSection:toggle({name = "Anti Aim Enabled", def = false, callback = function(Boolean)
    PuppySettings.AntiAim.Enabled = Boolean
end})

MAimSection:toggle({name = "Desync AA Enabled", def = false, callback = function(Boolean)
    PuppySettings.AntiAim.Desync = Boolean
end})

MAimSection:toggle({name = "Legit AA Enabled", def = false, callback = function(Boolean)
    PuppySettings.AntiAim.Legit = Boolean
end})

MAimSection:button({name = "Hitbox Destroyer", callback = function()
	game.Players.LocalPlayer.Character.Head:BreakJoints()
    game.Players.LocalPlayer.Character.Head.Position = Vector3.new(0,999999999999,0)
    game.Players.LocalPlayer.Character.Parent = nil
    game.Players.LocalPlayer.Character.HumanoidRootPart:Destroy()
    game.Players.LocalPlayer.Character.Parent = game.workspace
    local A = getrawmetatable(game)
    local B = A.__index
    setreadonly(A, false)
	A.__index = newcclosure(function(self, key)
		if self == game:GetService("Players").LocalPlayer.Character and key == "HumanoidRootPart" then
			return game:GetService("Players").LocalPlayer.Character.UpperTorso
        end
		return B(self, key)
    end)
	game.Players.LocalPlayer.Character.RightUpperLeg:Destroy()
    game.Players.LocalPlayer.Character.LeftUpperLeg:Destroy()
end})

MAimSection:toggle({name = "BackTracking", def = false, callback = function(Boolean)
    PuppySettings.BackTracking.Enabled = Boolean
end})

MAimSection:toggle({name = "Auto Peak", def = false, callback = function(Boolean)
    PuppySettings.AutoPeak.Enabled = Boolean
end})

MAimSection:slider({name = "Desync Velocity", def = 500, max = 1000, min = 0, rounding = true, callback = function(Value)
	PuppySettings.AntiAim.DesyncValues.Velocity = tonumber(Value)
end})

MAimSection:slider({name = "Desync CFrame", def = 500, max = 1000, min = 0, rounding = true, callback = function(Value)
	PuppySettings.AntiAim.DesyncValues.CFrame = tonumber(Value)
end})

MAimSection:keybind({name = "Legit AA Keybind", def = Enum.KeyCode.Z, callback = function(Key)
	PuppySettings.AntiAim.LegitAAKey = Key
end})

MAimSection:keybind({name = "Auto Peak Keybind", def = Enum.KeyCode.N, callback = function(Key)
	PuppySettings.AutoPeak.APKey = Key
end})

MAimSection:toggle({name = "+60 FPS", def = false, callback = function(Boolean)
    PuppySettings.AntiAim.FPSUnlocked = Boolean
end})

--// Visual Sections

--// Misc Sections
local TimeTick
TimeTick = hookfunction(wait, function(JumpCooldown)
	if JumpCooldown == 1.5 and (PuppySettings.Misc.CFrameSpeed.Bhop and PuppySettings.Misc.CFrameSpeed.Enabled) or PuppySettings.Misc.Strafe then 
		return TimeTick()
    end
    return TimeTick(JumpCooldown)
end)

section1:toggle({name = "CFrame Speed", def = false, callback = function(Boolean)
	PuppySettings.Misc.CFrameSpeed.Enabled = Boolean
end})

section1:toggle({name = "Bhop", def = false, callback = function(Boolean)
	PuppySettings.Misc.CFrameSpeed.Bhop = Boolean
end})

section1:keybind({name = "CFrame Keybind", def = Enum.KeyCode.V, callback = function(Key)
	PuppySettings.Misc.CFrameSpeed.Keybind = Key
end})

section1:slider({name = "CFrame Value", def = 100, max = 1000, min = 0, rounding = true, callback = function(Value)
	PuppySettings.Misc.CFrameSpeed.Speed = tonumber(Value)/100
end})

section1:toggle({name = "Strafe Jump", def = false, callback = function(Boolean)
	PuppySettings.Misc.Strafe = Boolean
end})

section1:button({name = "Fly (X)", callback = function()
	local mouse = game.Players.LocalPlayer:GetMouse()
	localplayer = game.Players.LocalPlayer
	if workspace:FindFirstChild("Core") then
		workspace.Core:Destroy()
	end
	local Core = Instance.new("Part")
	Core.Name = "Core"
	Core.Size = Vector3.new(0.05, 0.05, 0.05)
	spawn(function()
		Core.Parent = workspace
		local Weld = Instance.new("Weld", Core)
		Weld.Part0 = Core
		Weld.Part1 = localplayer.Character.LowerTorso
		Weld.C0 = CFrame.new(0, 0, 0)
	end)
	workspace:WaitForChild("Core")
	local torso = workspace.Core
	flying = true
	local speed=10
	local keys={a=false,d=false,w=false,s=false}
	local e1
	local e2
	local function start()
	local pos = Instance.new("BodyPosition",torso)
	local gyro = Instance.new("BodyGyro",torso)
	pos.Name="EPIXPOS"
	pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
	pos.position = torso.Position
	gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
	gyro.cframe = torso.CFrame
	repeat wait() localplayer.Character.Humanoid.PlatformStand = true
		local new=gyro.cframe - gyro.cframe.p + pos.position
		if not keys.w and not keys.s and not keys.a and not keys.d then
			speed=5
		end
		if keys.w then
			new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
			speed=speed+0
		end
		if keys.s then
			new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
			speed=speed+0
		end
		if keys.d then
			new = new * CFrame.new(speed,0,0)
			speed=speed+0
		end
		if keys.a then
			new = new * CFrame.new(-speed,0,0)
			speed=speed+0
		end
		if speed>10 then
			speed=5
		end
		pos.position=new.p
		if keys.w then
			gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
		elseif keys.s then
			gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
		else
			gyro.cframe = workspace.CurrentCamera.CoordinateFrame
		end
	until flying == false
	if gyro then gyro:Destroy() end
	if pos then pos:Destroy() end
	flying=false
	localplayer.Character.Humanoid.PlatformStand=false
	speed=10
	end
	e1=mouse.KeyDown:connect(function(key)
		if not torso or not torso.Parent then flying=false e1:disconnect() e2:disconnect() return end
		if key=="w" then
			keys.w=true
		elseif key=="s" then
			keys.s=true
		elseif key=="a" then
			keys.a=true
		elseif key=="d" then
            
			keys.d=true
		elseif key=="x" then
			if flying==true then
				flying=false
			else
				flying=true
				start()
			end
		end
	end)
	e2=mouse.KeyUp:connect(function(key)
		if key=="w" then
			keys.w=false
		elseif key=="s" then
			keys.s=false
		elseif key=="a" then
			keys.a=false
		elseif key=="d" then
			keys.d=false
		end
	end)
	start()
end})

section1:toggle({name = "Antislow", def = false, callback = function(Boolean)
	PuppySettings.Misc.Antislow = Boolean 
end})

-- MiscToolSettings


-- Misc Char


section1:toggle({name = "AutoClicker", def = false, callback = function(Boolean)
	PuppySettings.AutoClicker.Enabled = Boolean 
end})

section1:keybind({name = "AutoClicker Keybind", def = Enum.KeyCode.B, callback = function(Key)
	PuppySettings.AutoClicker.Keybind = Key
end})

AimingTab:openpage()

-- Init --

--// Lock Normal
getgenv().AimlockKey = "q"
getgenv().AimRadius = 30 
getgenv().ThirdPerson = true 
getgenv().FirstPerson = true
getgenv().PredictionVelocity = 11

local Players, Uis, RService, SGui = game:GetService"Players", game:GetService"UserInputService", game:GetService"RunService", game:GetService"StarterGui";
local Client, Mouse, Camera, CF, RNew, Vec3, Vec2 = Players.LocalPlayer, Players.LocalPlayer:GetMouse(), workspace.CurrentCamera, CFrame.new, Ray.new, Vector3.new, Vector2.new;
local MousePressed, CanNotify = false, false;
local AimlockTarget;
local OldPre;

getgenv().GetNearestTarget = function()
    local players = {}
    local PLAYER_HOLD  = {}
    local DISTANCES = {}
    for i, v in pairs(Players:GetPlayers()) do
        if v ~= Client then
            table.insert(players, v)
        end
    end
    for i, v in pairs(players) do
        if v.Character ~= nil then
            local AIM = v.Character:FindFirstChild("Head")
                local DISTANCE = (v.Character:FindFirstChild("Head").Position - game.Workspace.CurrentCamera.CFrame.p).magnitude
                local RAY = Ray.new(game.Workspace.CurrentCamera.CFrame.p, (Mouse.Hit.p - game.Workspace.CurrentCamera.CFrame.p).unit * DISTANCE)
                local HIT,POS = game.Workspace:FindPartOnRay(RAY, game.Workspace)
                local DIFF = math.floor((POS - AIM.Position).magnitude)
                PLAYER_HOLD[v.Name .. i] = {}
                PLAYER_HOLD[v.Name .. i].dist= DISTANCE
                PLAYER_HOLD[v.Name .. i].plr = v
                PLAYER_HOLD[v.Name .. i].diff = DIFF
                table.insert(DISTANCES, DIFF)
        end
    end
    
    if unpack(DISTANCES) == nil then
        return nil
    end
    
    local L_DISTANCE = math.floor(math.min(unpack(DISTANCES)))
    if L_DISTANCE > getgenv().AimRadius then
        return nil
    end
    
    for i, v in pairs(PLAYER_HOLD) do
        if v.diff == L_DISTANCE then
            return v.plr
        end
    end
    return nil
end

Mouse.KeyDown:Connect(function(a)
    if not (Uis:GetFocusedTextBox()) then 
        if a == AimlockKey and AimlockTarget == nil then
            pcall(function()
                if MousePressed ~= true then MousePressed = true end 
                local Target;Target = GetNearestTarget()
                if Target ~= nil then 
                    AimlockTarget = Target
                end
            end)
        elseif a == AimlockKey and AimlockTarget ~= nil then
            if AimlockTarget ~= nil then AimlockTarget = nil end
            if MousePressed ~= false then 
                MousePressed = false 
            end
        end
    end
end)

RService.RenderStepped:Connect(function()
	if PuppySettings.Aimbot.Enabled then
    if getgenv().ThirdPerson == true and getgenv().FirstPerson == true then 
        if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 or (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1 then 
            CanNotify = true 
        else 
            CanNotify = false 
        end
    elseif getgenv().ThirdPerson == true and getgenv().FirstPerson == false then 
        if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude > 1 then 
            CanNotify = true 
        else 
            CanNotify = false 
        end
    elseif getgenv().ThirdPerson == false and getgenv().FirstPerson == true then 
        if (Camera.Focus.p - Camera.CoordinateFrame.p).Magnitude <= 1 then 
            CanNotify = true 
        else 
            CanNotify = false 
        end
    end
    if PuppySettings.Aimbot.Enabled == true and MousePressed == true then 
        if AimlockTarget and AimlockTarget.Character and AimlockTarget.Character:FindFirstChild(PuppySettings.Aimbot.Hitboxes) then 
            if getgenv().FirstPerson == true then
                if CanNotify == true then
                    if PuppySettings.Aimbot.Prediction == true then
                        if PuppySettings.AimbotSettings.Smoothness == true then
                            --// The part we're going to lerp/smoothen \\--
                            local Main = CF(Camera.CFrame.p, AimlockTarget.Character[PuppySettings.Aimbot.Hitboxes].Position + AimlockTarget.Character[PuppySettings.Aimbot.Hitboxes].Velocity/PuppySettings.AimbotSettings.PredictionVelocity)
                            
                            --// Making it work \\--
                            Camera.CFrame = Camera.CFrame:Lerp(Main, PuppySettings.AimbotSettings.SmoothnessAmmount, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut)
                        else
                            Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[PuppySettings.Aimbot.Hitboxes].Position + AimlockTarget.Character[PuppySettings.Aimbot.Hitboxes].Velocity/PuppySettings.AimbotSettings.PredictionVelocity)
                        end
                    elseif PuppySettings.Aimbot.Prediction == false then 
                        if PuppySettings.AimbotSettings.Smoothness == true then
                            local Main = CF(Camera.CFrame.p, AimlockTarget.Character[PuppySettings.Aimbot.Hitboxes].Position)
                            Camera.CFrame = Camera.CFrame:Lerp(Main,  PuppySettings.AimbotSettings.SmoothnessAmmount, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut)
                        else
                            Camera.CFrame = CF(Camera.CFrame.p, AimlockTarget.Character[PuppySettings.Aimbot.Hitboxes].Position)
                        end
                    end
                end
            end
        end
    end
end	
end)
