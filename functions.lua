module(..., package.seeall)

function quitGame()
    os.exit()
end

function buttonClick(event)
    local funcName = event.target.func

    if funcName == "quitGame" then
        os.exit()
    elseif funcName == "showMenu" then

        for i,v in ipairs(mainMenuXML.menus.menu) do
            if v.menuid == event.target.param then
                print("showing " .. event.target.param)
                currentMenu:removeSelf()
                currentMenu = displayMenu(mainMenuXML.menus.menu[i])
                break
            else
                print ("no match")
            end
        end
        --event.target.parent:insert(menu)
        
    elseif funcName == "startGame" then
        currentMenu:removeSelf()
        currentMenu = nil
        print "game start"
        local g = require("game")
        game = g.init(g,"normalrun")
        
    elseif funcName == "pause" then
        isPaused = true
        print "paused"
        --event.target.parent.sibling:removeSelf()
        
    elseif funcName == "jump" then
        print "jump"
        player:applyForce(0,10,player.x,player.y)
    
    else
        print "unknown button"
    end

end

function screenTouch(event)
    print "screen touched"
end

function returnXML(xmlFile)
    local xmlParser = require("xml")
    local path = system.pathForFile(xmlFile, system.ResourceDirectory)
    local f, reason = io.open( path, "r" )
    local xmlStr = f:read("*all")
    local xml = xmlParser.parseXML(xmlStr)
    
    return xml
end

function displayMenu(m)
    menu = display.newGroup()
    
    for i,v in ipairs(m.images.image) do
        menu:insert(display.newImage(v.src,v.x,v.y))
        lastItem = i
    end
    
    for i,v in ipairs(m.buttons.button) do
        
        btn = display.newImage(v.src,v.x,v.y)
        btn.func = v.func
        btn.param = v.funcParams
        btn:addEventListener("touch",buttonClick)
        
        menu:insert(btn)
    end

    return menu
end