-- Shop

--Created by: Heejo Suh
-- Created on: Dec 2016
-- Created for: ICS3U
-- This is the shop scene

------------------------------------------------------------------------

ShopScene = class()


------------------------------------------------------------------------


local buyPotionButton
local potionCost= 50

local backButton


local zeroWidth= 0 --default
local wandSpace= WIDTH/3.2
local wandChooseButton

local currentWandInTheCentre= 0 --default
local middleSpace= wandSpace*0.9

local shopType

local allowTouch= true
local popUp


------------------------------------------------------------------------


function ShopScene:init()
    -- you can accept and set parameters here
    
    buyPotionButton= Button("Project:buy button", vec2(2.1*WIDTH/3, HEIGHT/5.5))
    
    
    
    backButton= BasicSprites()
    
    shopType= "shop"
    
    --wands
    --use button
    wandChooseButton= Button("Project:brown dot", vec2(WIDTH/2, HEIGHT/2.1))
    
    popUp= Buy(1) --set to random at first
    
end

------------------------------------------------------------------------

function ShopScene:draw()
    -- Codea does not automatically call this method
    --base
    sprite("Project:Wood", WIDTH/2, HEIGHT/2, WIDTH, HEIGHT)
    --bg
    tint(77, 77, 77, 100)
    sprite("Project:Wood", WIDTH/2, HEIGHT/2, WIDTH, HEIGHT)
    --Middle block
    tint(187, 187, 187, 255)
    sprite("Project:Wood", WIDTH/2, HEIGHT/1.6, WIDTH, HEIGHT/2.5)
    --light block
    fill(223, 190, 146, 50)
    rectMode(CENTER)
    rect(WIDTH/2, HEIGHT/1.6, middleSpace, HEIGHT/2.5)
    
    
    tint(255, 255, 255, 255)
    
    --potion
    sprite("Project:potion", WIDTH/3, HEIGHT/5.5, WIDTH/4, WIDTH/4)
    
    buyPotionButton:draw()
    
    --potion cost
    fill(18, 17, 14, 255)
    font("Copperplate-Bold")
    textWrapWidth(WIDTH/3)
    fontSize(WIDTH/20)
    text(potionCost.." each", 2.5*WIDTH/5, HEIGHT/3)
    
    
    
    --potion number
    fill(255, 200, 0, 220)
    font("Papyrus")
    fontSize(WIDTH/15)
    text(math.tointeger(NumberOfPotions), 2.5*WIDTH/5, HEIGHT/5.7)
    
    --text("Buy", 2*WIDTH/3, HEIGHT/5.6)
    
    
    --money
    fill(255, 200, 0, 250)
    font("Papyrus-Condensed")
    textWrapWidth(WIDTH/1.85)
    fontSize(WIDTH/17)
    text(math.tointeger(MoneyHave).." coins", WIDTH/2, HEIGHT/1.1)
    
    --draw wands
    
    local currentWand= false
    for numberOfWands= 1, #Wands do
        local xPos= zeroWidth+ numberOfWands*wandSpace
        
        if xPos>=0 and xPos<=WIDTH then
            --if on the screen currently
            sprite(Wands[numberOfWands]["sprite"], xPos, 3.3*HEIGHT/5, Wands[numberOfWands]["x"]/2.5, WIDTH/3.5) --draw wands   
            if WandUnlocked[numberOfWands]==false then
                --draw locks
                sprite("Project:Lock", xPos, 3.3*HEIGHT/5, WIDTH/5, WIDTH/5)
            end
            --set one in the centre
            if xPos > WIDTH/2-middleSpace/2 and xPos < WIDTH/2+middleSpace/2 then
                --if a certain wand is in the centre then
                currentWand=true
                currentWandInTheCentre= numberOfWands
            end
        end
    end
    
    --if no wand is in the centre then change to zero.
    if currentWand==false then 
        currentWandInTheCentre= 0
    end
    
    
    --choose button
    if CurrentWandNumber== currentWandInTheCentre then
        --if using it
        tint(0, 45, 255, 255)
    else
        tint(255, 255, 255, 255)
    end
    wandChooseButton:draw()
    
    tint(255, 255, 255, 255)
    
    --back button
    backButton:drawBackButton()
    
    
    if allowTouch==false then
        --draw popup
        popUp:draw()
        
        if popUp:done()==true then
            allowTouch=true
        end
    end
end

------------------------------------------------------------------------

function ShopScene:touched(touch)
    -- Codea does not automatically call this method
    
    popUp:touched(touch)
    backButton:touched(touch)
    
    --if not buying anything then
    if allowTouch==true then
        buyPotionButton:touched(touch)
        if buyPotionButton.selected== true then
            --play music
            sound("Game Sounds One:Reload 1")
            --see if can buy
            if MoneyHave>= potionCost then 
                --take away money
                MoneyHave= MoneyHave- potionCost
                saveLocalData("money", MoneyHave)
                --add a number of potion
                NumberOfPotions= NumberOfPotions +1
                saveLocalData("potionNumber", NumberOfPotions)
                sound("Game Sounds One:Assembly 4")
            end
        end
    
                
        wandChooseButton:touched(touch)
        if wandChooseButton.selected==true and currentWandInTheCentre~=0 then
            print(tostring(currentWandInTheCentre).."th wand selected")
            --reset wand
            if WandUnlocked[currentWandInTheCentre]==true then 
                --if unlocked then
                CurrentWandNumber= numberOfWands
                saveLocalData("wandNumber", CurrentWandNumber)
            else
                --not unlocked
                allowTouch= false
                print("Buy?")
                popUp= Buy(currentWandInTheCentre)     
            end
        end
        
    end
    
    
    --screen moving
    if zeroWidth+touch.deltaX<= wandSpace*0.65 and zeroWidth+touch.deltaX >= -1*(#Wands-1.5)*wandSpace then 
        --if in the righ domain, move screen left and right
        zeroWidth=zeroWidth+touch.deltaX
        --print(zeroWidth)
    end
    
    
end
