function isDarkModeEnabled()
	local _, res = hs.osascript.javascript([[
    Application("System Events").appearancePreferences.darkMode()
  ]])
	return res == true -- getting nil here sometimes
end

function getThemeVariant(isDarkMode)
	if isDarkMode then
		return "storm"
	else
		return "day"
	end
end

function buildKittyCommand(isDarkMode)
	local kittyPath = "/Applications/kitty.app/Contents/MacOS/kitty"
	local tokyoNightTheme = getThemeVariant(isDarkMode)
	local capitalizedTheme = tokyoNightTheme:sub(1, 1):upper() .. tokyoNightTheme:sub(2)
	return kittyPath
		.. " +kitten themes --reload-in=all --config-file-name themes.conf Tokyo Night "
		.. capitalizedTheme
end

local function executeCommand(command, appName)
	print(appName .. ": command: " .. command)
	local output, status, type, rc = hs.execute(command, true)
	if status then
		print(appName .. ": succeeded")
	else
		print(appName .. ": failed")
	end
end

cb = function(observedNotificationName)
	local isDarkMode = isDarkModeEnabled()
	print("Theme changed. Dark mode: " .. tostring(isDarkMode))
	local commands = {
		{ builder = buildKittyCommand, appName = "kitty" },
		-- TODO: Neovim
	}
	for _, cmdInfo in ipairs(commands) do
		local command = cmdInfo.builder(isDarkMode)
		executeCommand(command, cmdInfo.appName)
	end
end

notificationName = "AppleInterfaceThemeChangedNotification"
appearanceWatcher = hs.distributednotifications.new(cb, notificationName, nil)
appearanceWatcher:start()
