-- Basic sprites

--Created by: Heejo Suh
-- Created on: Dec 2016
-- Created for: ICS3U
-- This is class for drawing basic things such as background and wands

------------------------------------------------------------------------

BasicSprites = class()

------------------------------------------------------------------------

local backButton
local userGage
local dotPositions

------------------------------------------------------------------------

function BasicSprites:init()
    -- you can accept and set parameters here
    backButton= Button("Project:button back", vec2(WIDTH/8, HEIGHT-WIDTH/9))
    
    userGage= GageBar(UserHealth, HealthLevelAmount, vec2(WIDTH/25, HEIGHT/30))
    local dotMainPos= vec2(WIDTH/2, HEIGHT/2.4)
    local dotMoveAmount= 1.3
    local dotSpace= WIDTH/4.5
    dotPositions= {                                                             vec2(dotMainPos.x-dotSpace, dotMainPos.y+dotSpace),                                             vec2(dotMainPos.x, dotMainPos.y+dotSpace*dotMoveAmount),                                             vec2(dotMainPos.x+dotSpace, dotMainPos.y+dotSpace),              vec2(dotMainPos.x-dotSpace*dotMoveAmount, dotMainPos.y),                                             vec2(dotMainPos.x, dotMainPos.y),                                             vec2(dotMainPos.x+dotSpace*dotMoveAmount,dotMainPos.y),                     vec2(dotMainPos.x-dotSpace, dotMainPos.y-dotSpace),                                             vec2(dotMainPos.x, dotMainPos.y-dotSpace*dotMoveAmount), vec2(dotMainPos.x+dotSpace,dotMainPos.y-dotSpace)                                            }
end

------------------------------------------------------------------------

function BasicSprites:drawBackground()
    -- Codea does not automatically call this method
    
    --draw background
    if Mode== "practice" then
        sprite("Project:bg1", WIDTH/2, HEIGHT/2, WIDTH, HEIGHT) -- draw background
        sprite("Project:Monster 6", WIDTH/2, HEIGHT/1.8, WIDTH/1.5, WIDTH/1.5) -- draw dummy
    else
        sprite("Project:bg", WIDTH/2, HEIGHT/2, WIDTH, HEIGHT) -- draw background
    end
end

------------------------------------------------------------------------


function BasicSprites:drawWand()
    -- Codea does not automatically call this method
    --draw wand
    sprite(Wands[CurrentWandNumber]["sprite"], WIDTH/2, HEIGHT/4, Wands[CurrentWandNumber]["x"], HEIGHT/1.3)
end

------------------------------------------------------------------------


function BasicSprites:drawBackButton()
    -- Codea does not automatically call this method
    --draw back button
    backButton:draw()
end

------------------------------------------------------------------------

function BasicSprites:returnDotSprites()
    -- Codea does not automatically call this method
    --gets the positions for te dot sprites
    return dotPositions
end

-----------------------------------------------------------------------

function BasicSprites:drawUserGage()
    -- Codea does not automatically call this method
    --draw user gage bar
    userGage= GageBar(UserHealth, HealthLevelAmount, vec2(WIDTH/25, HEIGHT/30), color(255, 0, 0, 255), WIDTH/1.06)
    userGage:draw()
end

-----------------------------------------------------------------------


function BasicSprites:touched(touch)
    -- Codea does not automatically call this method
    backButton:touched(touch)
    if backButton.selected==true then
        sound("Game Sounds One:Assembly 6")
        Scene.Change("mainMenu")
    end
end
