module(..., package.seeall)

-- Create Functions 

function init(s)
    -- xmlParser

    local f = require("functions")

    print "menu init"
    
    mainMenuXML = f.returnXML("menus.xml")

    v.vardump(mainMenuXML)
    
    self = f.displayMenu(mainMenuXML)
    
    return self
end
