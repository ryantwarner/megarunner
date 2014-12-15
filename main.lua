-- main
system.activate( "touch" );

-- Vardump
vardump = require("vardump")
f = require("functions")

-- Create config
local config = require("config")

-- some globals
currentMenu = nil
game = nil

isPaused = nil

-- Main function
local function main()

        -- functions

        -- creates an xml object for the menu then displays the main menu
        mainMenuXML = f.returnXML("menus.xml")
        currentMenu = f.displayMenu(mainMenuXML.menus.menu[1])
        
        --local g = require("game")
        --game = g.init(game,"normalrun")
        
        print "main loaded"

	return true

end

-- Begin
main()
