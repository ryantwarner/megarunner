module(..., package.seeall)

require "sprite"

function init(s,p)
    local f = require("functions")
    local xml = f.returnXML("megaman-sheet.xml")

    print "sprites init"
    print (p)
    self = s
    
    -- create a table for sprite data
    spriteDataTable = {}
    spriteDataTable["src"] = xml.spritesheet.src 
    
    -- loop through sprite data xml to create tables of frames
    for i,v in ipairs(xml.spritesheet.sequences.sequence) do
        spriteDataTable[v.name] = getSpriteSheetDataFromXML(v)
        spriteDataTable[v.name]["loop"] = v.loop
        spriteDataTable[v.name]["speed"] = v.speed
    end
    
    -- like php vardump. not mine. works ok
    -- vardump.vardump(spriteDataTable)

    -- load the sprite using the sprite definitions from spriteData
    local spriteSheet = sprite.newSpriteSheetFromData(spriteDataTable.src, spriteDataTable[p] )

    -- get the last frame of the sprite.
    -- sigh. how can this not be a build in function? i have to be missing something.
    lastFrame = #spriteDataTable[p].frames
    
    loop = spriteDataTable[p]["loop"]
    speed = spriteDataTable[p]["speed"]
    -- create a spriteset 
    local spriteSet = sprite.newSpriteSet(spriteSheet, 1, lastFrame)
    
    -- add the sprite sequence
    sprite.add( spriteSet, p, 1, lastFrame, speed, loop) 
    
    --create a sprite instance, prep the sequence, and play the animation
    si = sprite.newSprite( spriteSet )
    si:prepare(p)
    si:scale(3,3)
    si:play()

    return si
end

function getSpriteSheetDataFromXML(xml)
    
    local sheet = { frames = {} }
    
    for i,v in ipairs(xml.frames.frame) do
        local t = {
            spriteColorRect = {  x = tonumber(v.framex), y = tonumber(v.framey), width = tonumber(v.framew), height = tonumber(v.frameh) },
            textureRect = { x = tonumber(v.framex), y = tonumber(v.framey), width = tonumber(v.framew), height = tonumber(v.frameh) },
            spriteSourceSize = {  width = tonumber(v.framew), height = tonumber(v.frameh) }, 
            spriteTrimmed = false,
            textureRotated = false
        }
        table.insert(sheet.frames, t)
    end
    
    return sheet
end