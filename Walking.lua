-- Walking scene

--Created by: Heejo Suh
-- Created on: Dec 2016
-- Created for: ICS3U
-- This is the walking scene for game

------------------------------------------------------------------------

WalkingScene = class()

------------------------------------------------------------------------

local backgroundSprite

local beginTime
local endWalkTime

local moveHorrizontally
local moveVertically

local moveLeftOrRight
local moveUpOrDown

local scaleSize
local popUpY


local potionButton
local pauseButton

local basicSprites

local monsterDeafeatWords= ""
local coinWords= ""
local expWords= ""

local walkSoundTime= ElapsedTime
local walkSounds

local eachWalkTime= 20

------------------------------------------------------------------------


function WalkingScene:init()
    -- you can accept and set parameters here
    print("Walk scene")
    if NextWords== "Loading..." or MonsterDefeated=="" then
        --if resuming game then
        endWalkTime= 5 --beginning game, slightly longer
        coinWords=""
        expWords=""
    else
        if CurrentMonster["health"]<=0 then
            --if defeated monster then
            coinWords= "+"..tostring(math.tointeger(CurrentMonster["coins"])).." coins"
            expWords= "+"..tostring(math.tointeger(CurrentMonster["points"])).." points"
            
            CurrentMonsters:nextMonsterUp() -- next monster
            if CurrentMonsters==nil then
                --if a floor cleared then
                print("Floor cleared")
                CurrentMonsters= Monsters() --sprite new patch
                endWalkTime= 4 --new floor
                  CurrentGameFloor= CurrentGameFloor+1 --new floor
                NextWords= "Underground floor number "..tostring(math.tointeger(CurrentGameFloor))
                sound("A Hero's Quest:Door Open")--new floor sound
                for numberOfMaps= 1,#Maps do
                     --floor unlocked
                     if CurrentGameFloor==Maps[numberOfMaps]["floor"] then
                        Maps[numberOfMaps]["unlocked"]= true
                            saveLocalData("mapsUnlocked"..tostring(numberOfMaps), true)
                    end
                end
            
            else --finding new monster
                endWalkTime= math.random(10, 35)/10--time it takes to walk
            end
        end
    end

    
    monsterDeafeatWords= tostring(MonsterDefeated).." defeated!"
    
    moveHorrizontally= 0
    moveVertically= 0
    moveLeftOrRight= "left"
    moveLeftOrRight= "down"
    
    scaleSize= vec2(WIDTH*1.1, HEIGHT*1.1)
    popUpY= 0
    
    
    potionButton= Potion()
    basicSprites= BasicSprites()
    
    pauseButton= Button("Project:pause button", vec2(WIDTH-WIDTH/8, HEIGHT-WIDTH/9))
    
    
    beginTime= ElapsedTime
    eachWalkTime=0.5
    
    walkSounds= {"A Hero's Quest:Walk", "A Hero's Quest:Walk 2 (Short)"}
end


------------------------------------------------------------------------


function WalkingScene:draw()
    -- Codea does not automatically call this method
    background(0, 0, 0, 255)
    
    --move left or right
    if moveHorrizontally < -WIDTH/22 then
        moveLeftOrRight= "right"
    elseif moveHorrizontally > WIDTH/22 then
        moveLeftOrRight= "left"
    end
    
    if moveLeftOrRight== "right" then
        moveHorrizontally= moveHorrizontally + 2
    else
        moveHorrizontally= moveHorrizontally - 2
    end
    
    
    --move up or down
    if moveVertically < -HEIGHT/37 then
        moveUpOrDown= "up"
    elseif moveVertically > HEIGHT/60 then
        moveUpOrDown= "down"
    end
    
    if moveUpOrDown== "up" then
        moveVertically= moveVertically + 3
    else
        moveVertically= moveVertically - 3
    end
    
    scaleSize.x= scaleSize.x + 1
    scaleSize.y= scaleSize.y + 1
    
    sprite("Project:bg", WIDTH/2+ moveHorrizontally, HEIGHT/2+ moveVertically, scaleSize.x, scaleSize.y) --draw background
    
    
    
      --draw wand
    basicSprites:drawWand()
    
    --user gage bar
    basicSprites:drawUserGage()

    --draw potion button
    potionButton:draw()
    
    
    --pop up
    --create sprite
    sprite("Project:parchment old", WIDTH/2, popUpY, WIDTH/1.5, WIDTH/2.5) --draw popup
    
    --draw text
    textMode (CENTER)
    font("Papyrus")
    pushStyle ()

    if NextWords~= "" then
        --if new floor then
        fontSize (WIDTH/26)
        fill(42, 28, 24, 255)
        text(NextWords, WIDTH/2, popUpY+WIDTH/15)
    end
    
    if MonsterDefeated~="" then
        --enemy defeated
        fontSize (WIDTH/23)
        fill(0, 0, 0, 255)
        text(monsterDeafeatWords, WIDTH/2, popUpY)
    end
    
    fontSize (WIDTH/27)
    fill(0, 0, 0, 240)
    text(coinWords, WIDTH/2, popUpY-WIDTH/19)
    text(expWords, WIDTH/2, popUpY-WIDTH/10)
    
    
    --move popup up
    popUpY= popUpY+ (HEIGHT-popUpY)/60
       
    
    --change scene
    
    if (beginTime + endWalkTime) < ElapsedTime then
        --turn mode back to game
        Mode="game"
        MonsterDefeated= "" --reset to nothing
        NextWords= ""
        Scene.Change("game")
    end
    
    pauseButton:draw()
    
    
    if walkSoundTime+eachWalkTime<ElapsedTime then
        local randomNumber= math.random(1, #walkSounds)
        sound(walkSounds[randomNumber], 0.6) --play a walking sound
        walkSoundTime= ElapsedTime
    end
end

------------------------------------------------------------------------

function WalkingScene:touched(touch)
    -- Codea does not automatically call this method
    potionButton:touched(touch)
    --pause button
    pauseButton:touched(touch)
    if pauseButton.selected== true then
        Scene.Change("pause")
    end
end
