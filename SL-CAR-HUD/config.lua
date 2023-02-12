Config = {}

Config.accentColor = {r=124, g=237, b= 255} -- Changes the accent color (light blue by default) || screenshot: https://cdn.upload.systems/uploads/gadDyE4N.png

Config.unit = "Km/h"    -- Changes the unit to Km/h or Mp/h

Config.customMultiplier = 0

Config.centerSpeed = true  -- If disabled uncenters the speed indicator and shows zero's next to it || screenshot: https://cdn.upload.systems/uploads/0PUuG9lo.png

Config.excludedClasses = {"Cycles", "Service"}   -- The whole hud doesnt show on excluded classes || Classes you can exclude are: Compacts, Sedans, SUVs, Coupes, Muscle, Sports, Classics, Sports, Super, Motorcycles, Off-road, Industrial, Utility, Vans, Cycles, Boats, Helicopters, Planes, Service, Emergency, Military, Commercial, Trains

Config.excludedModels = {""}   -- The whole hud doesnt show on excluded models || syntax to exclude specific model: "ADDER", "T20"

Config.hideRpmOnModels = {""}  -- hides the Rps counter on set models || syntax to exclude specific model: "ADDER", "T20" || screenshot: https://cdn.upload.systems/uploads/HhcWqrBW.png

Config.showKeyBinds = true  -- if set to false, hides the cruisecontrol and seatbelt keybinds and indicators || screenshot: https://cdn.upload.systems/uploads/IJmfo0Al.png

Config.bindOutline = true  -- when enabled, draws a outline around the seatbelt/cruise bind box when the bind is pressed (takes a tiny bit more resource time when enabled)|| screenshot: https://cdn.upload.systems/uploads/HQJZFth9.png

Config.enableCruiseControl = true   -- if set to false, completely disables the cruise control function including the indicator (saves about 0.1ms response time when turned off)

Config.CruiseControlActiveMessage = "Cruise Control activated at"   -- Notification content when Cruise control is activated

Config.CruiseControlInActiveMessage = "Cruise Control Deactivated"  -- Notification content when Cruise control is activated

Config.cruiseControlBind = "G"  -- Changes the bind which if pressed, activates the cruise control

Config.cruiseControlCancelBinds = {"SPACEBAR", "S", "W", "A", "D"}  -- Binds which, when pressed, disable the cruise control

Config.timeTillCancel = 10  -- Time period the disable binds need to be pressed for, before automatically disabling the cruise control

Config.cruiseControlMinSpeed = 50   -- Minimum speed required to activate the cruise control || Speed is measured in the unit set in the fourth line of this config

Config.enableSeatBelt = true    -- if set to false, completely disables the seatbelt function including the indicator (saves about 0.1ms response time when turned off)

Config.messageTitle = "Info"

Config.seatBeltActiveMessage = "Seatbelt Fastened"  -- Notification content when seatbelt is activated

Config.seatBeltInActiveMessage = "seatbelt removed" -- Notification content when seatbelt is deactivated

Config.seatBeltBind = "B"   -- Sets the bind which, when pressed, activates/deactivates the seatbelt

Config.seatBeltCrashMinSpeed = 10   -- Minimum speed required to trigger player ragdoll in case of a crash || Speed is measured in the unit set in the fourth line of this config

Config.seatBeltCrashTolerance = 0.35 -- Sets the tolerance under which the player won't ragdoll out of the vehicle in case of a crash