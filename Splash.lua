-- Splash

--Created by: Heejo Suh
-- Created on: Dec 2016
-- Created for: ICS3U
-- This is splash scene that shows the company logo, then the game logo, then transitions to the main manu screen.

------------------------------------------------------------------------


SplashScene = class()

------------------------------------------------------------------------


local durationTime= ElapsedTime
local transitionTime


------------------------------------------------------------------------


function SplashScene:init()
    
    transitionTime= 2.2
end


------------------------------------------------------------------------


function SplashScene:draw()
    -- Codea does not automatically call this method
    background(0, 0, 0, 255)
    
    if (durationTime + 2*transitionTime < ElapsedTime) then 
        --if time twice passed, move scene
        if FirstGamePlay==false then
            Scene.Change("mainMenu")
        else
            saveLocalData("tutorials", false)
            print("Tutorials")
            Scene.Change("help")
        end
    elseif (durationTime + transitionTime < ElapsedTime) then
        --for the next few seconds, show game logo
        background(31, 31, 31, 255)
        --Draw logo
        sprite("Project:name", WIDTH/2, HEIGHT/2, WIDTH/1.2, WIDTH/1.2)
    else
        background(255, 255, 255, 255)
        --Draw logo
        tint(131, 29, 29, 255)
        sprite("Project:brown dot", WIDTH/2+10, HEIGHT/2, WIDTH/1.1, WIDTH/1.1)
        fontSize(WIDTH/9)
        font("Marion-Italic")
        fill(33, 81, 31, 255)
        text(":D: Works", WIDTH/2, HEIGHT/1.9)
    end
    
end


------------------------------------------------------------------------


function SplashScene:touched(touch)
    -- Codea does not automatically call this method
end
