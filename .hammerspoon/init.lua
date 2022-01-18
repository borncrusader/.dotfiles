-- util functions
function openOrFocus(appname)
    app = hs.application.find(appname)
    if app == nil then
        hs.application.open(appname)
    else
        app:mainWindow():focus()
    end
end

function shrink(direction)
    window = hs.window.focusedWindow()
    if window == nil then
        hs.alert.show("No focused window")
        return
    end

    wf = window:frame()
    f = window:screen():frame()

    set = false
    if direction == "left" then
        wf.w = wf.w - math.floor(0.1 * f.w)
        set = true
    elseif direction == "right" then
        wf.w = wf.w - math.floor(0.1 * f.w)
        wf.x = f.w - wf.w
        set = true
    elseif direction == "up" then
        wf.h = wf.h - math.floor(0.1 * f.h)
        set = true
    elseif direction == "down" then
        wf.h = wf.h - math.floor(0.1 * f.h)
        -- this is slightly round about to determine where the window should start
        -- coz sometimes I like having the dock and accommodating for it
        wf.y = f.y + f.h - wf.h
        set = true
    end

    if set then
        window:setFrame(wf, 0)
        -- setting succeeded
        if window:frame() == wf then
            return
        end
    end

    -- default
    wf.x = f.x 
    wf.y = f.y
    wf.w = f.w
    wf.h = f.h

    window:setFrame(wf, 0)
end

-- hotkey bindings
bindings = {}
bindings[1] = "iTerm2"
bindings[2] = "Visual Studio Code"
bindings[3] = "Firefox"
bindings[4] = "Google Chrome"
bindings[5] = "Slack"
bindings[6] = "Google Calendar"
bindings[7] = "VMware Fusion"
bindings[8] = "Spotify"
bindings[9] = "Obsidian"

-- setup bindings
function setupBindings()
    for key, value in pairs(bindings) do
        hs.hotkey.bind({"cmd"}, tostring(key), function()
            openOrFocus(value)
        end)
    end
end

setupBindings()

-- help
hs.hotkey.bind({"cmd", "ctrl"}, "h", function()
    helpString = ""

    -- bindings
    for key, value in pairs(bindings) do
        helpString = helpString .. string.format("cmd + %d - %s\n", key, value)
    end

    -- window functions
    helpString = helpString .. "cmd + ctrl + m - maximize\n"
    helpString = helpString .. "cmd + ctrl + {dir} - tile in direction\n"

    helpString = helpString .. "cmd + ctrl + h - help"

    hs.alert.show(helpString)
end)

-- Window Functions
hs.hotkey.bind({"cmd", "ctrl"}, "m", function()
    window = hs.window.focusedWindow()
    if window == nil then
        hs.alert.show("No focused window")
    else
        window:maximize(0)
    end
end)

hs.hotkey.bind({"cmd", "ctrl"}, "left", function()
    shrink("left")
end)

hs.hotkey.bind({"cmd", "ctrl"}, "right", function()
    shrink("right")
end)

hs.hotkey.bind({"cmd", "ctrl"}, "up", function()
    shrink("up")
end)

hs.hotkey.bind({"cmd", "ctrl"}, "down", function()
    shrink("down")
end)
