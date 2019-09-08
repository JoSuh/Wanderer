-- Gage bar

--Created by: Heejo Suh
-- Created on: Dec 2016
-- Created for: ICS3U
-- This is class for health gage bars

------------------------------------------------------------------------

GageBar = class()

------------------------------------------------------------------------

local health
local fullHealth
local position
local colour

local lineWidth
local barlength
local barWidth


------------------------------------------------------------------------


function GageBar:init(healthAmount, fullHealthAmount, barPosition, colourSet, widthOfBar)
    -- you can accept and set parameters here
    health= healthAmount
    fullHealth= fullHealthAmount
    position= barPosition
    colour= colourSet or color(255, 0, 0, 255)
    colour= color(colour.r, colour.g, colour.b, 80) --make colour translucent
    
    lineWidth= 3
    barlength= HEIGHT/43
    barWidth= widthOfBar or WIDTH/1.06
end


------------------------------------------------------------------------


function GageBar:draw()
    -- Codea does not automatically call this method
    
    --outline
    fill(0, 0, 0, 255)
    rect(position.x-lineWidth, position.y-lineWidth, barWidth+ 2*lineWidth, barlength+2*lineWidth)
    
    --bar
    fill(colour)
    rect(position.x, position.y, health*barWidth/fullHealth, barlength)
    
    --dividing lines
    fill(0, 0, 0, 250)
    for numberOfLines=1, 10 do--gage lines
        rect(position.x+numberOfLines*barWidth/10, position.y, lineWidth-1, barlength)
    end
    
end

------------------------------------------------------------------------


function GageBar:touched(touch)
    -- Codea does not automatically call this method
end
