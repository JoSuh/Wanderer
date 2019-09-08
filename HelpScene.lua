-- Spells

--Created by: Heejo Suh
-- Created on: Dec 2016
-- Created for: ICS3U
-- This is the help scene

------------------------------------------------------------------------

HelpScene = class()
------------------------------------------------------------------------


local backButton

local previousPageButton
local nextPageButton

local eachPassTime= 2.5
local currentPage
local currentTime= ElapsedTime
 

local helpImages= {"Project:Tutorial 16", "Project:Tutorial 1", "Project:Tutorial 2", "Project:Tutorial 3", "Project:Tutorial 4", "Project:Tutorial 5", "Project:Tutorial 6", "Project:Tutorial 7", "Project:Tutorial 8", "Project:Tutorial 9", "Project:Tutorial 10", "Project:Tutorial 11", "Project:Tutorial 12", "Project:Tutorial 13", "Project:Tutorial 14", "Project:Tutorial 15", "Project:Tutorial 16"}


------------------------------------------------------------------------

function HelpScene:init()
    -- you can accept and set parameters here

    
    if FirstGamePlay==false then
        backButton= Button("Project:button back", vec2(WIDTH/8, HEIGHT-WIDTH/9))  
        --need sprites that are big
        previousPageButton= Button("Project:Page flip button", vec2(WIDTH/7, HEIGHT/2.5))
        nextPageButton= Button("Project:Page flip button", vec2(6*WIDTH/7, HEIGHT/2.5))
    end
    
    currentPage= 1
end


------------------------------------------------------------------------

function HelpScene:draw()
    -- Codea does not automatically call this method
    
    --forced tutorial or not
    if FirstGamePlay==false then
        previousPageButton:draw()
        nextPageButton:draw()
    end
    
    --hide the buttons behind background
    background(40, 60, 29, 255)
    sprite(helpImages[currentPage], WIDTH/2, HEIGHT/2, WIDTH, HEIGHT)--bg
    
    
    --If not forced tutorial
    if FirstGamePlay==false then
        backButton:draw()
        fill(255, 205, 0, 255)
        font("Papyrus")
        font(WIDTH/8)
        if currentPage==1 then
            --explanation on the first tutorial page
            text("Touch left or right to\nnavigate through the tutorials", WIDTH/2, HEIGHT/6)
        end
    end
    
    --if forced tutorial
    if FirstGamePlay==true then
        --slide pictures
        for numberOfTutorials= 1, #helpImages do
            if currentPage*eachPassTime< ElapsedTime then
                if currentPage== #helpImages then
                    FirstGamePlay= false
                    Scene.Change("mainMenu")
                else
                    currentPage= currentPage+1
                end
            end
        end
    end
end


------------------------------------------------------------------------

function HelpScene:touched(touch)
    -- Codea does not automatically call this method
    if FirstGamePlay==false then
        -- go back
        backButton:touched(touch)
        if backButton.selected==true then
            Scene.Change("settings")
        end  
        --previous page
        previousPageButton:touched(touch)
        if previousPageButton.selected==true then
            if currentPage-1 > 0 then
                --if not the first page then turn page
                currentPage=currentPage-1
            end
        end
        --next page
        nextPageButton:touched(touch)
        if nextPageButton.selected==true then        
            if currentPage+1 <= #helpImages then
                --if not the last page then turn page
                currentPage=currentPage+1
            end
        end
    end
end
