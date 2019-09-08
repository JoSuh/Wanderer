-- Monsters

--Created by: Heejo Suh
-- Created on: Dec 2016
-- Created for: ICS3U
-- This is the class for making monsters

------------------------------------------------------------------------

Monsters = class()

------------------------------------------------------------------------


--                                                                                                            monstersDict[hejdhdhd]= {['monster name']='NameOfMonster', ['sprite']= spriteImage, ['health']= healthOfMonster(average=80), ['points']= pointOfMonster(average=10), ['speed']= timeItTakesToAttack(average=1.5), ['coins']= numberOfCoins(average=14), ['strength']= attackPower,(average=36), ['floor']= atLeastThisFlooraToSee, ['attack sound']= soundWhenAttacking, ['hurt sound']= soundWhenAttacked}  
monstersDict= {}
monstersDict[1]= {['monster name']='Fluffy', ['sprite']= "Project:Monster bushy", ['health']= 20, ['points']= 8, ['speed']= 1.8, ['coins']= 10, ["strength"]= 30, ['floor']= 1, ['attack sound']= "A Hero's Quest:Monster Die 2", ['hurt sound']= "A Hero's Quest:Monster Die 1"} 
monstersDict[2]= {['monster name']='Dustball', ['sprite']= "Project:monster dust", ['health']= 70, ['points']= 10, ['speed']= 1.4, ['coins']= 5, ['strength']= 8, ['floor']= 1, ['attack sound']= "A Hero's Quest:Monster Hit 2", ['hurt sound']= "A Hero's Quest:Bottle Break 1"}
monstersDict[3]= {['monster name']='Mysterious egg', ['sprite']= "Project:monster egg", ['health']= 90, ['points']= 5, ['speed']= 1.2, ['coins']= 50, ['strength']= 15, ['floor']= 2, ['attack sound']= "A Hero's Quest:Dig 1", ['hurt sound']= "A Hero's Quest:Bottle Break 1"}
monstersDict[4]= {['monster name']='Nightmare', ['sprite']= "Project:Monster 4", ['health']= 100, ['points']= 8, ['speed']= 1.1, ['coins']= 20, ['strength']= 5, ['floor']= 2, ['attack sound']= "A Hero's Quest:Dig 1", ['hurt sound']= "A Hero's Quest:Bottle Break 1"}
monstersDict[5]= {['monster name']='Chirpy', ['sprite']= "Project:Monster 7", ['health']= 80, ['points']= 20, ['speed']= 2.1, ['coins']= 10, ['strength']= 20, ['floor']= 3, ['attack sound']= "A Hero's Quest:Dig 1", ['hurt sound']= "A Hero's Quest:Bottle Break 1"}
monstersDict[6]= {['monster name']='Ghoastasgast', ['sprite']= "Project:Monster 5", ['health']= 30, ['points']= 4, ['speed']= 1.2, ['coins']= 20, ['strength']= 40, ['floor']= 3, ['attack sound']= "A Hero's Quest:FireBall Blast 2", ['hurt sound']= "A Hero's Quest:FireBall Blast 1"}
monstersDict[7]= {['monster name']='Dongy', ['sprite']= "Project:Monster 6", ['health']= 10000, ['points']= 10000000 ,['speed']= 1.2, ['coins']= 10000, ['strength']= 100, ['floor']= 100, ['attack sound']= "A Hero's Quest:Dig 1", ['hurt sound']= "A Hero's Quest:Dig 2"}

monstersDict[8]= {['monster name']='A Random Explorer', ['sprite']= "Project:Guy", ['health']= 100, ['points']= 30 ,['speed']= 1.2, ['coins']= 40, ['strength']= 40, ['floor']= 5, ['attack sound']= "A Hero's Quest:Hurt 1", ['hurt sound']= "A Hero's Quest:Hurt 4"}


-- sprite()
--    sound("A Hero's Quest:Hurt 1")

local __monstersList= {}
local __currentMonsterGageBar

------------------------------------------------------------------------


function Monsters:init()
    -- you can accept and set parameters here
    createNewBatchOfMonsters()
    setNextMonster()
end

------------------------------------------------------------------------

function Monsters:draw()
    -- Codea does not automatically call this method
    --draw monster
    if Attacked== false then
        --normal size
        sprite(monstersDict[__monstersList[1]]["sprite"], WIDTH/2, HEIGHT/1.6, WIDTH/1.3, WIDTH/1.3)
    else
        sprite(monstersDict[__monstersList[1]]["sprite"], WIDTH/2, HEIGHT/1.8, WIDTH, WIDTH)
    end
    
    
    __currentMonsterGageBar= GageBar(CurrentMonster["health"], currentMonsterOrgHealth, vec2(WIDTH/23, HEIGHT- HEIGHT/25), color(0, 195, 255, 255), WIDTH/1.1) --gage bar for monster
    --draw gage bar
    __currentMonsterGageBar:draw()
end

------------------------------------------------------------------------


function Monsters:touched(touch)
    -- Codea does not automatically call this method
end

------------------------------------------------------------------------

function createNewBatchOfMonsters()
    --Create a new batch of monsters
    
    __monstersList= {} --clear up array
    
    --how many monsters in a floor
    local numberOfMonsters= math.random(3,5)
    
    local randomNumber
    
    for monsters= 1, numberOfMonsters do
        repeat
        randomNumber= math.random(1, #monstersDict)--random number
        until monstersDict[randomNumber]["floor"]<= CurrentGameFloor
        --if monsters are available at that floor then
        table.insert(__monstersList, randomNumber)--put number into array
    end
end

------------------------------------------------------------------------

function Monsters:returnMonsterNames()
    -- return the names of the monsters, just for checking
    local namesStrings= ""
    for numberOfMonsters= 1, #__monstersList do
        local currentMonsterName= monstersDict[__monstersList[numberOfMonsters]]["monster name"]
        namesStrings= namesStrings..currentMonsterName..", " --add monster name to string
    end
    return namesStrings
end


------------------------------------------------------------------------

function Monsters:checkIfAttacked(startTime)
    --get the time limit of current monster 
    local timeLimit= CurrentMonster["speed"]
    if (ElapsedTime-startTime > timeLimit) then
        --if time over then
        Attacked= true
        Scene.Change("attack")
    end
end

------------------------------------------------------------------------

--Got from Tylerneylon in Github by Heejo Suh
--Got from <https://gist.github.com/tylerneylon/81333721109155b2d244>
--Got on January 12, 2017

--Modified by Heejo Suh

--Deep-copies table
function clone(tableToCopy)
    
    if type(tableToCopy) ~= 'table' then 
        return tableToCopy 
    end
    
    local tableToReturn = {} --set new table
    
    
    for k, v in pairs(tableToCopy) do --set each one to the other one
        tableToReturn[clone(k)] = clone(v)
    end
    return tableToReturn --return new table
end

------------------------------------------------------------------------

function setNextMonster()
    --reset monster and gagebar
    CurrentMonsterNumber= __monstersList[1]
    saveLocalData("monsterNumber", CurrentMonsterNumber)
    
    CurrentMonster= clone(monstersDict[__monstersList[1]]) --set current monster

    --differs for every monster
    --40%~150% difference
    local percent= math.random(5, 12*CurrentGameFloor)/10

    
    CurrentMonster["health"]= tonumber(string.format("%.f", (CurrentMonster["health"]) * percent))
    
    CurrentMonster["coins"]= tonumber(string.format("%.f", (CurrentMonster["coins"]) * percent))
    
    CurrentMonster["points"]= tonumber(string.format("%.f", (CurrentMonster["points"]) * percent))
    
    CurrentMonster["strength"]= tonumber(string.format("%.f", (CurrentMonster["strength"]) * percent))

    print("\n\n\n\n\n")

    currentMonsterOrgHealth= CurrentMonster["health"] --save original health    
end

------------------------------------------------------------------------

function Monsters:nextMonsterUp()
    --see if can get next monster
    
    --add coins, exp points and such
    print("Coins earned: "..tostring(CurrentMonster["coins"]))
    print("Exp earned: "..tostring(CurrentMonster["points"]))
    
    MoneyHave= MoneyHave + CurrentMonster["coins"]
    saveLocalData("money", MoneyHave)
    ExpPoints= ExpPoints + CurrentMonster["points"]
    saveLocalData("expPoints", ExpPoints)
    
    
    local expEachLevelTimesAmount= 50
    local expLevelAmount= expEachLevelTimesAmount/Level
    local healthTimesAmount= 1.05
    
    --check if there needs to be a new level
    if ExpPoints>= ExpNeedAmount and GotCoinsAndExp==false then
        repeat
            ExpPoints= ExpPoints- ExpNeedAmount --take away exp points
            Level= Level+1 -- level up
            ExpNeedAmount= ExpNeedAmount + expLevelAmount --increase in needed exp
            HealthLevelAmount= HealthLevelAmount*1.1 --more health
            UserHealth= HealthLevelAmount --more health
            
        until ExpPoints<ExpNeedAmount
        saveLocalData("expPoints", ExpPoints)
        saveLocalData("expNeedAmount", expLevelAmount)
        saveLocalData("level", Level)
        saveLocalData("healthLevel", HealthLevelAmount)
        saveLocalData("userHealth", UserHealth)
        sound("A Hero's Quest:Level Up")
    end
    
    
    --then delete the current monster
    if #__monstersList==1 then
        --if only one left then
        print("No more Monsters on this floor")
        CurrentMonsters= nil
        
    else
        for numberOfMonsters= 1, #__monstersList do
            --move down each monster one up
            if numberOfMonsters== #__monstersList then
                --get rid of the last one
                table.remove(__monstersList, #__monstersList)
                setNextMonster() --set current monster
            else
                __monstersList[numberOfMonsters]= __monstersList[numberOfMonsters+1] --set to next one
            end
        end
        
        print(Monsters:returnMonsterNames())
    end
end
