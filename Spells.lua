-- Spells

--Created by: Heejo Suh
-- Created on: Dec 2016
-- Created for: ICS3U
-- This is the spells scene

------------------------------------------------------------------------

SpellsScene = class()

------------------------------------------------------------------------

local backButton

local previousPageButton
local nextPageButton

local currentPage

local eachDotShowTime= 0.2
local nowTime

local dotShown
local dotShownNumber= 0
local dotTable= {}

local dotPositions

------------------------------------------------------------------------


function SpellsScene:init()
    -- you can accept and set parameters here

    
    backButton= Button("Project:button back", vec2(WIDTH/8, HEIGHT-WIDTH/9))
    
    
    
    local pageDivideAmount= WIDTH/5
    
    --need sprites that are big
    previousPageButton= Button("Project:Page flip button", vec2(-pageDivideAmount, HEIGHT/2.5))
    
    
    nextPageButton= Button("Project:Page flip button", vec2(WIDTH+pageDivideAmount, HEIGHT/2.5))
    
    currentPage= 0
    
    
    --dots position
    local basicSprites= BasicSprites()
    dotPositions= basicSprites:returnDotSprites()
end

------------------------------------------------------------------------

function SpellsScene:draw()
    -- Codea does not automatically call this method
    
    previousPageButton:draw()
    nextPageButton:draw()
    --hide the buttons
    
    --bg
    sprite("Project:Wood", WIDTH/2, HEIGHT/2, WIDTH, HEIGHT)--bg
    tint(77, 77, 77, 100)
    sprite("Project:Wood", WIDTH/2, HEIGHT/2, WIDTH, HEIGHT)
    tint(255, 255, 255, 255)
    
    if currentPage==0 then
         --book sprite
        tint(23, 39, 24, 255)
        sprite("Project:Parchmanet", WIDTH/2, HEIGHT/2, WIDTH/1.1, HEIGHT/1.1)
    
        --title
        textMode (CENTER)
        fontSize(WIDTH/12)
        fill(184, 127, 20, 200)
        font("SnellRoundhand-Black")
        text("Book of Spells", WIDTH/2, HEIGHT/1.5)
        
        font("HoeflerText-Italic")
        fill(212, 212, 212, 90)
        fontSize(WIDTH/26)
        text("Touch left or right to turn the page", WIDTH/2, HEIGHT/4) 
        popStyle()
        
    elseif currentPage> 0 then
        --page sprite
        sprite("Project:Parchment (1)", WIDTH/2, HEIGHT/2, WIDTH/1.1, HEIGHT/1.1)
        textWrapWidth(WIDTH/1.3) --restrict range 
        
        --name of spell
        font("SnellRoundhand-Black")
        textMode (CENTER)
        fontSize(WIDTH/16)
        fill(79, 33, 31, 220)
        local nameOfSpell= Spells[currentPage]["spell name"]
        text(nameOfSpell, WIDTH/2, HEIGHT/1.17)
        
        --level to unlock
        font("Papyrus")
        fontSize(WIDTH/40)
        fill(22, 32, 21, 180)
        local levelRequired= Spells[currentPage]["level"]
        text("Requires level "..levelRequired.." or more.", WIDTH/2, HEIGHT/1.28)
        
        --description
        fill(0, 0, 0, 200)
        local description= Spells[currentPage]["description"]
        text(description, WIDTH/2, HEIGHT/1.35)
        
        
        
        --spell in numbers 
        --text(Spells[currentPage]["spell"], WIDTH/2, HEIGHT/1.4)
        
        --spell
        for numberOfDots=1,9 do
            --draw nine dots
            tint(255, 255, 255, 190)
            sprite("Project:brown dot", dotPositions[numberOfDots].x, dotPositions[numberOfDots].y, WIDTH/18, WIDTH/18)
        end
        popStyle()
        drawDot()
    end
    
    backButton:draw()
end

------------------------------------------------------------------------

function SpellsScene:touched(touch)
    -- Codea does not automatically call this method
    
    -- go back
    backButton:touched(touch)
    if backButton.selected==true then
        if GoBackTo == "" then
            --if didnt come from practice mode then
            Scene.Change("mainMenu")
        else
            -- go back to practice scene
            GoBackTo= "" --reset to nothing
            Scene.Change("game")
        end
    end
    
    --previous page
    previousPageButton:touched(touch)
    if previousPageButton.selected==true then
        if currentPage-1 ~= -1 then
            --if not the first page then turn page
            currentPage=currentPage-1
            newSpellSet()
        end
    end
    --next page
    nextPageButton:touched(touch)
    if nextPageButton.selected==true then        
        if currentPage ~= #Spells then
            --if not the last page then turn page
            currentPage=currentPage+1
            newSpellSet()
        end
    end
end


------------------------------------------------------------------------

function newSpellSet()
    --set spell things
    print("Current page "..tostring(currentPage))
    sound("A Hero's Quest:Page Turn")
    if currentPage> 0 then
        --if not first page
        nowTime=ElapsedTime  
        dotTable= {}
        --dots
        for numbers = 1, string.len(Spells[currentPage]["spell"]) do
            table.insert(dotTable, tonumber(string.sub(Spells[currentPage]["spell"], numbers, numbers)))
        end --put into table
    
        dotShown= dotTable[1]
        dotShownNumber= 1
    end
end

------------------------------------------------------------------------


function drawDot()
    --draw next dot
    if nowTime + eachDotShowTime < ElapsedTime then
        --if time passed then
        dotShownNumber= dotShownNumber + 1
        if dotShownNumber== #dotTable+1 then         
            --if last number then give a few seconds
            nowTime= ElapsedTime
            dotShownNumber= -2 --Number of each dot show time waited
        else
            nowTime= ElapsedTime
            dotShown= dotTable[dotShownNumber]
        end
    end
       
    if dotShownNumber > 0 then
        --print("dot shown"..tostring(dotShown))
        sprite("Project:light", dotPositions[dotShown].x, dotPositions[dotShown].y, WIDTH/8, WIDTH/8)
    end
end
