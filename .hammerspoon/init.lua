-- utility functions
function openOrFocus(appname)
    app = hs.application.find(appname)

    -- if application is not present atm, open it
    if app == nil then
        hs.application.open(appname)
    else
        current_window = hs.window.focusedWindow()

        windows = app:allWindows()

        -- sort the table so that we always can cycle through the windows
        table.sort(windows, function(left, right)
            return left:title():lower() < right:title():lower()
        end)

        -- sometimes; there might be entries with no titles which we don't want
        -- to entertain
        hs.fnutils.ifilter(windows, function(value)
            return value:title() ~= ""
        end)

        for key, value in pairs(windows) do
            log.d(string.format("%s:%s:%s", key, value, value:isMinimized()))
        end

        wkey = 0
        for key, value in pairs(windows) do
            if value == current_window then
                wkey = key
                break
            end
        end

        log.d(string.format("current window is %d", wkey))

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
            start_wkey = wkey
            repeat
                wkey = wkey + 1
                if wkey > #windows then
                    wkey = 1
                end

                next_window = windows[wkey]
                -- if a window is minimized; don't bring it to the forefront
                if not next_window:isMinimized() then
                    log.d(string.format("switching to %d", wkey))
                    next_window:focus()
                    break
                end
            until wkey == start_wkey
        end
    end
end

function shrink(direction, fast)
    window = hs.window.focusedWindow()
    if window == nil then
        hs.alert.show("No focused window")
        return
    end

    wf = window:frame()
    f = window:screen():frame()

    fast = fast or false
    if fast == true then
        pt = 0.25
    else
        pt = 0.1
    end

    set = false
    if direction == "left" then
        wf.w = wf.w - math.floor(pt * f.w)
        set = true
    elseif direction == "right" then
        wf.w = wf.w - math.floor(pt * f.w)
        wf.x = f.w - wf.w
        set = true
    elseif direction == "up" then
        wf.h = wf.h - math.floor(pt * f.h)
        set = true
    elseif direction == "down" then
        wf.h = wf.h - math.floor(pt * f.h)
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

-- regular functions
function setupGlobals()
    hostname = hs.host.localizedName()

    -- default logger with info log level
    -- 3 for info; 4 for debug
    log = hs.logger.new("logger", 3)
end


function setupBindings()
    local bindings = {}
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

    for key, value in pairs(bindings) do
        if value ~= nil then
            hs.hotkey.bind({"cmd"}, tostring(key), function()
                openOrFocus(value)
            end)
        end
    end

    -- help
    hs.hotkey.bind({"cmd", "ctrl"}, "h", function()
        local helpString = ""
    
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

    -- window functions
    hs.hotkey.bind({"cmd", "ctrl"}, "left", function()
        shrink("left")
    end, nil, function()
        shrink("left", true)
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

    hs.hotkey.bind({"cmd", "ctrl"}, "m", function()
        window = hs.window.focusedWindow()
        if window == nil then
            hs.alert.show("No focused window")
        else
            window:maximize(0)
        end
    end)
end

function init()
    setupGlobals()

    setupBindings()

    -- finally clear the console
    hs.console.clearConsole()
end

init()
