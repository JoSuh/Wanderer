-- Buy

-- Created by: Heejo Suh
-- Created on: Dec 2016
-- Created for: ICS3U
-- This is the Buy class for the pop up for the shop

------------------------------------------------------------------------

Buy = class()

local showWords
local item

local okayButton
local yesButton
local noButton

local buyMode


------------------------------------------------------------------------

function Buy:init(itemInfoNumber)
    -- you can accept and set parameters here
    item= Wands[itemInfoNumber]
    itemNumber= itemInfoNumber
    
    showWords= "Do You want to unlock the "..item["wand name"].." for "..tostring(item["cost"]).." coins?"
    
    
    okayButton= Button("Project:onoff button", vec2(WIDTH/2, HEIGHT/3))
    yesButton= Button("Project:onoff button", vec2(2.5*WIDTH/8, HEIGHT/3))
    noButton= Button("Project:onoff button", vec2(5.5*WIDTH/8, HEIGHT/3))
    
    
    
    
    buyMode= "ask"
end

------------------------------------------------------------------------


function Buy:draw()
    -- Codea does not automatically call this method
    --pop up
    tint(213, 194, 171, 255)
    sprite("Project:parchment old", WIDTH/2, HEIGHT/2, WIDTH/1.3, HEIGHT/1.7) 
    tint(255, 255, 255, 255)
    
    fill(7, 7, 6, 220)
    font("Papyrus-Condensed")
    textWrapWidth(WIDTH/1.9)
    textMode(CENTER)
    
    fontSize(WIDTH/22)
    text(showWords, WIDTH/2, HEIGHT/1.7)
    
    if buyMode=="ask" then
        yesButton:draw()
        noButton:draw()
        fontSize(WIDTH/17)
        text("Yes", 2.5*WIDTH/8, HEIGHT/3)
        text("No", 5.5*WIDTH/8, HEIGHT/3)
    elseif buyMode=="showing okay" then
        print("Work")
        okayButton:draw()
        fontSize(WIDTH/17)
        text("Okay", WIDTH/2, HEIGHT/3)
    end
end

------------------------------------------------------------------------


function Buy:touched(touch)
    -- Codea does not automatically call this method
    yesButton:touched(touch)
    if yesButton.selected==true then
        sound("Game Sounds One:Reload 2")
        print("Yes button seleted")
        check()
    end
    noButton:touched(touch)
    okayButton:touched(touch)
    if noButton.selected==true then
        sound("Game Sounds One:Reload 2")
        print("no button selected")
        buyMode= "done" --end popup
    end
    if okayButton.selected==true then
        sound("Game Sounds One:Reload 2")
        print("okay button selected")
        buyMode= "done" --end popup
    end
end

------------------------------------------------------------------------


function Buy:done()
    -- check if its done or not
    if buyMode=="done" then
        print("Delete popup")
        return true
    else
        return false
    end
end

------------------------------------------------------------------------


function check()
    --check if user is allowed to purchase
    print("Checking if can buy")
    
    if Level>= tonumber(item["level"]) then
        --if right level
        if MoneyHave>= tonumber(item["cost"]) then
            --if enough money
            --unlock wand
            WandUnlocked[itemNumber]=true
            saveLocalData("wandUnlocked"..tostring(itemNumber), true)
            --reduce money
            MoneyHave= MoneyHave-tonumber(item["cost"])
            saveLocalData("money", MoneyHave)
            --set wand number
            CurrentWandNumber= itemNumber
            saveLocalData("wandNumber", CurrentWandNumber)
            
            sound("Game Sounds One:Assembly 4")
            showWords= "Purchase complete!"
            buyMode= "showing okay"
            
            print("Bought")
        else --not enough money
            showWords= "You don't have enough money"
            buyMode= "showing okay"
            
            print("No money")
        end
    else --not enough level
        showWords= "You need to be at least level "..tostring(item["level"]).." to unlock this wand"
        buyMode= "showing okay"
        print("No level")
    end
end
