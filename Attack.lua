-- Attack

--Created by: Heejo Suh
-- Created on: Dec 2016
-- Created for: ICS3U
-- This is attack scene that shows if attacking or getting attacked

------------------------------------------------------------------------

AttackScene = class()

------------------------------------------------------------------------

local spellSpritePos

local size
local angle

local basics
local userGage

local startedTime= ElapsedTime
local timeLimit= 4


------------------------------------------------------------------------

function AttackScene:init()
    -- you can accept and set parameters here
    print("Attack scene")
    
    spellSpritePos= vec2(WIDTH/2, HEIGHT/1.7)
    size= WIDTH/2.5
    angle= 0
    
    if Mode=="game" then
        --if attacking monster
        if Attacked==false then
            print("Attack monster")
            
            --recalculate monster health
            print("Monster health decreased from "..tostring(CurrentMonster["health"]).." by "..tostring(Spells[SpellCastedNumber]["power"]))
                --power increases with different levels and wands
            local additionalSpellPower
            if Level>1 then
                additionalSpellPower= (Level/1.5)*Wands[CurrentWandNumber]["power"]
            else
                additionalSpellPower= Wands[CurrentWandNumber]["power"]
            end
            CurrentMonster["health"]= CurrentMonster["health"] - Spells[SpellCastedNumber]["power"]*additionalSpellPower
        
            
            
            if CurrentMonster["health"]<0 then
                --just set it back to zero
                CurrentMonster["health"]= 0
                print("Monster health: "..CurrentMonster["health"])
                MonsterDefeated= CurrentMonster["monster name"] --set name
            end
        
            saySpell()
            
            sound("A Hero's Quest:Attack Cast 1")
            sound(CurrentMonster["hurt sound"]) --play attacked sound
            --sound(SpellCasted["sound"])
        
        
        --if user attcked   
        elseif Attacked==true then
            print("Attacked")
            --re calculate user health
            UserHealth= UserHealth - CurrentMonster["strength"]
            if UserHealth<0 then
                --just set it back to zero
                UserHealth=0
                print("Die")
            end
        
            --just for time
            speech.volume= 0
            speech.say("hihihihi")
            sound(CurrentMonster["attack sound"]) --play attacking sound
            sound("A Hero's Quest:Hurt 4")
        end
    else
        --practice scene
        sound("A Hero's Quest:Attack Cast 1")
        saySpell()
    end
    
    basics= BasicSprites()
    userGage= GageBar(UserHealth, HealthLevelAmount, vec2(WIDTH/25, HEIGHT/90), color(255, 0, 0, 255), WIDTH/1.06)
end

------------------------------------------------------------------------

function AttackScene:draw()
    -- Codea does not automatically call this method
    background(62, 48, 48, 255)
    
    --background and wand
    basics:drawBackground()
    basics:drawWand()
    
    if Mode=="game" then
        --monster
        CurrentMonsters:draw()
    end
    
    
    if Attacked==false then
        --if attacking, not getting attacked
        pushMatrix()
        if Spells[SpellCastedNumber]["type"]== "grow" then
            --light grows
            size= size+8
            sprite(Spells[SpellCastedNumber]["sprite"], spellSpritePos.x, spellSpritePos.y, size, size)
        else 
            --light turns
            translate(spellSpritePos.x, spellSpritePos.y) --move to orginal position
            angle= angle-3
            rotate(angle) --rotate
            sprite(Spells[SpellCastedNumber]["sprite"], spellSpritePos)
        end
        popMatrix()
               
        
        -- write spell
        fontSize (WIDTH/13)
        if SpriteEnemies==true then--color differs for each mode
            fill(242, 242, 242, 210)
        else
            fill(41, 41, 41, 210)
        end
        
        font("Zapfino")
        textMode (CENTER)
        textWrapWidth(WIDTH*0.9) --restrict range 
        text(Spells[SpellCastedNumber]["spell name"], spellSpritePos.x, spellSpritePos.y)--spell name
    end
    
    
    --time out
    if speech.speaking==false then 
    --go back
        --see if user died
        if Attacked== true then 
            --if had been attacked
            if UserHealth<=0 then
                --died scene
                print("User died")
                Scene.Change("dead")
            else
                print("Attacked by monster")
                Scene.Change("game")
            end
        else 
            --if had casted spell
            if Mode== "practice" then 
                --if practice mode then
                Scene.Change("game")
            else
                if CurrentMonster["health"]<= 0 then
                    --if monster died then
                    GotCoinsAndExp= false
                    Scene.Change("walk")
                else
                    Scene.Change("game")
                end
            end
        end
    end
    
    
    --user gage
    basics:drawUserGage()
end

------------------------------------------------------------------------

function AttackScene:touched(touch)
    -- Codea does not automatically call this method
end

------------------------------------------------------------------------

function saySpell()
    --say spell
    speech.language= "en-GB"
    speech.pitch= 1.1
    speech.rate= 0.45
    speech.voice= speech.voices[9]
    speech.say(Spells[SpellCastedNumber]["spell name"])--say 
end
