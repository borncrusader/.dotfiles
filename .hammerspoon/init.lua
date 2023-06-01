-- util functions
function openOrFocus(appname)
    app = hs.application.find(appname)

    -- if application is not present atm, open it
    if app == nil then
        hs.application.open(appname)
    else
        current_window = hs.window.focusedWindow()
        windows = app:allWindows()
        wkey = 0
        for key, value in pairs(windows) do
            if value == current_window then
                wkey = key
                break
            end
        end

        -- if the current window is not part of this application or
        -- if we are at the last of the windows,
        -- pick the first window
        if wkey == 0 then
            if app:mainWindow() == nil then
                -- if no window exists; opportunistically try creating a new
                -- window through the menu
                app:activate()
                app:selectMenuItem("New Window")
            else
                app:mainWindow():focus()
            end
        else
            wkey = wkey + 1
            if wkey > #windows then
                wkey = 1
            end

            windows[wkey]:focus()
        end
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

function setupBindings()
    for key, value in pairs(bindings) do
        if value ~= nil then
            hs.hotkey.bind({"cmd"}, tostring(key), function()
                openOrFocus(value)
            end)
        end
    end
end

-- start
hostname = hs.host.localizedName()

-- hotkey bindings
bindings = {}
if hostname == "nucleas-mbp" then
    bindings[1] = "Alacritty"
    bindings[2] = "Code"
    bindings[3] = "Brave"
    bindings[4] = "Discord"
    bindings[5] = "Brave"
    bindings[6] = "Brave"
    bindings[7] = nil
    bindings[8] = "Spotify"
    bindings[9] = "Obsidian"
else
    bindings[1] = "Alacritty"
    bindings[2] = "Code"
    bindings[3] = "Brave"
    bindings[4] = "Slack"
    bindings[5] = "Google Chrome"
    bindings[6] = "Google Calendar"
    bindings[7] = "VMware Fusion"
    bindings[8] = "Spotify"
    bindings[9] = "Obsidian"
end

-- setup bindings
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
