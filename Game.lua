-- Game

--Created by: Heejo Suh
-- Created on: Dec 2016
-- Created for: ICS3U
-- This is the game scene, used for both practice and actual game.

------------------------------------------------------------------------


GameScene = class()

------------------------------------------------------------------------


local touchLight
local touchLightPosition

local dots
local dotPositions
local touchedDots=""

local whooshSounds={"A Hero's Quest:Swing 1", "A Hero's Quest:Swing 2", "A Hero's Quest:Swing 3"}


local potionButton
local pauseButton

local basicSprites


local startTime

local spellsButton


------------------------------------------------------------------------

function GameScene:init()
    -- you can accept and set parameters here
    print("Game scene")
    
    Attacked= false --reset to false
    
    potionButton= Potion()
    basicSprites= BasicSprites()
    --dots position
    dotPositions= basicSprites:returnDotSprites()
    
    dots={}
    for numberOfDots= 1, 9 do
        --put in dots
        --sprite("Project:brown dot")
        table.insert(dots, SpriteObject("Documents:Light", dotPositions[numberOfDots]))
        dots[numberOfDots].draggable= false --not draggable
    end
    
    --touchLight
    touchLightPosition= vec2(-300,-300) --out of screen
    
    if Mode=="game" then
        pauseButton= Button("Project:pause button", vec2(WIDTH-WIDTH/8, HEIGHT-WIDTH/9)) -- for game
    else
        spellsButton= Button("Project:book", vec2(WIDTH-WIDTH/8, HEIGHT-WIDTH/9)) -- for practicing
    end
    
   -- userGage= GageBar(UserHealth, HealthLevelAmount, vec2(WIDTH/25, HEIGHT/30), color(255, 0, 0, 255), WIDTH/1.06)
    
    startTime= ElapsedTime 
end

------------------------------------------------------------------------


function GameScene:draw()
    -- Codea does not automatically call this method
    background(0, 39, 255, 255)
    
    --draw background 
    basicSprites:drawBackground() 
    --draw monsters
    if Mode=="game" then
        --draw monster
        CurrentMonsters:draw() 
    end
    
    -- draw wand
    basicSprites:drawWand() 
    --potions bottle
    potionButton:draw()
    
    --draw dots
    for everyDots= 1, 9 do
        tint(255, 255, 255, 10) --translucent
        dots[everyDots]:draw()
        --draw dots on top 
        tint(255, 255, 255, 110) --translucent
        sprite("Project:brown dot", dotPositions[everyDots].x, dotPositions[everyDots].y)
    end 
    

    --draw touch light
    
    touchLight= SpriteObject("Project:Black Spot Small", touchLightPosition)
   -- sprite("Project:40 dot")
    tint(127, 127, 127, 80)
    touchLight:draw()
    popStyle()
    
    if Mode~="game" then
        --draw go back button
        basicSprites:drawBackButton()
        spellsButton:draw()
    else
        --draw pause button
        CurrentMonsters:checkIfAttacked(startTime) --check if attacked
        pauseButton:draw()
    end
    
    -- user gage bar
    --userGage:draw()
    basicSprites:drawUserGage()
    
    
    if Mode=="game" then
        --floor number
        fill(255, 164, 0, 220)
        font("Papyrus-Condensed")
        textWrapWidth(WIDTH/1.1)
        fontSize(WIDTH/24)
        textMode(CENTER)
        text("Floor "..tostring(math.tointeger(CurrentGameFloor)), WIDTH/2, HEIGHT/1.1)
    end
end

------------------------------------------------------------------------


function GameScene:touched(touch)
    -- Codea does not automatically call this method
    
    basicSprites:touched(touch)
    potionButton:touched(touch)
    
    --move touch light
    if touch.state==ENDED then
        --if finger off of the screen
        local spellCasted= touchedDots --set to spell
        for numberOfSpells= 1, #Spells do
            --check if spell
            if Spells[numberOfSpells]["spell"]== spellCasted and Spells[numberOfSpells]["level"]<=Level then
                print(Spells[numberOfSpells]["level"])
                SpellCastedNumber= numberOfSpells
                Scene.Change("attack")
            end
        end
        touchedDots= ""
        touchLightPosition= vec2(-300,-300) --move out of screen
    else
        touchLightPosition= vec2(touch.x, touch.y)--move to touch location
    end
       
    
    --touched dots
    for numberOfDots=1, 9 do
        if ((touchLight:isTouching(dots[numberOfDots]))==true and string.sub(touchedDots, #touchedDots)~=tostring(numberOfDots)) then
            --if touching a dot and the dot isn't previously touched or nothing has been touched then
            sound(whooshSounds[math.random(#whooshSounds)]) --play a random whoosh sound
            
            touchedDots= touchedDots..tostring(numberOfDots)
            print(touchedDots)
        end
    end
    
    if Mode=="game" then
        --pause button
        pauseButton:touched(touch)
        if pauseButton.selected== true then
            Scene.Change("pause")
        end
    else
        --spells button
        spellsButton:touched(touch)
        if spellsButton.selected== true then
            GoBackTo= "game"
            Scene.Change("spells")
        end
    end
end
