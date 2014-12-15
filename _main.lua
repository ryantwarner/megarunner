-- main
system.activate( "touch" )

-- gracefully exit game
function quitGame()
    os.exit()
end

function gameInit(event)

    -- remove the main menu & set to nil
    menuObj:removeSelf()
    menuObj = nil

    -- init game
    game = require("game")
    gameObj = game.init(game, event.target["param"])
end

-- init menu
mainMenu = require("menu")
menuObj = mainMenu.init(mainMenu)

-- init game
-- local game = require("game")
-- game.init(game)