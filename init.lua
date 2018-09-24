--------------------------------------------------------------------------------
-- Caffeine
--------------------------------------------------------------------------------

function caffeineClicked()
  displayIdleStatus = hs.caffeinate.toggle("displayIdle")

  if displayIdleStatus then
    caffeine:setTitle("🌝")
  else
    caffeine:setTitle("🌚")
  end
end

caffeine = hs.menubar.new()
caffeine:setClickCallback(caffeineClicked)
caffeineClicked()
