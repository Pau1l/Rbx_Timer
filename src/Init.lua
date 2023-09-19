--!strict
local RepStorage = game:GetService("ReplicatedStorage")
local Timer = require(RepStorage:WaitForChild("Timer")).new()

local function Start() : ()
	local _Duration = 20
	Timer:StartTimer(_Duration)
	
	-- do stuff
end

Start()