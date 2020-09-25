package.path = package.path .. ";" ..  hs.configdir .. "/Spoons/?.spoon/init.lua"

--------------------------------------------------------------------------------
-- Spoons
--------------------------------------------------------------------------------

-- Load spoons
hs.loadSpoon("ReloadConfiguration")
hs.loadSpoon("Caffeine")

-- Start spoons
spoon.ReloadConfiguration:start()
spoon.Caffeine:start()

--------------------------------------------------------------------------------
-- MAIN
--------------------------------------------------------------------------------

-- Send reloaded notification
hs.notify.new({title="Hammerspoon", informativeText="Loaded!!"}):send()
