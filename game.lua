module(..., package.seeall)

--physics
local physics = require("physics")
physics.start()

-- sprites
local sprites = require("sprites")

function playerDied()
    print "dead"
    Runtime:removeEventListener("enterFrame", scrollLevel);
    game:removeSelf()
    menuGroup:removeSelf()
    
    local deadMenu = display.newGroup()
    deadMenu:insert(display.newImage("images/you-died.png",0,0))
    
    local btns = {
        mainMenu = display.newImage("images/mainmenu-button.png",10,394);
        replay = display.newImage("images/play.png",714,394);
    };
    --menu.pause:addEventListener("touch",f.buttonClick)
    for i,v in pairs(btns) do
        v.func = "showMenu"
        deadMenu:insert(v)
        --v:addEventListener("touch",f.buttonClick)        
    end
    
end

function scrollLevel(event)
    --[[if player.x + 800 >= game[1].width then
        local tempX = game[1].width
        game[1]:removeSelf()
        game:insert(1,display.newImage("images/background.jpg",tempX,0)
    end]]--
    
    if player.y >= 480 then
        
        --game:removeSelf()
        
        --event.target
        playerDied()
    end

    newX = game.x - 5
    --[[if newX > game.width then
        game:insert(display.newImage("images/background.jpg",newX,0))
    end]]
    game.x = newX
    player.x = (newX * -1) + 200
   
end

game = display.newGroup()
menuGroup = display.newGroup()
player = nil

function init(s,p)
    print "game init"
    
    local f = require("functions")
    
    game:insert(1,display.newImage("images/background.jpg",0,0))
    print (game[1].width)
    player = sprites.init(sprites, p)
    --player:addEventListener("touch",f.buttonClick)
    physics.addBody( player, { density=3.0, friction=0.5, bounce=0.3} )
    player.isFixedRotation = true
    player.x = 200
    player.y = 404
    game:insert(player)
    
    --print (game[2].x)

    -- create a piece of ground
    ground = display.newRect(0, 404, 400, 76)
    physics.addBody( ground, "static", { friction=0.5, bounce=0.2 } )
    game:insert(ground)
    
    ground2 = display.newRect(600, 354, 300, 76)
    physics.addBody( ground2, "static", { friction=0.5, bounce=0.2 } )
    game:insert(ground2)
    
    ground3 = display.newRect(1000, 404, 300, 76)
    physics.addBody( ground3, "static", { friction=0.5, bounce=0.2 } )
    game:insert(ground3)
    
    --game:addEventListener("touch",screenTouch)
    Runtime:addEventListener("enterFrame", scrollLevel);
    
    local menu = {
        pause = display.newImage("images/pause.png",10,10);
        slide = display.newImage("images/slide.png",10,394);
        jump = display.newImage("images/jump.png",714,394);
    };
    --menu.pause:addEventListener("touch",f.buttonClick)
    for i,v in pairs(menu) do
        menuGroup:insert(v)
        --v.func = i
        --v:addEventListener("touch",f.buttonClick)        
    end
    
    menuGroup[3]:addEventListener("touch",playerJump)
    
    --return game
end

function playerJump(event)
    if event.phase == "began" then
        print "playerjump"
        game[2]:applyForce(0,3000,player.x,player.y)
        print (player.y)
    end
end