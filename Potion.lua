-- potion

--Created by: Heejo Suh
-- Created on: Dec 2016
-- Created for: ICS3U
-- This is class for potions


------------------------------------------------------------------------

Potion = class()

------------------------------------------------------------------------

local __potionWaitTime= 0 --potion cool time, set it to zero as default

local __potionHealAmount= 100

local __potionCoolTimeSeconds --how long it takes for the potion to be able to be used again

------------------------------------------------------------------------

function Potion:init()
    -- you can accept and set parameters here
    __potionButton= Button("Project:potion", vec2(WIDTH/8, WIDTH/6))
    
    if Mode== "game" then
    --differs for each mode
    __potionCoolTimeSeconds= 2
    print("potion wait time is longer")
    else
    __potionCoolTimeSeconds= 0.8
    end
end

------------------------------------------------------------------------

function Potion:draw()
    -- Codea does not automatically call this method
    --set cool time for potions and draw potion button
    if NumberOfPotions>0 then --if have potions
        if __potionWaitTime>0 then
            __potionWaitTime= __potionWaitTime-0.01
        end
        --draw potion
        
        tint(255, 255, 255, 255-(255/1.5*__potionWaitTime))
        __potionButton:draw()
        
        tint(255, 255, 255, 255)
        
        fill(0, 0, 0, 220)
        font("Papyrus-Condensed")
        fontSize(WIDTH/22)
        text(math.tointeger(NumberOfPotions), WIDTH/8+20, WIDTH/6.5-20)
    end
end

------------------------------------------------------------------------

function Potion:touched(touch)
    -- Codea does not automatically call this method
    if __potionWaitTime<=0 then
        --if not in time limit
        __potionButton:touched(touch)
        if __potionButton.selected==true and NumberOfPotions>=1 then
            print("Potion button touched")
            sound("A Hero's Quest:Drink 2")
            NumberOfPotions= NumberOfPotions-1
            __potionWaitTime= __potionCoolTimeSeconds --potion cooltime
            UserHealth= UserHealth + __potionHealAmount
            if UserHealth> HealthLevelAmount then
                --just set it back to max
                UserHealth= HealthLevelAmount
            end
            saveLocalData("userHealth", UserHealth)
        else--no more potions
            return false
        end
    end
end
