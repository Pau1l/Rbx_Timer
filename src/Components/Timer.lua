--!strict
local RunServ = game:GetService("RunService")
local heartbeat = RunServ.Heartbeat

type TimerImpl = {
	__index: TimerImpl,
	new: () -> Timer,
	StartTimer: (self: Timer, duration : number) -> (),
	ResetTime: (self: Timer) -> (),
}

type Timer = typeof(setmetatable({} :: {_setTime : number, _isRunning: boolean}, {} :: TimerImpl))

local Timer : TimerImpl = {} :: TimerImpl
Timer.__index = Timer

local function WaitDelay(sec : number) : ()
	local delayTime = 0
	while delayTime < sec do
		delayTime += heartbeat:Wait()
	end
end

function Timer.new()
	local self = {}

	self._setTime = 0
	self._isRunning = false

	return setmetatable(self, Timer)
end

function Timer:StartTimer(duration)
	if not self._isRunning then
		self._setTime = duration
		self._isRunning = true

		while self._isRunning ~= false do
			if self._setTime > 0 then
				
				WaitDelay(1) -- or just task.wait(1)

				self._setTime -= 1
			else
				break
			end
		end

		self._isRunning = false
	else
		print(debug.traceback(warn("Timer is already running:"), 2))
	end
end

function Timer:ResetTime()
	self._setTime = 0
end

return Timer