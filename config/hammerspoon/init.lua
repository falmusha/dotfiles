package.path = package.path .. ";" ..  hs.configdir .. "/Spoons/?.spoon/init.lua"

--------------------------------------------------------------------------------
-- Spoons
--------------------------------------------------------------------------------

-- Load spoons
hs.loadSpoon("ReloadConfiguration")
hs.loadSpoon("Caffeine")
hs.loadSpoon("WindowHalfsAndThirds")

-- Start spoons
spoon.ReloadConfiguration:start()
spoon.Caffeine:start()
spoon.WindowHalfsAndThirds:bindHotkeys({
  -- halfs
  left_half   = { {"ctrl",        "cmd"}, "Left" },
  right_half  = { {"ctrl",        "cmd"}, "Right" },
  top_half    = { {"ctrl",        "cmd"}, "Up" },
  bottom_half = { {"ctrl",        "cmd"}, "Down" },
  -- thirds
  third_left  = { {"ctrl", "alt"       }, "Left" },
  third_right = { {"ctrl", "alt"       }, "Right" },
  third_up    = { {"ctrl", "alt"       }, "Up" },
  third_down  = { {"ctrl", "alt"       }, "Down" },
  -- quarters
  top_left    = { {"ctrl",        "cmd"}, "1" },
  top_right   = { {"ctrl",        "cmd"}, "2" },
  bottom_left = { {"ctrl",        "cmd"}, "3" },
  bottom_right= { {"ctrl",        "cmd"}, "4" },
  -- else
  max_toggle  = { {        "alt", "cmd"}, "m" },
  max         = { {"ctrl", "alt", "cmd"}, "Up" },
  undo        = { {        "alt", "cmd"}, "z" },
  center      = { {        "alt", "cmd"}, "c" },
  larger      = { {        "alt", "cmd", "shift"}, "Right" },
  smaller     = { {        "alt", "cmd", "shift"}, "Left" },
})

--------------------------------------------------------------------------------
-- MAIN
--------------------------------------------------------------------------------

-- Send reloaded notification
hs.notify.new({title="Hammerspoon", informativeText="Loaded!!"}):send()
