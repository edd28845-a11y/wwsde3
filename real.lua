local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local state = {
	password = "onyxontop!",
	authenticated = false,
	minimized = false,
	visible = true,
	activeTab = "Homepage",
	accent = Color3.fromRGB(220, 220, 230),
	logoMode = "sparkle",
	logoText = "",
	titleText = "onyx",
	watermarkEnabled = false,
	watermarkText = "onyx",
	watermarkColor = Color3.fromRGB(220, 220, 230),
	watermarkFont = Enum.Font.GothamSemibold,
	watermarkSize = Vector2.new(260, 30),
	watermarkPosition = UDim2.new(1, -276, 0, 12),
	watermarkDragging = false,
	watermarkResizing = false,
	watermarkDragStart = nil,
	watermarkStartPosition = nil,
	watermarkStartSize = nil,
	crosshairEnabled = false,
	crosshairShape = "cross",
	crosshairColor = Color3.fromRGB(220, 220, 230),
	crosshairSize = 18,
	crosshairThickness = 2,
	panelWidth = 640,
	panelHeight = 500,
	panelTransparency = 0,
	typedPassword = "",
	dragging = false,
	dragStart = nil,
	startPosition = nil,
	spinnerConnection = nil,
	-- Movement settings
	movementEnabled = false,
	walkSpeed = 16,
	jumpPower = 50,
	infiniteJump = false,
	-- Visuals settings
	fov = 70,
	espEnabled = false,
	espBoxes = false,
	espNames = false,
	espDistance = false,
	espHealth = false,
	espTracers = false,
	espColor = Color3.fromRGB(255, 255, 255),
	espTeamCheck = false,
	espMaxDistance = 1000,
	-- Aim settings
	aimEnabled = false,
	aimRequireKey = true,
	aimKey = Enum.UserInputType.MouseButton2,
	aimKeyString = "MouseButton2",
	aimPart = "Head",
	aimSmoothness = 0.05,
	aimFOV = 100,
	aimShowFOV = true,
	aimWallCheck = true,
	aimTeamCheck = false,
	aimStickyAim = false,
	aimPrediction = 0.065,
	aimHealthCheck = false,
	aimMinHealth = 0,
	aimFOVColor = Color3.fromRGB(255, 0, 0),
	aimTargetedFOVColor = Color3.fromRGB(0, 255, 0),
	aimRainbowFOV = false,
	aimRainbowSpeed = 0.005,
	aimRainbowHue = 0,
	aiming = false,
	currentTarget = nil,
	currentTargetPart = nil,
	aimSubtle = false,
	aimSubtleStrength = 0.92
}

local theme = {
	backdrop = Color3.fromRGB(0, 0, 0),
	panel = Color3.fromRGB(12, 12, 15),
	panelTop = Color3.fromRGB(21, 21, 26),
	sidebar = Color3.fromRGB(16, 16, 20),
	field = Color3.fromRGB(8, 8, 11),
	card = Color3.fromRGB(19, 19, 24),
	card2 = Color3.fromRGB(25, 25, 31),
	stroke = Color3.fromRGB(68, 68, 78),
	text = Color3.fromRGB(246, 246, 249),
	muted = Color3.fromRGB(158, 158, 168),
	error = Color3.fromRGB(255, 112, 112),
	success = Color3.fromRGB(128, 224, 174)
}

local accentColors = {
	Color3.fromRGB(220, 220, 230),
	Color3.fromRGB(144, 180, 255),
	Color3.fromRGB(125, 224, 174),
	Color3.fromRGB(220, 150, 255),
	Color3.fromRGB(255, 192, 120),
	Color3.fromRGB(255, 124, 124)
}

local watermarkColors = {
	Color3.fromRGB(220, 220, 230),
	Color3.fromRGB(255, 255, 255),
	Color3.fromRGB(150, 180, 255),
	Color3.fromRGB(134, 235, 185),
	Color3.fromRGB(245, 155, 255),
	Color3.fromRGB(255, 204, 128)
}

local crosshairColors = {
	Color3.fromRGB(220, 220, 230),
	Color3.fromRGB(255, 255, 255),
	Color3.fromRGB(116, 190, 255),
	Color3.fromRGB(118, 240, 172),
	Color3.fromRGB(255, 115, 115),
	Color3.fromRGB(255, 224, 130)
}

local espColors = {
	Color3.fromRGB(255, 255, 255),
	Color3.fromRGB(255, 100, 100),
	Color3.fromRGB(100, 255, 100),
	Color3.fromRGB(100, 150, 255),
	Color3.fromRGB(255, 255, 100),
	Color3.fromRGB(255, 100, 255)
}

local aimPartOptions = {
	"Head",
	"HumanoidRootPart",
	"UpperTorso",
	"LowerTorso",
	"LeftUpperArm",
	"RightUpperArm",
	"LeftUpperLeg",
	"RightUpperLeg"
}

local watermarkFonts = {
	{ label = "GOTHAM", value = Enum.Font.GothamSemibold },
	{ label = "BLACK", value = Enum.Font.GothamBlack },
	{ label = "SOURCE", value = Enum.Font.SourceSansBold },
	{ label = "CODE", value = Enum.Font.Code },
	{ label = "SCIFI", value = Enum.Font.SciFi },
	{ label = "FANTASY", value = Enum.Font.Fantasy }
}

local screenGui
local panel
local backdrop
local body
local authView
local appView
local statusTitle
local statusText
local passwordInput
local submitButton
local spinner
local sidebarButtons = {}
local contentFrame
local watermarkLabel
local accentPreview
local watermarkToggle
local watermarkInput
local newPasswordInput
local logoInput
local titleInput
local logoTextLabel
local logoFrame
local titleLabel
local watermarkResizeHandle
local panelScale
local watermarkColorPreview
local setInterfaceVisible
local crosshairFrame
local crosshairToggle
local crosshairColorPreview
local crosshairSizeInput
local crosshairThicknessInput
local panelWidthInput
local panelHeightInput
local panelTransparencyInput
local movementToggle
local walkSpeedInput
local jumpPowerInput
local infiniteJumpToggle
local fovInput
local espToggle
local espColorPreview
local espMaxDistanceInput
local espContainer
local espObjects = {}
local espUpdateConnection
local aimFOVCircle
local aimTargetHighlight
local aimSubtleToggle
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera

-- Infinite jump state
local jumpConnection
local currentVelocity = Vector3.zero

local function create(className, props, children)
	local item = Instance.new(className)
	for key, value in pairs(props or {}) do
		item[key] = value
	end
	for _, child in ipairs(children or {}) do
		child.Parent = item
	end
	return item
end

local function corner(parent, radius)
	return create("UICorner", {
		CornerRadius = UDim.new(0, radius or 12),
		Parent = parent
	})
end

local function stroke(parent, color, transparency)
	return create("UIStroke", {
		Color = color or theme.stroke,
		Transparency = transparency or 0.25,
		Thickness = 1,
		Parent = parent
	})
end

local function tween(item, duration, props)
	local animation = TweenService:Create(item, TweenInfo.new(duration, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props)
	animation:Play()
	return animation
end

local function clearChildren(parent)
	for _, child in ipairs(parent:GetChildren()) do
		if not child:IsA("UICorner") and not child:IsA("UIStroke") and not child:IsA("UIScale") then
			child:Destroy()
		end
	end
end

local function sparkleLine(parent, position, size, rotation)
	local line = create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = position,
		Size = size,
		Rotation = rotation,
		BackgroundColor3 = state.accent,
		BorderSizePixel = 0,
		Parent = parent
	})
	corner(line, 2)
	return line
end

local function drawSparkle(parent)
	clearChildren(parent)
	sparkleLine(parent, UDim2.fromScale(0.5, 0.5), UDim2.fromOffset(2, 19), 0)
	sparkleLine(parent, UDim2.fromScale(0.5, 0.5), UDim2.fromOffset(19, 2), 0)
	sparkleLine(parent, UDim2.fromScale(0.5, 0.5), UDim2.fromOffset(14, 2), 45)
	sparkleLine(parent, UDim2.fromScale(0.5, 0.5), UDim2.fromOffset(14, 2), -45)
end

local function drawCrosshair()
	if not crosshairFrame then return end
	clearChildren(crosshairFrame)
	crosshairFrame.Visible = state.crosshairEnabled
	crosshairFrame.Size = UDim2.fromOffset(state.crosshairSize * 2, state.crosshairSize * 2)
	local center = state.crosshairSize
	local thickness = state.crosshairThickness
	local color = state.crosshairColor
	local function segment(name, position, size, rotation)
		local part = create("Frame", {
			Name = name,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = position,
			Size = size,
			Rotation = rotation or 0,
			BackgroundColor3 = color,
			BorderSizePixel = 0,
			Parent = crosshairFrame
		})
		corner(part, math.max(2, thickness))
	end
	if state.crosshairShape == "dot" then
		segment("Dot", UDim2.fromOffset(center, center), UDim2.fromOffset(math.max(thickness * 2, 4), math.max(thickness * 2, 4)))
	elseif state.crosshairShape == "circle" then
		local ring = create("Frame", {
			Name = "Circle",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromOffset(center, center),
			Size = UDim2.fromOffset(state.crosshairSize, state.crosshairSize),
			BackgroundTransparency = 1,
			Parent = crosshairFrame
		})
		corner(ring, state.crosshairSize)
		stroke(ring, color, 0)
		ring.UIStroke.Thickness = thickness
	else
		local length = math.max(6, math.floor(state.crosshairSize * 0.62))
		local gap = math.max(3, math.floor(state.crosshairSize * 0.22))
		segment("Top", UDim2.fromOffset(center, center - gap - (length / 2)), UDim2.fromOffset(thickness, length))
		segment("Bottom", UDim2.fromOffset(center, center + gap + (length / 2)), UDim2.fromOffset(thickness, length))
		segment("Left", UDim2.fromOffset(center - gap - (length / 2), center), UDim2.fromOffset(length, thickness))
		segment("Right", UDim2.fromOffset(center + gap + (length / 2), center), UDim2.fromOffset(length, thickness))
	end
	if crosshairToggle then
		crosshairToggle.Text = state.crosshairEnabled and "CROSSHAIR: ENABLED" or "CROSSHAIR: DISABLED"
		crosshairToggle.BackgroundColor3 = state.crosshairEnabled and state.accent or theme.card2
		crosshairToggle.TextColor3 = state.crosshairEnabled and Color3.fromRGB(8, 8, 11) or theme.text
	end
	if crosshairColorPreview then
		crosshairColorPreview.BackgroundColor3 = state.crosshairColor
	end
end

local function trim(value)
	return tostring(value or ""):gsub("^%s+", ""):gsub("%s+$", "")
end

local function openPanelSize()
	return UDim2.fromOffset(state.panelWidth, state.panelHeight)
end

local function authPanelSize()
	return UDim2.fromOffset(430, 320)
end

local function applyPanelStyle()
	if panel then panel.BackgroundTransparency = state.panelTransparency end
end

local function getGameName()
	local ok, info = pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId) end)
	if ok and typeof(info) == "table" and typeof(info.Name) == "string" and info.Name ~= "" then return info.Name end
	return game.Name ~= "" and game.Name or "Unknown experience"
end

local function shortJobId()
	if game.JobId == "" then return "Studio session" end
	return string.sub(game.JobId, 1, 8)
end

local function getDeviceText()
	if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then return "Touch" end
	if UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled then return "Gamepad" end
	return "Keyboard and mouse"
end

local function updatePanelScale()
	if not panelScale then return end
	local cam = workspace.CurrentCamera
	if not cam then panelScale.Scale = 1; return end
	local viewport = cam.ViewportSize
	local scale = math.min(1, (viewport.X - 24) / math.max(state.panelWidth, 430), (viewport.Y - 24) / math.max(state.panelHeight, 320))
	panelScale.Scale = math.clamp(scale, 0.68, 1)
end

local function startSpinner()
	if state.spinnerConnection then state.spinnerConnection:Disconnect() end
	state.spinnerConnection = RunService.RenderStepped:Connect(function(delta)
		if spinner and spinner.Visible then spinner.Rotation = (spinner.Rotation + delta * 360) % 360 end
	end)
end

local function stopSpinner()
	if state.spinnerConnection then state.spinnerConnection:Disconnect(); state.spinnerConnection = nil end
end

local function setStatus(kind, heading, message)
	statusTitle.Text = heading
	statusText.Text = message
	spinner.Visible = kind == "loading"
	statusTitle.Position = kind == "loading" and UDim2.fromOffset(54, 8) or UDim2.fromOffset(16, 8)
	statusText.Position = kind == "loading" and UDim2.fromOffset(54, 30) or UDim2.fromOffset(16, 30)
	if kind == "error" then
		statusTitle.TextColor3 = theme.error
		statusTitle.Parent.UIStroke.Color = theme.error
	elseif kind == "success" then
		statusTitle.TextColor3 = theme.success
		statusTitle.Parent.UIStroke.Color = theme.success
	elseif kind == "loading" then
		statusTitle.TextColor3 = state.accent
		statusTitle.Parent.UIStroke.Color = state.accent
	else
		statusTitle.TextColor3 = theme.text
		statusTitle.Parent.UIStroke.Color = theme.stroke
	end
end

local function clearContent()
	for _, child in ipairs(contentFrame:GetChildren()) do child:Destroy() end
end

local function statRow(label, value, order)
	local row = create("Frame", {
		Name = label:gsub("%s+", "") .. "Row",
		Size = UDim2.new(1, -14, 0, 52),
		BackgroundColor3 = theme.card,
		BorderSizePixel = 0,
		LayoutOrder = order,
		Parent = contentFrame
	})
	corner(row, 12)
	stroke(row, theme.stroke, 0.55)
	create("TextLabel", {
		Position = UDim2.fromOffset(14, 8),
		Size = UDim2.new(1, -28, 0, 15),
		BackgroundTransparency = 1,
		Text = label,
		TextColor3 = theme.muted,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		Parent = row
	})
	create("TextLabel", {
		Position = UDim2.fromOffset(14, 26),
		Size = UDim2.new(1, -28, 0, 18),
		BackgroundTransparency = 1,
		Text = tostring(value),
		TextColor3 = theme.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Font = Enum.Font.GothamSemibold,
		TextSize = 14,
		Parent = row
	})
end

local function renderHomepage()
	clearContent()
	create("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = contentFrame })
	create("UIPadding", { PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 16), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 12), Parent = contentFrame })
	statRow("Display name", player.DisplayName, 1)
	statRow("Username", "@" .. player.Name, 2)
	statRow("User ID", player.UserId, 3)
	statRow("Account age", tostring(player.AccountAge) .. " days", 4)
	statRow("Membership", player.MembershipType.Name, 5)
	statRow("Current game", getGameName(), 6)
	statRow("Place ID", game.PlaceId, 7)
	statRow("Server", shortJobId(), 8)
	statRow("Input device", getDeviceText(), 9)
	statRow("Team", player.Team and player.Team.Name or "None", 10)
	statRow("Walk Speed", state.movementEnabled and tostring(state.walkSpeed) or "Default", 11)
	statRow("Jump Power", state.movementEnabled and tostring(state.jumpPower) or "Default", 12)
	statRow("Infinite Jump", state.infiniteJump and "Enabled" or "Disabled", 13)
	statRow("FOV", tostring(state.fov), 14)
	statRow("ESP Active", state.espEnabled and "Yes" or "No", 15)
	statRow("Aimbot Active", state.aimEnabled and "Yes" or "No", 16)
end

local function applyWatermark()
	if watermarkLabel then
		watermarkLabel.Visible = state.watermarkEnabled
		watermarkLabel.Text = state.watermarkText
		watermarkLabel.TextColor3 = state.watermarkColor
		watermarkLabel.Font = state.watermarkFont
		watermarkLabel.Position = state.watermarkPosition
		watermarkLabel.Size = UDim2.fromOffset(state.watermarkSize.X, state.watermarkSize.Y)
		watermarkLabel.TextSize = math.clamp(math.floor(state.watermarkSize.Y * 0.58), 12, 56)
	end
	if watermarkResizeHandle then
		watermarkResizeHandle.Visible = state.watermarkEnabled
		watermarkResizeHandle.BackgroundTransparency = 1
	end
	if watermarkColorPreview then watermarkColorPreview.BackgroundColor3 = state.watermarkColor end
	if watermarkToggle then
		watermarkToggle.Text = state.watermarkEnabled and "WATERMARK: ENABLED" or "WATERMARK: DISABLED"
		watermarkToggle.BackgroundColor3 = state.watermarkEnabled and state.accent or theme.card2
		watermarkToggle.TextColor3 = state.watermarkEnabled and Color3.fromRGB(8, 8, 11) or theme.text
	end
end

local function applyBranding()
	local logo = trim(state.logoText)
	local title = trim(state.titleText)
	if logo == "" or string.lower(logo) == "sparkle" then state.logoMode = "sparkle" else state.logoMode = "text" end
	if title == "" then title = "onyx" end
	state.logoText = state.logoMode == "sparkle" and "" or string.sub(logo, 1, 3)
	state.titleText = title
	if logoFrame then
		if state.logoMode == "sparkle" then logoTextLabel = nil; drawSparkle(logoFrame)
		else
			clearChildren(logoFrame)
			logoTextLabel = create("TextLabel", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = state.logoText, TextColor3 = state.accent, TextScaled = true, Font = Enum.Font.GothamSemibold, Parent = logoFrame })
		end
	end
	if titleLabel then titleLabel.Text = state.titleText end
end

local function applyAccent()
	if accentPreview then accentPreview.BackgroundColor3 = state.accent end
	for _, button in pairs(sidebarButtons) do
		local active = button.Name == state.activeTab .. "Tab"
		tween(button, 0.18, { BackgroundColor3 = active and state.accent or Color3.fromRGB(24, 24, 30), TextColor3 = active and Color3.fromRGB(8, 8, 11) or theme.text })
	end
	submitButton.BackgroundColor3 = state.accent
	applyBranding()
	applyWatermark()
	drawCrosshair()
end

local function setupInfiniteJump()
	if jumpConnection then
		jumpConnection:Disconnect()
		jumpConnection = nil
	end
	
	if state.infiniteJump then
		jumpConnection = UserInputService.JumpRequest:Connect(function()
			local character = player.Character
			if character then
				local humanoid = character:FindFirstChildOfClass("Humanoid")
				if humanoid and humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
					local rootPart = character:FindFirstChild("HumanoidRootPart")
					if rootPart then
						-- Only allow jump if not already jumping upward too fast
						local verticalVelocity = rootPart.Velocity.Y
						if verticalVelocity < state.jumpPower * 0.5 then
							rootPart.Velocity = Vector3.new(rootPart.Velocity.X, state.jumpPower, rootPart.Velocity.Z)
						end
					end
				end
			end
		end)
	end
end

local function applyMovement()
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			if state.movementEnabled then 
				humanoid.WalkSpeed = state.walkSpeed
				humanoid.JumpPower = state.jumpPower
			else 
				humanoid.WalkSpeed = 16
				humanoid.JumpPower = 50
			end
		end
	end
	setupInfiniteJump()
	
	if movementToggle then
		movementToggle.Text = state.movementEnabled and "MOVEMENT: ENABLED" or "MOVEMENT: DISABLED"
		movementToggle.BackgroundColor3 = state.movementEnabled and state.accent or theme.card2
		movementToggle.TextColor3 = state.movementEnabled and Color3.fromRGB(8, 8, 11) or theme.text
	end
	if infiniteJumpToggle then
		infiniteJumpToggle.Text = state.infiniteJump and "INFINITE JUMP: ON" or "INFINITE JUMP: OFF"
		infiniteJumpToggle.BackgroundColor3 = state.infiniteJump and state.accent or theme.card2
		infiniteJumpToggle.TextColor3 = state.infiniteJump and Color3.fromRGB(8, 8, 11) or theme.text
	end
end

local function applyFOV()
	local cam = workspace.CurrentCamera
	if cam then cam.FieldOfView = state.fov end
end

local function checkWall(targetCharacter)
	local cam = workspace.CurrentCamera
	if not cam then return true end
	local targetHead = targetCharacter:FindFirstChild("Head")
	if not targetHead then return true end
	local origin = cam.CFrame.Position
	local direction = (targetHead.Position - origin).Unit * (targetHead.Position - origin).Magnitude
	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = {player.Character, targetCharacter}
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	local raycastResult = workspace:Raycast(origin, direction, raycastParams)
	return raycastResult and raycastResult.Instance ~= nil
end

local function getClosestPart(character)
	local cam = workspace.CurrentCamera
	if not cam then return nil end
	local closestPart = nil
	local shortestCursorDistance = state.aimFOV
	for _, partName in ipairs({state.aimPart}) do
		local part = character:FindFirstChild(partName)
		if part then
			local partPos = cam:WorldToViewportPoint(part.Position)
			local screenPos = Vector2.new(partPos.X, partPos.Y)
			local cursorDistance = (screenPos - Vector2.new(mouse.X, mouse.Y)).Magnitude
			if cursorDistance < shortestCursorDistance and partPos.Z > 0 then
				shortestCursorDistance = cursorDistance
				closestPart = part
			end
		end
	end
	return closestPart
end

local function getTarget()
	local cam = workspace.CurrentCamera
	if not cam then return nil, nil end
	local nearestPlayer = nil
	local closestPart = nil
	local shortestCursorDistance = state.aimFOV
	for _, target in ipairs(Players:GetPlayers()) do
		if target ~= player and target.Character then
			if state.aimTeamCheck and target.Team == player.Team then continue end
			local humanoid = target.Character:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.Health > 0 then
				if state.aimHealthCheck and humanoid.Health < state.aimMinHealth then continue end
				local targetPart = getClosestPart(target.Character)
				if targetPart then
					local screenPos = cam:WorldToViewportPoint(targetPart.Position)
					local cursorDistance = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
					if cursorDistance < shortestCursorDistance then
						if not state.aimWallCheck or not checkWall(target.Character) then
							shortestCursorDistance = cursorDistance
							nearestPlayer = target
							closestPart = targetPart
						end
					end
				end
			end
		end
	end
	return nearestPlayer, closestPart
end

local function predict(targetPart)
	if not targetPart then return nil end
	local character = targetPart.Parent
	if not character then return nil end
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return targetPart.Position end
	local velocity = rootPart.Velocity
	return targetPart.Position + (velocity * state.aimPrediction)
end

local function updateAim()
	local cam = workspace.CurrentCamera
	if not cam then return end

	if state.aimEnabled then
		if state.aimShowFOV then
			if not aimFOVCircle then
				aimFOVCircle = Drawing.new("Circle")
				aimFOVCircle.Thickness = 2
				aimFOVCircle.Filled = false
				aimFOVCircle.Visible = false
			end
			aimFOVCircle.Visible = true
			aimFOVCircle.Radius = state.aimFOV
			aimFOVCircle.Position = Vector2.new(mouse.X, mouse.Y + 36)
			
			if state.aimRainbowFOV then
				state.aimRainbowHue = state.aimRainbowHue + state.aimRainbowSpeed
				if state.aimRainbowHue > 1 then state.aimRainbowHue = 0 end
				aimFOVCircle.Color = Color3.fromHSV(state.aimRainbowHue, 1, 1)
			else
				aimFOVCircle.Color = state.aiming and state.currentTarget and state.aimTargetedFOVColor or state.aimFOVColor
			end
		else
			if aimFOVCircle then aimFOVCircle.Visible = false end
		end

		if state.aiming then
			if state.aimStickyAim and state.currentTarget and state.currentTarget.Character then
				local head = state.currentTarget.Character:FindFirstChild("Head")
				if head then
					local headPos = cam:WorldToViewportPoint(head.Position)
					local screenPos = Vector2.new(headPos.X, headPos.Y)
					local cursorDistance = (screenPos - Vector2.new(mouse.X, mouse.Y)).Magnitude
					if cursorDistance > state.aimFOV or (state.aimWallCheck and checkWall(state.currentTarget.Character)) then
						state.currentTarget = nil
						state.currentTargetPart = nil
					end
				else
					state.currentTarget = nil
					state.currentTargetPart = nil
				end
			end

			if not state.aimStickyAim or not state.currentTarget then
				local target, targetPart = getTarget()
				state.currentTarget = target
				state.currentTargetPart = targetPart
			end

			if state.currentTarget and state.currentTargetPart then
				local predictedPosition = predict(state.currentTargetPart)
				if predictedPosition then
					local targetCFrame = CFrame.new(cam.CFrame.Position, predictedPosition)
					
					if state.aimSubtle then
						-- Ultra-subtle aim: extremely smooth, almost imperceptible movement
						local currentLook = cam.CFrame.LookVector
						local targetLook = targetCFrame.LookVector
						local interpolatedLook = currentLook:Lerp(targetLook, 1 - state.aimSubtleStrength)
						cam.CFrame = CFrame.new(cam.CFrame.Position, cam.CFrame.Position + interpolatedLook)
					else
						-- Normal aim with configurable smoothness
						cam.CFrame = cam.CFrame:Lerp(targetCFrame, 1 - state.aimSmoothness)
					end
				end
			end
		else
			state.currentTarget = nil
			state.currentTargetPart = nil
		end
	else
		if aimFOVCircle then aimFOVCircle.Visible = false end
		state.currentTarget = nil
		state.currentTargetPart = nil
	end
end

local function cleanupESPForPlayer(userId)
	if espObjects[userId] then
		for _, obj in pairs(espObjects[userId]) do
			if obj then obj:Destroy() end
		end
		espObjects[userId] = nil
	end
end

local function updateESP()
	if espUpdateConnection then espUpdateConnection:Disconnect(); espUpdateConnection = nil end
	for userId, playerESP in pairs(espObjects) do
		for _, obj in pairs(playerESP) do if obj then obj:Destroy() end end
	end
	espObjects = {}
	if espContainer then espContainer:Destroy(); espContainer = nil end
	if not state.espEnabled then return end
	
	espContainer = create("ScreenGui", { Name = "ESPContainer", ResetOnSpawn = false, Parent = playerGui })
	
	espUpdateConnection = RunService.RenderStepped:Connect(function()
		local cam = workspace.CurrentCamera
		if not cam then return end
		for userId, _ in pairs(espObjects) do
			if not Players:GetPlayerByUserId(userId) then cleanupESPForPlayer(userId) end
		end
		for _, target in ipairs(Players:GetPlayers()) do
			if target == player then continue end
			if state.espTeamCheck and target.Team == player.Team then continue end
			local character = target.Character
			if not character then cleanupESPForPlayer(target.UserId); continue end
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			local rootPart = character:FindFirstChild("HumanoidRootPart")
			if not humanoid or not rootPart then cleanupESPForPlayer(target.UserId); continue end
			if humanoid.Health <= 0 then cleanupESPForPlayer(target.UserId); continue end
			
			local position, onScreen = cam:WorldToViewportPoint(rootPart.Position)
			if not onScreen then
				if espObjects[target.UserId] then for _, obj in pairs(espObjects[target.UserId]) do if obj then obj.Visible = false end end end
				continue
			end
			local distance = (cam.CFrame.Position - rootPart.Position).Magnitude
			if distance > state.espMaxDistance then
				if espObjects[target.UserId] then for _, obj in pairs(espObjects[target.UserId]) do if obj then obj.Visible = false end end end
				continue
			end
			if not espObjects[target.UserId] then espObjects[target.UserId] = {} end
			
			if state.espBoxes then
				local box = espObjects[target.UserId].box
				if not box or not box.Parent then
					box = create("Frame", { BackgroundTransparency = 1, BorderSizePixel = 0, Parent = espContainer })
					create("Frame", { Size = UDim2.new(1, 2, 0, 1), BackgroundColor3 = state.espColor, BorderSizePixel = 0, Parent = box })
					create("Frame", { Position = UDim2.new(0, 0, 1, 0), Size = UDim2.new(1, 2, 0, 1), BackgroundColor3 = state.espColor, BorderSizePixel = 0, Parent = box })
					create("Frame", { Size = UDim2.new(0, 1, 1, 0), BackgroundColor3 = state.espColor, BorderSizePixel = 0, Parent = box })
					create("Frame", { Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 1, 1, 0), BackgroundColor3 = state.espColor, BorderSizePixel = 0, Parent = box })
					espObjects[target.UserId].box = box
				end
				local head = character:FindFirstChild("Head")
				local height = head and (head.Position.Y - rootPart.Position.Y) * 2 or 5
				local topPos = cam:WorldToViewportPoint(rootPart.Position + Vector3.new(0, height, 0))
				local bottomPos = cam:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 3, 0))
				local boxHeight = math.abs(topPos.Y - bottomPos.Y)
				local boxWidth = boxHeight * 0.6
				box.Position = UDim2.fromOffset(position.X - boxWidth / 2, topPos.Y)
				box.Size = UDim2.fromOffset(boxWidth, boxHeight)
				box.Visible = true
			elseif espObjects[target.UserId].box then espObjects[target.UserId].box.Visible = false end
			
			if state.espNames then
				local nameLabel = espObjects[target.UserId].nameLabel
				if not nameLabel or not nameLabel.Parent then
					nameLabel = create("TextLabel", { BackgroundTransparency = 1, TextColor3 = state.espColor, Font = Enum.Font.GothamSemibold, TextSize = 14, TextStrokeTransparency = 0, Parent = espContainer })
					espObjects[target.UserId] = espObjects[target.UserId] or {}
					espObjects[target.UserId].nameLabel = nameLabel
				end
				nameLabel.Text = target.DisplayName
				nameLabel.Position = UDim2.fromOffset(position.X, position.Y - 30)
				nameLabel.Visible = true
			elseif espObjects[target.UserId].nameLabel then espObjects[target.UserId].nameLabel.Visible = false end
			
			if state.espDistance then
				local distLabel = espObjects[target.UserId].distLabel
				if not distLabel or not distLabel.Parent then
					distLabel = create("TextLabel", { BackgroundTransparency = 1, TextColor3 = state.espColor, Font = Enum.Font.Gotham, TextSize = 12, TextStrokeTransparency = 0, Parent = espContainer })
					espObjects[target.UserId] = espObjects[target.UserId] or {}
					espObjects[target.UserId].distLabel = distLabel
				end
				distLabel.Text = math.floor(distance) .. " studs"
				distLabel.Position = UDim2.fromOffset(position.X, position.Y - 15)
				distLabel.Visible = true
			elseif espObjects[target.UserId].distLabel then espObjects[target.UserId].distLabel.Visible = false end
			
			if state.espHealth and humanoid.Health > 0 then
				local healthBar = espObjects[target.UserId].healthBar
				local healthFill = espObjects[target.UserId].healthFill
				if not healthBar or not healthBar.Parent then
					healthBar = create("Frame", { BackgroundColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Parent = espContainer })
					healthFill = create("Frame", { BackgroundColor3 = Color3.fromRGB(0, 255, 0), BorderSizePixel = 0, Parent = healthBar })
					espObjects[target.UserId] = espObjects[target.UserId] or {}
					espObjects[target.UserId].healthBar = healthBar
					espObjects[target.UserId].healthFill = healthFill
				end
				local head = character:FindFirstChild("Head")
				local height = head and (head.Position.Y - rootPart.Position.Y) * 2 or 5
				local topPos = cam:WorldToViewportPoint(rootPart.Position + Vector3.new(0, height, 0))
				healthBar.Position = UDim2.fromOffset(position.X - 30, topPos.Y)
				healthBar.Size = UDim2.fromOffset(4, 100)
				healthFill.Size = UDim2.new(1, 0, humanoid.Health / humanoid.MaxHealth, 0)
				healthBar.Visible = true
			elseif espObjects[target.UserId].healthBar then espObjects[target.UserId].healthBar.Visible = false end
			
			if state.espTracers then
				local tracer = espObjects[target.UserId].tracer
				if not tracer or not tracer.Parent then
					tracer = create("Frame", { BackgroundColor3 = state.espColor, BorderSizePixel = 0, Parent = espContainer })
					espObjects[target.UserId] = espObjects[target.UserId] or {}
					espObjects[target.UserId].tracer = tracer
				end
				local screenCenter = cam.ViewportSize / 2
				local dx = position.X - screenCenter.X
				local dy = position.Y - screenCenter.Y
				local length = math.sqrt(dx * dx + dy * dy)
				local angle = math.deg(math.atan2(dy, dx))
				tracer.Position = UDim2.fromOffset(screenCenter.X, screenCenter.Y)
				tracer.Size = UDim2.fromOffset(length, 1)
				tracer.Rotation = angle
				tracer.AnchorPoint = Vector2.new(0, 0.5)
				tracer.Visible = true
			elseif espObjects[target.UserId].tracer then espObjects[target.UserId].tracer.Visible = false end
		end
	end)
end

local function textInput(name, placeholder, parent)
	local shell = create("Frame", { Name = name .. "Shell", Size = UDim2.new(1, 0, 0, 44), BackgroundColor3 = theme.field, BorderSizePixel = 0, Parent = parent })
	corner(shell, 14)
	stroke(shell, theme.stroke, 0.35)
	local input = create("TextBox", { Name = name, Position = UDim2.fromOffset(14, 0), Size = UDim2.new(1, -28, 1, 0), BackgroundTransparency = 1, ClearTextOnFocus = false, PlaceholderText = placeholder, Text = "", TextColor3 = theme.text, PlaceholderColor3 = Color3.fromRGB(116, 116, 126), TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.Gotham, TextSize = 14, Parent = shell })
	input.Focused:Connect(function() shell.UIStroke.Color = state.accent; shell.UIStroke.Transparency = 0 end)
	input.FocusLost:Connect(function() shell.UIStroke.Color = theme.stroke; shell.UIStroke.Transparency = 0.35 end)
	return input, shell
end

local function settingsButton(label, parent)
	local button = create("TextButton", { Size = UDim2.new(1, -14, 0, 42), BackgroundColor3 = theme.card2, AutoButtonColor = false, Text = label, TextColor3 = theme.text, Font = Enum.Font.GothamSemibold, TextSize = 13, Parent = parent })
	corner(button, 14)
	stroke(button, theme.stroke, 0.55)
	button.MouseEnter:Connect(function() tween(button, 0.15, { BackgroundColor3 = Color3.fromRGB(34, 34, 42) }) end)
	button.MouseLeave:Connect(function() tween(button, 0.15, { BackgroundColor3 = theme.card2 }) end)
	return button
end

local function sectionHeader(title, detail, parent)
	local section = create("Frame", { Size = UDim2.new(1, -14, 0, detail and 54 or 32), BackgroundTransparency = 1, Parent = parent })
	create("TextLabel", { Position = UDim2.fromOffset(2, 2), Size = UDim2.new(1, -4, 0, 20), BackgroundTransparency = 1, Text = title, TextColor3 = theme.text, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamSemibold, TextSize = 15, Parent = section })
	if detail then
		create("TextLabel", { Position = UDim2.fromOffset(2, 24), Size = UDim2.new(1, -4, 0, 24), BackgroundTransparency = 1, Text = detail, TextColor3 = theme.muted, TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true, Font = Enum.Font.Gotham, TextSize = 12, Parent = section })
	end
	return section
end

local function labeledInput(label, placeholder, parent)
	local wrapper = create("Frame", { Size = UDim2.new(1, -14, 0, 68), BackgroundTransparency = 1, Parent = parent })
	create("TextLabel", { Size = UDim2.new(1, 0, 0, 18), BackgroundTransparency = 1, Text = label, TextColor3 = theme.muted, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamSemibold, TextSize = 12, Parent = wrapper })
	local input = textInput(label:gsub("%s+", ""), placeholder, wrapper)
	input.Parent.Position = UDim2.fromOffset(0, 24)
	return input
end

local function renderMovement()
	clearContent()
	create("UIListLayout", { Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder, Parent = contentFrame })
	create("UIPadding", { PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 16), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 12), Parent = contentFrame })
	sectionHeader("movement", "Enable custom movement speed, jump power, and infinite jump for your character.", contentFrame)
	movementToggle = settingsButton("MOVEMENT: DISABLED", contentFrame)
	walkSpeedInput = labeledInput("walk speed", "Walk speed (16-200)", contentFrame)
	walkSpeedInput.Text = tostring(state.walkSpeed)
	jumpPowerInput = labeledInput("jump power", "Jump power (50-500)", contentFrame)
	jumpPowerInput.Text = tostring(state.jumpPower)
	infiniteJumpToggle = settingsButton("INFINITE JUMP: OFF", contentFrame)
	local saveMovement = settingsButton("APPLY MOVEMENT", contentFrame)
	movementToggle.MouseButton1Click:Connect(function() state.movementEnabled = not state.movementEnabled; applyMovement() end)
	infiniteJumpToggle.MouseButton1Click:Connect(function() state.infiniteJump = not state.infiniteJump; applyMovement() end)
	saveMovement.MouseButton1Click:Connect(function()
		local speed = tonumber(walkSpeedInput.Text)
		local jump = tonumber(jumpPowerInput.Text)
		state.walkSpeed = math.clamp(speed or state.walkSpeed, 16, 200)
		state.jumpPower = math.clamp(jump or state.jumpPower, 50, 500)
		walkSpeedInput.Text = tostring(state.walkSpeed)
		jumpPowerInput.Text = tostring(state.jumpPower)
		applyMovement()
	end)
	applyMovement()
end

local function renderVisuals()
	clearContent()
	create("UIListLayout", { Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder, Parent = contentFrame })
	create("UIPadding", { PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 16), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 12), Parent = contentFrame })
	sectionHeader("field of view", "Adjust the camera's field of view (30-120).", contentFrame)
	fovInput = labeledInput("field of view", "FOV (30-120)", contentFrame)
	fovInput.Text = tostring(state.fov)
	local saveFOV = settingsButton("APPLY FOV", contentFrame)
	saveFOV.MouseButton1Click:Connect(function()
		local fov = tonumber(fovInput.Text)
		state.fov = math.clamp(fov or state.fov, 30, 120)
		fovInput.Text = tostring(state.fov)
		applyFOV()
	end)
	
	sectionHeader("esp", "Enable and customize ESP features to see other players through walls.", contentFrame)
	espToggle = settingsButton("ESP: DISABLED", contentFrame)
	local espColorRow = create("Frame", { Size = UDim2.new(1, -14, 0, 92), BackgroundColor3 = theme.card, BorderSizePixel = 0, Parent = contentFrame })
	corner(espColorRow, 14)
	stroke(espColorRow, theme.stroke, 0.55)
	create("TextLabel", { Position = UDim2.fromOffset(14, 10), Size = UDim2.new(1, -28, 0, 20), BackgroundTransparency = 1, Text = "ESP Color", TextColor3 = theme.text, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamSemibold, TextSize = 14, Parent = espColorRow })
	espColorPreview = create("Frame", { Position = UDim2.fromOffset(14, 42), Size = UDim2.fromOffset(34, 34), BackgroundColor3 = state.espColor, BorderSizePixel = 0, Parent = espColorRow })
	corner(espColorPreview, 12)
	for index, color in ipairs(espColors) do
		local swatch = create("TextButton", { Position = UDim2.fromOffset(60 + ((index - 1) * 42), 42), Size = UDim2.fromOffset(34, 34), BackgroundColor3 = color, AutoButtonColor = false, Text = "", Parent = espColorRow })
		corner(swatch, 12)
		stroke(swatch, Color3.fromRGB(255, 255, 255), 0.75)
		swatch.MouseButton1Click:Connect(function() state.espColor = color; espColorPreview.BackgroundColor3 = color; updateESP() end)
	end
	
	local espFeaturesRow = create("Frame", { Size = UDim2.new(1, -14, 0, 180), BackgroundColor3 = theme.card, BorderSizePixel = 0, Parent = contentFrame })
	corner(espFeaturesRow, 14)
	stroke(espFeaturesRow, theme.stroke, 0.55)
	create("TextLabel", { Position = UDim2.fromOffset(14, 10), Size = UDim2.new(1, -28, 0, 20), BackgroundTransparency = 1, Text = "ESP Features", TextColor3 = theme.text, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamSemibold, TextSize = 14, Parent = espFeaturesRow })
	
	local function espCheckbox(text, key, yPos)
		local container = create("Frame", { Position = UDim2.fromOffset(14, yPos), Size = UDim2.new(1, -28, 0, 22), BackgroundTransparency = 1, Parent = espFeaturesRow })
		create("TextLabel", { Position = UDim2.fromOffset(0, 0), Size = UDim2.new(0.7, 0, 1, 0), BackgroundTransparency = 1, Text = text, TextColor3 = theme.text, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.Gotham, TextSize = 12, Parent = container })
		local button = create("TextButton", { Position = UDim2.new(1, -60, 0, 0), Size = UDim2.fromOffset(60, 22), BackgroundColor3 = state[key] and state.accent or theme.card2, AutoButtonColor = false, Text = state[key] and "ON" or "OFF", TextColor3 = state[key] and Color3.fromRGB(8, 8, 11) or theme.text, Font = Enum.Font.GothamSemibold, TextSize = 10, Parent = container })
		corner(button, 8)
		stroke(button, theme.stroke, 0.6)
		button.MouseButton1Click:Connect(function() state[key] = not state[key]; button.Text = state[key] and "ON" or "OFF"; button.BackgroundColor3 = state[key] and state.accent or theme.card2; button.TextColor3 = state[key] and Color3.fromRGB(8, 8, 11) or theme.text; updateESP() end)
	end
	espCheckbox("Boxes", "espBoxes", 38)
	espCheckbox("Names", "espNames", 66)
	espCheckbox("Distance", "espDistance", 94)
	espCheckbox("Health Bars", "espHealth", 122)
	espCheckbox("Tracers", "espTracers", 150)
	
	local teamCheckRow = create("Frame", { Size = UDim2.new(1, -14, 0, 48), BackgroundColor3 = theme.card, BorderSizePixel = 0, Parent = contentFrame })
	corner(teamCheckRow, 14)
	stroke(teamCheckRow, theme.stroke, 0.55)
	local teamCheckButton = create("TextButton", { Position = UDim2.fromOffset(14, 10), Size = UDim2.new(1, -28, 0, 28), BackgroundColor3 = state.espTeamCheck and state.accent or theme.card2, AutoButtonColor = false, Text = "Team Check: " .. (state.espTeamCheck and "ON" or "OFF"), TextColor3 = state.espTeamCheck and Color3.fromRGB(8, 8, 11) or theme.text, Font = Enum.Font.GothamSemibold, TextSize = 12, Parent = teamCheckRow })
	corner(teamCheckButton, 10)
	stroke(teamCheckButton, theme.stroke, 0.6)
	teamCheckButton.MouseButton1Click:Connect(function() state.espTeamCheck = not state.espTeamCheck; teamCheckButton.Text = "Team Check: " .. (state.espTeamCheck and "ON" or "OFF"); teamCheckButton.BackgroundColor3 = state.espTeamCheck and state.accent or theme.card2; teamCheckButton.TextColor3 = state.espTeamCheck and Color3.fromRGB(8, 8, 11) or theme.text; updateESP() end)
	
	espMaxDistanceInput = labeledInput("max esp distance", "Max distance (100-5000)", contentFrame)
	espMaxDistanceInput.Text = tostring(state.espMaxDistance)
	local saveMaxDistance = settingsButton("APPLY MAX DISTANCE", contentFrame)
	espToggle.MouseButton1Click:Connect(function() state.espEnabled = not state.espEnabled; espToggle.Text = state.espEnabled and "ESP: ENABLED" or "ESP: DISABLED"; espToggle.BackgroundColor3 = state.espEnabled and state.accent or theme.card2; espToggle.TextColor3 = state.espEnabled and Color3.fromRGB(8, 8, 11) or theme.text; updateESP() end)
	saveMaxDistance.MouseButton1Click:Connect(function()
		local dist = tonumber(espMaxDistanceInput.Text)
		state.espMaxDistance = math.clamp(dist or state.espMaxDistance, 100, 5000)
		espMaxDistanceInput.Text = tostring(state.espMaxDistance)
		updateESP()
	end)
	applyFOV()
	espToggle.Text = state.espEnabled and "ESP: ENABLED" or "ESP: DISABLED"
	espToggle.BackgroundColor3 = state.espEnabled and state.accent or theme.card2
	espToggle.TextColor3 = state.espEnabled and Color3.fromRGB(8, 8, 11) or theme.text
end

local function renderAim()
	clearContent()
	create("UIListLayout", { Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder, Parent = contentFrame })
	create("UIPadding", { PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 16), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 12), Parent = contentFrame })
	sectionHeader("aimbot", "Camera-based aimbot that locks onto targets within FOV. Enable subtle mode for undetectable aim.", contentFrame)
	
	local aimToggle = settingsButton("AIMBOT: DISABLED", contentFrame)
	aimToggle.Text = state.aimEnabled and "AIMBOT: ENABLED" or "AIMBOT: DISABLED"
	aimToggle.BackgroundColor3 = state.aimEnabled and state.accent or theme.card2
	aimToggle.TextColor3 = state.aimEnabled and Color3.fromRGB(8, 8, 11) or theme.text
	
	local requireKeyRow = create("Frame", { Size = UDim2.new(1, -14, 0, 48), BackgroundColor3 = theme.card, BorderSizePixel = 0, Parent = contentFrame })
	corner(requireKeyRow, 14)
	stroke(requireKeyRow, theme.stroke, 0.55)
	local requireKeyButton = create("TextButton", { Position = UDim2.fromOffset(14, 10), Size = UDim2.new(1, -28, 0, 28), BackgroundColor3 = state.aimRequireKey and state.accent or theme.card2, AutoButtonColor = false, Text = "Require Key: " .. (state.aimRequireKey and "ON" or "OFF"), TextColor3 = state.aimRequireKey and Color3.fromRGB(8, 8, 11) or theme.text, Font = Enum.Font.GothamSemibold, TextSize = 12, Parent = requireKeyRow })
	corner(requireKeyButton, 10)
	stroke(requireKeyButton, theme.stroke, 0.6)
	requireKeyButton.MouseButton1Click:Connect(function()
		state.aimRequireKey = not state.aimRequireKey
		requireKeyButton.Text = "Require Key: " .. (state.aimRequireKey and "ON" or "OFF")
		requireKeyButton.BackgroundColor3 = state.aimRequireKey and state.accent or theme.card2
		requireKeyButton.TextColor3 = state.aimRequireKey and Color3.fromRGB(8, 8, 11) or theme.text
	end)
	
	local aimKeyInput = labeledInput("aim key", "KeyCode or MouseButton (e.g., E, MouseButton2)", contentFrame)
	aimKeyInput.Text = state.aimKeyString
	
	local partRow = create("Frame", { Size = UDim2.new(1, -14, 0, 180), BackgroundColor3 = theme.card, BorderSizePixel = 0, Parent = contentFrame })
	corner(partRow, 14)
	stroke(partRow, theme.stroke, 0.55)
	create("TextLabel", { Position = UDim2.fromOffset(14, 10), Size = UDim2.new(1, -28, 0, 20), BackgroundTransparency = 1, Text = "Target Body Part", TextColor3 = theme.text, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamSemibold, TextSize = 14, Parent = partRow })
	for index, part in ipairs(aimPartOptions) do
		local column = (index - 1) % 2
		local row = math.floor((index - 1) / 2)
		local button = create("TextButton", { Position = UDim2.new(column * 0.5, 14 + (column * 4), 0, 40 + (row * 34)), Size = UDim2.new(0.5, -20, 0, 28), BackgroundColor3 = state.aimPart == part and state.accent or theme.card2, AutoButtonColor = false, Text = part, TextColor3 = state.aimPart == part and Color3.fromRGB(8, 8, 11) or theme.text, Font = Enum.Font.GothamSemibold, TextSize = 10, Parent = partRow })
		corner(button, 10)
		stroke(button, theme.stroke, 0.6)
		button.MouseButton1Click:Connect(function() state.aimPart = part; renderAim() end)
	end
	
	local smoothnessInput = labeledInput("smoothing", "Smoothing (0.01-1.0)", contentFrame)
	smoothnessInput.Text = tostring(state.aimSmoothness)
	local aimFOVInput = labeledInput("aim fov", "FOV size (10-1000)", contentFrame)
	aimFOVInput.Text = tostring(state.aimFOV)
	local predictionInput = labeledInput("prediction", "Prediction (0-0.2)", contentFrame)
	predictionInput.Text = tostring(state.aimPrediction)
	
	-- Subtle aim toggle
	local subtleAimRow = create("Frame", { Size = UDim2.new(1, -14, 0, 48), BackgroundColor3 = theme.card, BorderSizePixel = 0, Parent = contentFrame })
	corner(subtleAimRow, 14)
	stroke(subtleAimRow, theme.stroke, 0.55)
	local subtleAimButton = create("TextButton", { Position = UDim2.fromOffset(14, 10), Size = UDim2.new(1, -28, 0, 28), BackgroundColor3 = state.aimSubtle and state.accent or theme.card2, AutoButtonColor = false, Text = "Subtle Mode: " .. (state.aimSubtle and "ON" or "OFF"), TextColor3 = state.aimSubtle and Color3.fromRGB(8, 8, 11) or theme.text, Font = Enum.Font.GothamSemibold, TextSize = 12, Parent = subtleAimRow })
	corner(subtleAimButton, 10)
	stroke(subtleAimButton, theme.stroke, 0.6)
	subtleAimButton.MouseButton1Click:Connect(function()
		state.aimSubtle = not state.aimSubtle
		subtleAimButton.Text = "Subtle Mode: " .. (state.aimSubtle and "ON" or "OFF")
		subtleAimButton.BackgroundColor3 = state.aimSubtle and state.accent or theme.card2
		subtleAimButton.TextColor3 = state.aimSubtle and Color3.fromRGB(8, 8, 11) or theme.text
	end)
	
	local optionsRow = create("Frame", { Size = UDim2.new(1, -14, 0, 180), BackgroundColor3 = theme.card, BorderSizePixel = 0, Parent = contentFrame })
	corner(optionsRow, 14)
	stroke(optionsRow, theme.stroke, 0.55)
	create("TextLabel", { Position = UDim2.fromOffset(14, 10), Size = UDim2.new(1, -28, 0, 20), BackgroundTransparency = 1, Text = "Options", TextColor3 = theme.text, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamSemibold, TextSize = 14, Parent = optionsRow })
	
	local function aimCheckbox(text, key, yPos)
		local container = create("Frame", { Position = UDim2.fromOffset(14, yPos), Size = UDim2.new(1, -28, 0, 22), BackgroundTransparency = 1, Parent = optionsRow })
		create("TextLabel", { Position = UDim2.fromOffset(0, 0), Size = UDim2.new(0.7, 0, 1, 0), BackgroundTransparency = 1, Text = text, TextColor3 = theme.text, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.Gotham, TextSize = 12, Parent = container })
		local button = create("TextButton", { Position = UDim2.new(1, -60, 0, 0), Size = UDim2.fromOffset(60, 22), BackgroundColor3 = state[key] and state.accent or theme.card2, AutoButtonColor = false, Text = state[key] and "ON" or "OFF", TextColor3 = state[key] and Color3.fromRGB(8, 8, 11) or theme.text, Font = Enum.Font.GothamSemibold, TextSize = 10, Parent = container })
		corner(button, 8)
		stroke(button, theme.stroke, 0.6)
		button.MouseButton1Click:Connect(function() state[key] = not state[key]; button.Text = state[key] and "ON" or "OFF"; button.BackgroundColor3 = state[key] and state.accent or theme.card2; button.TextColor3 = state[key] and Color3.fromRGB(8, 8, 11) or theme.text end)
	end
	aimCheckbox("Show FOV Circle", "aimShowFOV", 38)
	aimCheckbox("Wall Check", "aimWallCheck", 66)
	aimCheckbox("Team Check", "aimTeamCheck", 94)
	aimCheckbox("Sticky Aim", "aimStickyAim", 122)
	aimCheckbox("Health Check", "aimHealthCheck", 150)
	
	local minHealthInput = labeledInput("min health", "Min health (0-100)", contentFrame)
	minHealthInput.Text = tostring(state.aimMinHealth)
	
	local applyAim = settingsButton("APPLY AIM SETTINGS", contentFrame)
	
	aimToggle.MouseButton1Click:Connect(function()
		state.aimEnabled = not state.aimEnabled
		aimToggle.Text = state.aimEnabled and "AIMBOT: ENABLED" or "AIMBOT: DISABLED"
		aimToggle.BackgroundColor3 = state.aimEnabled and state.accent or theme.card2
		aimToggle.TextColor3 = state.aimEnabled and Color3.fromRGB(8, 8, 11) or theme.text
	end)
	
	applyAim.MouseButton1Click:Connect(function()
		local keyString = trim(aimKeyInput.Text)
		state.aimKeyString = keyString
		
		local keyCode = Enum.KeyCode[keyString]
		if keyCode then
			state.aimKey = keyCode
		else
			local success, result = pcall(function() return Enum.UserInputType[keyString] end)
			if success and result then
				state.aimKey = result
			end
		end
		
		local smooth = tonumber(smoothnessInput.Text)
		state.aimSmoothness = math.clamp(smooth or state.aimSmoothness, 0.01, 1.0)
		local fov = tonumber(aimFOVInput.Text)
		state.aimFOV = math.clamp(fov or state.aimFOV, 10, 1000)
		local pred = tonumber(predictionInput.Text)
		state.aimPrediction = math.clamp(pred or state.aimPrediction, 0, 0.2)
		local minHp = tonumber(minHealthInput.Text)
		state.aimMinHealth = math.clamp(minHp or state.aimMinHealth, 0, 100)
		
		aimKeyInput.Text = state.aimKeyString
		smoothnessInput.Text = tostring(state.aimSmoothness)
		aimFOVInput.Text = tostring(state.aimFOV)
		predictionInput.Text = tostring(state.aimPrediction)
		minHealthInput.Text = tostring(state.aimMinHealth)
	end)
end

local function renderSettings()
	clearContent()
	create("UIListLayout", { Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder, Parent = contentFrame })
	create("UIPadding", { PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 16), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 12), Parent = contentFrame })

	sectionHeader("access", "Change the local unlock password used on this client.", contentFrame)
	newPasswordInput = labeledInput("new password", "New local password", contentFrame)
	local savePassword = settingsButton("SAVE PASSWORD", contentFrame)

	sectionHeader("branding", "Customize the title and the small mark in the header. Use sparkle for the default mark.", contentFrame)
	logoInput = labeledInput("logo mark", "Logo text or sparkle", contentFrame)
	logoInput.Text = state.logoMode == "sparkle" and "sparkle" or state.logoText
	titleInput = labeledInput("window title", "Window title", contentFrame)
	titleInput.Text = state.titleText
	local saveBranding = settingsButton("SAVE BRANDING", contentFrame)

	sectionHeader("interface", "Adjust the menu size and panel opacity if the layout feels too tight.", contentFrame)
	panelWidthInput = labeledInput("menu width", "Width 520-760", contentFrame)
	panelWidthInput.Text = tostring(state.panelWidth)
	panelHeightInput = labeledInput("menu height", "Height 420-600", contentFrame)
	panelHeightInput.Text = tostring(state.panelHeight)
	panelTransparencyInput = labeledInput("panel transparency", "0-0.35", contentFrame)
	panelTransparencyInput.Text = tostring(state.panelTransparency)
	local savePanel = settingsButton("SAVE MENU LAYOUT", contentFrame)

	sectionHeader("accent", "Choose the main highlight color used by active controls and the logo.", contentFrame)
	local colorRow = create("Frame", { Size = UDim2.new(1, -14, 0, 92), BackgroundColor3 = theme.card, BorderSizePixel = 0, Parent = contentFrame })
	corner(colorRow, 14)
	stroke(colorRow, theme.stroke, 0.55)
	create("TextLabel", { Position = UDim2.fromOffset(14, 10), Size = UDim2.new(1, -28, 0, 20), BackgroundTransparency = 1, Text = "Accent color", TextColor3 = theme.text, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamSemibold, TextSize = 14, Parent = colorRow })
	accentPreview = create("Frame", { Position = UDim2.fromOffset(14, 42), Size = UDim2.fromOffset(34, 34), BackgroundColor3 = state.accent, BorderSizePixel = 0, Parent = colorRow })
	corner(accentPreview, 12)
	for index, color in ipairs(accentColors) do
		local swatch = create("TextButton", { Position = UDim2.fromOffset(60 + ((index - 1) * 42), 42), Size = UDim2.fromOffset(34, 34), BackgroundColor3 = color, AutoButtonColor = false, Text = "", Parent = colorRow })
		corner(swatch, 12)
		stroke(swatch, Color3.fromRGB(255, 255, 255), 0.75)
		swatch.MouseButton1Click:Connect(function() state.accent = color; applyAccent() end)
	end

	sectionHeader("watermark", "The watermark stays visible while the menu is hidden. Drag the text to move it; drag its lower-right area to resize.", contentFrame)
	watermarkToggle = settingsButton("WATERMARK: DISABLED", contentFrame)
	watermarkInput = labeledInput("watermark text", "Watermark text", contentFrame)
	watermarkInput.Text = state.watermarkText
	local saveWatermark = settingsButton("SAVE WATERMARK TEXT", contentFrame)

	local watermarkColorRow = create("Frame", { Size = UDim2.new(1, -14, 0, 92), BackgroundColor3 = theme.card, BorderSizePixel = 0, Parent = contentFrame })
	corner(watermarkColorRow, 14)
	stroke(watermarkColorRow, theme.stroke, 0.55)
	create("TextLabel", { Position = UDim2.fromOffset(14, 10), Size = UDim2.new(1, -28, 0, 20), BackgroundTransparency = 1, Text = "Watermark color", TextColor3 = theme.text, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamSemibold, TextSize = 14, Parent = watermarkColorRow })
	watermarkColorPreview = create("Frame", { Position = UDim2.fromOffset(14, 42), Size = UDim2.fromOffset(34, 34), BackgroundColor3 = state.watermarkColor, BorderSizePixel = 0, Parent = watermarkColorRow })
	corner(watermarkColorPreview, 12)
	for index, color in ipairs(watermarkColors) do
		local swatch = create("TextButton", { Position = UDim2.fromOffset(60 + ((index - 1) * 42), 42), Size = UDim2.fromOffset(34, 34), BackgroundColor3 = color, AutoButtonColor = false, Text = "", Parent = watermarkColorRow })
		corner(swatch, 12)
		stroke(swatch, Color3.fromRGB(255, 255, 255), 0.75)
		swatch.MouseButton1Click:Connect(function() state.watermarkColor = color; applyWatermark() end)
	end

	local fontRow = create("Frame", { Size = UDim2.new(1, -14, 0, 112), BackgroundColor3 = theme.card, BorderSizePixel = 0, Parent = contentFrame })
	corner(fontRow, 14)
	stroke(fontRow, theme.stroke, 0.55)
	create("TextLabel", { Position = UDim2.fromOffset(14, 10), Size = UDim2.new(1, -28, 0, 20), BackgroundTransparency = 1, Text = "Watermark font", TextColor3 = theme.text, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamSemibold, TextSize = 14, Parent = fontRow })
	for index, fontChoice in ipairs(watermarkFonts) do
		local column = ((index - 1) % 3)
		local row = math.floor((index - 1) / 3)
		local button = create("TextButton", { Position = UDim2.new(column / 3, 14 + (column * 4), 0, 40 + (row * 34)), Size = UDim2.new(1 / 3, -20, 0, 28), BackgroundColor3 = state.watermarkFont == fontChoice.value and state.accent or theme.card2, AutoButtonColor = false, Text = fontChoice.label, TextColor3 = state.watermarkFont == fontChoice.value and Color3.fromRGB(8, 8, 11) or theme.text, Font = fontChoice.value, TextSize = 12, Parent = fontRow })
		corner(button, 10)
		stroke(button, theme.stroke, 0.6)
		button.MouseButton1Click:Connect(function() state.watermarkFont = fontChoice.value; applyWatermark(); renderSettings() end)
	end
	local resetWatermark = settingsButton("RESET WATERMARK POSITION", contentFrame)

	sectionHeader("crosshair", "Enable a local visual crosshair and tune its shape, color, size, and line thickness.", contentFrame)
	crosshairToggle = settingsButton("CROSSHAIR: DISABLED", contentFrame)

	local crosshairShapeRow = create("Frame", { Size = UDim2.new(1, -14, 0, 92), BackgroundColor3 = theme.card, BorderSizePixel = 0, Parent = contentFrame })
	corner(crosshairShapeRow, 14)
	stroke(crosshairShapeRow, theme.stroke, 0.55)
	create("TextLabel", { Position = UDim2.fromOffset(14, 10), Size = UDim2.new(1, -28, 0, 20), BackgroundTransparency = 1, Text = "Crosshair shape", TextColor3 = theme.text, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamSemibold, TextSize = 14, Parent = crosshairShapeRow })
	local shapes = { "cross", "dot", "circle" }
	for index, shape in ipairs(shapes) do
		local button = create("TextButton", { Position = UDim2.new((index - 1) / 3, 14 + ((index - 1) * 4), 0, 42), Size = UDim2.new(1 / 3, -20, 0, 34), BackgroundColor3 = state.crosshairShape == shape and state.accent or theme.card2, AutoButtonColor = false, Text = string.upper(shape), TextColor3 = state.crosshairShape == shape and Color3.fromRGB(8, 8, 11) or theme.text, Font = Enum.Font.GothamSemibold, TextSize = 12, Parent = crosshairShapeRow })
		corner(button, 12)
		stroke(button, theme.stroke, 0.65)
		button.MouseButton1Click:Connect(function() state.crosshairShape = shape; drawCrosshair(); renderSettings() end)
	end

	local crosshairColorRow = create("Frame", { Size = UDim2.new(1, -14, 0, 92), BackgroundColor3 = theme.card, BorderSizePixel = 0, Parent = contentFrame })
	corner(crosshairColorRow, 14)
	stroke(crosshairColorRow, theme.stroke, 0.55)
	create("TextLabel", { Position = UDim2.fromOffset(14, 10), Size = UDim2.new(1, -28, 0, 20), BackgroundTransparency = 1, Text = "Crosshair color", TextColor3 = theme.text, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamSemibold, TextSize = 14, Parent = crosshairColorRow })
	crosshairColorPreview = create("Frame", { Position = UDim2.fromOffset(14, 42), Size = UDim2.fromOffset(34, 34), BackgroundColor3 = state.crosshairColor, BorderSizePixel = 0, Parent = crosshairColorRow })
	corner(crosshairColorPreview, 12)
	for index, color in ipairs(crosshairColors) do
		local swatch = create("TextButton", { Position = UDim2.fromOffset(60 + ((index - 1) * 42), 42), Size = UDim2.fromOffset(34, 34), BackgroundColor3 = color, AutoButtonColor = false, Text = "", Parent = crosshairColorRow })
		corner(swatch, 12)
		stroke(swatch, Color3.fromRGB(255, 255, 255), 0.75)
		swatch.MouseButton1Click:Connect(function() state.crosshairColor = color; drawCrosshair() end)
	end

	crosshairSizeInput = labeledInput("crosshair size", "Crosshair size 8-80", contentFrame)
	crosshairSizeInput.Text = tostring(state.crosshairSize)
	crosshairThicknessInput = labeledInput("crosshair thickness", "Crosshair thickness 1-10", contentFrame)
	crosshairThicknessInput.Text = tostring(state.crosshairThickness)
	local saveCrosshair = settingsButton("SAVE CROSSHAIR SIZE", contentFrame)

	savePassword.MouseButton1Click:Connect(function()
		local nextPassword = trim(newPasswordInput.Text)
		if nextPassword == "" then newPasswordInput.PlaceholderText = "Password cannot be empty"; return end
		state.password = nextPassword
		newPasswordInput.Text = ""
		newPasswordInput.PlaceholderText = "Password saved"
	end)

	saveBranding.MouseButton1Click:Connect(function()
		local nextLogo = trim(logoInput.Text)
		local nextTitle = trim(titleInput.Text)
		if nextLogo == "" or string.lower(nextLogo) == "sparkle" then state.logoMode = "sparkle"; state.logoText = ""; logoInput.Text = "sparkle"
		else state.logoMode = "text"; state.logoText = string.sub(nextLogo, 1, 3) end
		state.titleText = nextTitle ~= "" and string.lower(nextTitle) or "onyx"
		applyBranding()
	end)

	savePanel.MouseButton1Click:Connect(function()
		local width = tonumber(panelWidthInput.Text)
		local height = tonumber(panelHeightInput.Text)
		local transparency = tonumber(panelTransparencyInput.Text)
		state.panelWidth = math.clamp(width or state.panelWidth, 520, 760)
		state.panelHeight = math.clamp(height or state.panelHeight, 420, 600)
		state.panelTransparency = math.clamp(transparency or state.panelTransparency, 0, 0.35)
		panelWidthInput.Text = tostring(state.panelWidth)
		panelHeightInput.Text = tostring(state.panelHeight)
		panelTransparencyInput.Text = tostring(state.panelTransparency)
		applyPanelStyle()
		updatePanelScale()
		if state.authenticated and not state.minimized then tween(panel, 0.2, { Size = openPanelSize() }) end
	end)

	watermarkToggle.MouseButton1Click:Connect(function() state.watermarkEnabled = not state.watermarkEnabled; applyWatermark() end)
	saveWatermark.MouseButton1Click:Connect(function() local nextText = trim(watermarkInput.Text); state.watermarkText = nextText ~= "" and nextText or "onyx"; applyWatermark() end)
	resetWatermark.MouseButton1Click:Connect(function() state.watermarkPosition = UDim2.new(1, -276, 0, 12); state.watermarkSize = Vector2.new(260, 30); applyWatermark() end)
	crosshairToggle.MouseButton1Click:Connect(function() state.crosshairEnabled = not state.crosshairEnabled; drawCrosshair() end)
	saveCrosshair.MouseButton1Click:Connect(function()
		local size = tonumber(crosshairSizeInput.Text)
		local thickness = tonumber(crosshairThicknessInput.Text)
		state.crosshairSize = math.clamp(size or state.crosshairSize, 8, 80)
		state.crosshairThickness = math.clamp(thickness or state.crosshairThickness, 1, 10)
		crosshairSizeInput.Text = tostring(state.crosshairSize)
		crosshairThicknessInput.Text = tostring(state.crosshairThickness)
		drawCrosshair()
	end)
	applyAccent()
end

local function switchTab(tabName)
	state.activeTab = tabName
	for name, button in pairs(sidebarButtons) do
		local active = name == tabName
		tween(button, 0.18, { BackgroundColor3 = active and state.accent or Color3.fromRGB(24, 24, 30), TextColor3 = active and Color3.fromRGB(8, 8, 11) or theme.text })
	end
	if tabName == "Settings" then renderSettings()
	elseif tabName == "Movement" then renderMovement()
	elseif tabName == "Visuals" then renderVisuals()
	elseif tabName == "Aim" then renderAim()
	else renderHomepage() end
end

local function showMain()
	state.authenticated = true
	stopSpinner()
	setStatus("success", "Access granted", "Opening onyx.")
	task.delay(0.45, function()
		if not screenGui.Parent then return end
		tween(authView, 0.2, { GroupTransparency = 1 })
		task.wait(0.2)
		authView.Visible = false
		appView.Visible = true
		switchTab("Homepage")
		tween(appView, 0.24, { GroupTransparency = 0 })
		tween(panel, 0.24, { Size = openPanelSize() })
	end)
end

setInterfaceVisible = function(visible)
	state.visible = visible
	if visible then
		panel.Visible = true
		backdrop.Visible = true
		panel.GroupTransparency = 1
		backdrop.BackgroundTransparency = 1
		tween(panel, 0.22, { GroupTransparency = 0 })
		tween(backdrop, 0.22, { BackgroundTransparency = 0.3 })
	else
		tween(panel, 0.18, { GroupTransparency = 1 })
		tween(backdrop, 0.18, { BackgroundTransparency = 1 })
		task.delay(0.18, function() if not state.visible and panel and backdrop then panel.Visible = false; backdrop.Visible = false end end)
	end
end

local function submitPassword()
	local typed = trim(passwordInput.Text)
	if typed == "" then setStatus("error", "Access denied", "Enter the password first."); return end
	submitButton.Active = false
	submitButton.Text = "CHECKING"
	setStatus("loading", "Checking password", "Loading onyx.")
	startSpinner()
	task.delay(0.9, function()
		submitButton.Active = true
		submitButton.Text = "SUBMIT"
		if typed == state.password then showMain()
		else stopSpinner(); setStatus("error", "Access denied", "The password is incorrect.") end
	end)
end

local function buildHeader()
	local header = create("Frame", { Name = "Header", Size = UDim2.new(1, 0, 0, 56), BackgroundColor3 = theme.panelTop, BorderSizePixel = 0, Parent = panel })
	corner(header, 14)
	create("Frame", { Position = UDim2.new(0, 0, 1, -14), Size = UDim2.new(1, 0, 0, 14), BackgroundColor3 = theme.panelTop, BorderSizePixel = 0, Parent = header })
	local mark = create("Frame", { Position = UDim2.fromOffset(18, 15), Size = UDim2.fromOffset(26, 26), BackgroundColor3 = Color3.fromRGB(5, 5, 7), BorderSizePixel = 0, Parent = header })
	corner(mark, 10)
	stroke(mark, theme.stroke, 0.15)
	logoFrame = create("Frame", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(18, 18), BackgroundColor3 = Color3.fromRGB(9, 9, 12), BorderSizePixel = 0, Parent = mark })
	corner(logoFrame, 8)
	drawSparkle(logoFrame)
	titleLabel = create("TextLabel", { Position = UDim2.fromOffset(56, 0), Size = UDim2.new(1, -140, 1, 0), BackgroundTransparency = 1, Text = state.titleText, TextColor3 = theme.text, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamSemibold, TextSize = 19, Parent = header })
	
	local function headerButton(name, text, rightOffset)
		local button = create("TextButton", { Name = name, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, rightOffset, 0, 14), Size = UDim2.fromOffset(28, 28), BackgroundColor3 = Color3.fromRGB(33, 33, 39), AutoButtonColor = false, Text = text, TextColor3 = theme.muted, Font = Enum.Font.GothamSemibold, TextSize = 14, Parent = header })
		corner(button, 9)
		stroke(button, theme.stroke, 0.5)
		button.MouseEnter:Connect(function() tween(button, 0.15, { BackgroundColor3 = Color3.fromRGB(46, 46, 55), TextColor3 = theme.text }) end)
		button.MouseLeave:Connect(function() tween(button, 0.15, { BackgroundColor3 = Color3.fromRGB(33, 33, 39), TextColor3 = theme.muted }) end)
		return button
	end
	
	local closeButton = headerButton("CloseButton", "X", -14)
	local minimizeButton = headerButton("MinimizeButton", "-", -48)
	closeButton.MouseButton1Click:Connect(function() setInterfaceVisible(false) end)
	minimizeButton.MouseButton1Click:Connect(function()
		state.minimized = not state.minimized
		if state.minimized then body.Visible = false; minimizeButton.Text = "+"; tween(panel, 0.2, { Size = UDim2.fromOffset(430, 58) })
		else body.Visible = true; minimizeButton.Text = "-"; tween(panel, 0.2, { Size = state.authenticated and openPanelSize() or authPanelSize() }) end
	end)
	header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			state.dragging = true; state.dragStart = input.Position; state.startPosition = panel.Position
			input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then state.dragging = false end end)
		end
	end)
end

local function buildAuth()
	authView = create("CanvasGroup", { Name = "AuthView", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, GroupTransparency = 0, Parent = body })
	local passwordShell
	passwordInput, passwordShell = textInput("PasswordInput", "Enter password", authView)
	passwordShell.Position = UDim2.fromOffset(0, 6)
	passwordShell.Size = UDim2.new(1, 0, 0, 50)
	submitButton = create("TextButton", { Name = "SubmitButton", Position = UDim2.fromOffset(0, 74), Size = UDim2.new(1, 0, 0, 48), BackgroundColor3 = state.accent, AutoButtonColor = false, Text = "SUBMIT", TextColor3 = Color3.fromRGB(8, 8, 11), Font = Enum.Font.GothamSemibold, TextSize = 14, Parent = authView })
	corner(submitButton, 16)
	stroke(submitButton, Color3.fromRGB(255, 255, 255), 0.82)
	local statusCard = create("Frame", { Position = UDim2.fromOffset(0, 138), Size = UDim2.new(1, 0, 0, 56), BackgroundColor3 = theme.card, BorderSizePixel = 0, Parent = authView })
	corner(statusCard, 16)
	stroke(statusCard, theme.stroke, 0.45)
	spinner = create("Frame", { Position = UDim2.fromOffset(18, 18), Size = UDim2.fromOffset(22, 22), BackgroundTransparency = 1, Visible = false, Parent = statusCard })
	local dot = create("Frame", { AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromOffset(4, 10), BackgroundColor3 = state.accent, BorderSizePixel = 0, Parent = spinner })
	corner(dot, 3)
	statusTitle = create("TextLabel", { Position = UDim2.fromOffset(16, 8), Size = UDim2.new(1, -32, 0, 20), BackgroundTransparency = 1, Text = "Ready", TextColor3 = theme.text, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.GothamSemibold, TextSize = 14, Parent = statusCard })
	statusText = create("TextLabel", { Position = UDim2.fromOffset(16, 30), Size = UDim2.new(1, -32, 0, 18), BackgroundTransparency = 1, Text = "Enter the local password.", TextColor3 = theme.muted, TextXAlignment = Enum.TextXAlignment.Left, Font = Enum.Font.Gotham, TextSize = 12, Parent = statusCard })
	submitButton.MouseButton1Click:Connect(submitPassword)
	passwordInput.FocusLost:Connect(function(enterPressed) if enterPressed then submitPassword() end end)
end

local function buildApp()
	appView = create("CanvasGroup", { Name = "AppView", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, GroupTransparency = 1, Visible = false, Parent = body })
	local sidebar = create("Frame", { Name = "Sidebar", Size = UDim2.new(0, 144, 1, 0), BackgroundColor3 = theme.sidebar, BorderSizePixel = 0, Parent = appView })
	corner(sidebar, 14)
	stroke(sidebar, theme.stroke, 0.55)
	create("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder, Parent = sidebar })
	create("UIPadding", { PaddingTop = UDim.new(0, 12), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), Parent = sidebar })
	
	local function tab(name, order)
		local button = create("TextButton", { Name = name .. "Tab", Size = UDim2.new(1, 0, 0, 40), BackgroundColor3 = Color3.fromRGB(24, 24, 30), AutoButtonColor = false, Text = string.lower(name), TextColor3 = theme.text, Font = Enum.Font.GothamSemibold, TextSize = 13, LayoutOrder = order, Parent = sidebar })
		corner(button, 12)
		stroke(button, theme.stroke, 0.7)
		sidebarButtons[name] = button
		button.MouseEnter:Connect(function() if state.activeTab ~= name then tween(button, 0.16, { BackgroundColor3 = Color3.fromRGB(34, 34, 42) }) end end)
		button.MouseLeave:Connect(function() if state.activeTab ~= name then tween(button, 0.16, { BackgroundColor3 = Color3.fromRGB(24, 24, 30) }) end end)
		button.MouseButton1Click:Connect(function() switchTab(name) end)
	end
	
	tab("Homepage", 1)
	tab("Movement", 2)
	tab("Visuals", 3)
	tab("Aim", 4)
	tab("Settings", 5)
	
	contentFrame = create("ScrollingFrame", { Name = "Content", Position = UDim2.fromOffset(164, 0), Size = UDim2.new(1, -164, 1, 0), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 4, CanvasSize = UDim2.fromOffset(0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y, Parent = appView })
end

local function buildGui()
	screenGui = create("ScreenGui", { Name = "OnyxLocalInterface", ResetOnSpawn = false, IgnoreGuiInset = true, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, Parent = playerGui })
	backdrop = create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = theme.backdrop, BackgroundTransparency = 0.3, BorderSizePixel = 0, Parent = screenGui })
	watermarkLabel = create("TextLabel", { AnchorPoint = Vector2.new(0, 0), Position = state.watermarkPosition, Size = UDim2.fromOffset(state.watermarkSize.X, state.watermarkSize.Y), BackgroundTransparency = 1, Text = state.watermarkText, TextColor3 = state.watermarkColor, TextXAlignment = Enum.TextXAlignment.Right, Font = state.watermarkFont, TextSize = 15, Active = true, Visible = false, Parent = screenGui })
	watermarkResizeHandle = create("Frame", { AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, 0, 1, 0), Size = UDim2.fromOffset(26, 26), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, BorderSizePixel = 0, Active = true, Visible = false, Parent = watermarkLabel })
	corner(watermarkResizeHandle, 4)
	
	watermarkLabel.InputBegan:Connect(function(input)
		if not state.watermarkEnabled then return end
		if state.watermarkResizing then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			state.watermarkDragging = true; state.watermarkDragStart = input.Position; state.watermarkStartPosition = state.watermarkPosition
			input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then state.watermarkDragging = false end end)
		end
	end)
	watermarkResizeHandle.InputBegan:Connect(function(input)
		if not state.watermarkEnabled then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			state.watermarkDragging = false; state.watermarkResizing = true; state.watermarkDragStart = input.Position; state.watermarkStartSize = state.watermarkSize
			input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then state.watermarkResizing = false end end)
		end
	end)
	
	crosshairFrame = create("Frame", { Name = "Crosshair", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(state.crosshairSize * 2, state.crosshairSize * 2), BackgroundTransparency = 1, Visible = false, Parent = screenGui })
	
	panel = create("CanvasGroup", { Name = "OnyxPanel", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = authPanelSize(), BackgroundColor3 = theme.panel, BorderSizePixel = 0, GroupTransparency = 0, Parent = screenGui })
	corner(panel, 16)
	stroke(panel, theme.stroke, 0.08)
	panelScale = create("UIScale", { Scale = 1, Parent = panel })
	create("UISizeConstraint", { MinSize = Vector2.new(320, 58), MaxSize = Vector2.new(780, 620), Parent = panel })
	
	buildHeader()
	body = create("Frame", { Name = "Body", Position = UDim2.fromOffset(34, 86), Size = UDim2.new(1, -68, 1, -120), BackgroundTransparency = 1, Parent = panel })
	buildAuth()
	buildApp()
	applyPanelStyle()
	applyAccent()
	applyMovement()
	applyFOV()
	drawCrosshair()
	updatePanelScale()
end

buildGui()

if workspace.CurrentCamera then workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updatePanelScale) end
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	updatePanelScale()
	if workspace.CurrentCamera then workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updatePanelScale) end
end)

UserInputService.InputChanged:Connect(function(input)
	if state.dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - state.dragStart
		panel.Position = UDim2.new(state.startPosition.X.Scale, state.startPosition.X.Offset + delta.X, state.startPosition.Y.Scale, state.startPosition.Y.Offset + delta.Y)
	elseif state.watermarkDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - state.watermarkDragStart
		state.watermarkPosition = UDim2.new(state.watermarkStartPosition.X.Scale, state.watermarkStartPosition.X.Offset + delta.X, state.watermarkStartPosition.Y.Scale, state.watermarkStartPosition.Y.Offset + delta.Y)
		applyWatermark()
	elseif state.watermarkResizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - state.watermarkDragStart
		state.watermarkSize = Vector2.new(math.clamp(state.watermarkStartSize.X + delta.X, 80, 700), math.clamp(state.watermarkStartSize.Y + delta.Y, 20, 140))
		applyWatermark()
	end
end)

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.Insert then setInterfaceVisible(not state.visible)
	elseif input.KeyCode == Enum.KeyCode.Tab and screenGui.Enabled then
		if passwordInput and not state.authenticated then passwordInput:CaptureFocus() end
	end
	
	if state.aimEnabled then
		if state.aimRequireKey then
			if input.UserInputType == state.aimKey or input.KeyCode == state.aimKey then
				state.aiming = true
			end
		end
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if state.aimEnabled and state.aimRequireKey then
		if input.UserInputType == state.aimKey or input.KeyCode == state.aimKey then
			state.aiming = false
		end
	end
end)

-- Mouse button support for aim
mouse.Button2Down:Connect(function()
	if state.aimEnabled and state.aimRequireKey and state.aimKey == Enum.UserInputType.MouseButton2 then
		state.aiming = true
	end
end)
mouse.Button2Up:Connect(function()
	if state.aimEnabled and state.aimRequireKey and state.aimKey == Enum.UserInputType.MouseButton2 then
		state.aiming = false
	end
end)

-- Always aim when no key required
RunService.RenderStepped:Connect(function()
	if state.aimEnabled and not state.aimRequireKey then
		state.aiming = true
	end
	updateAim()
end)

player.CharacterAdded:Connect(function()
	applyMovement()
	applyFOV()
	if state.authenticated then
		panel.Visible = state.visible
		backdrop.Visible = state.visible
		authView.Visible = false
		appView.Visible = true
		appView.GroupTransparency = 0
		switchTab(state.activeTab)
		applyWatermark()
		drawCrosshair()
	end
	updateESP()
end)

screenGui.Destroying:Connect(function()
	stopSpinner()
	if jumpConnection then jumpConnection:Disconnect() end
	if espUpdateConnection then espUpdateConnection:Disconnect() end
	if espContainer then espContainer:Destroy() end
	if aimFOVCircle then aimFOVCircle:Remove() end
end)
