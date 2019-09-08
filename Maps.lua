-- Maps

--Created by: Heejo Suh
-- Created on: Dec 2016
-- Created for: ICS3U
-- This is the maps scene

------------------------------------------------------------------------

MapsScene = class()
------------------------------------------------------------------------


local buttons= {}
local backButton

------------------------------------------------------------------------

function MapsScene:init()
    -- you can accept and set parameters here
    
    local mapSpaceX= WIDTH/4
    local mapSpaceY= HEIGHT/6
    
    local mapMainPos= vec2(WIDTH/2, HEIGHT/2-mapSpaceY)
    
    local buttonPositionsBase= {                                                             vec2(mapMainPos.x-mapSpaceX, mapMainPos.y+2*mapSpaceY),                                             vec2(mapMainPos.x, mapMainPos.y+2*mapSpaceY),                                             vec2(mapMainPos.x+mapSpaceX, mapMainPos.y+2*mapSpaceY),              vec2(mapMainPos.x-mapSpaceX, mapMainPos.y+mapSpaceY),                                             vec2(mapMainPos.x, mapMainPos.y+mapSpaceY),                                             vec2(mapMainPos.x+mapSpaceX, mapMainPos.y+mapSpaceY),  vec2(mapMainPos.x-mapSpaceX, mapMainPos.y),                                             vec2(mapMainPos.x, mapMainPos.y),                                             vec2(mapMainPos.x+mapSpaceX,mapMainPos.y),                     vec2(mapMainPos.x-mapSpaceX, mapMainPos.y-mapSpaceY),                                             vec2(mapMainPos.x, mapMainPos.y-mapSpaceY), vec2(mapMainPos.x+mapSpaceX,mapMainPos.y-mapSpaceY),                                            vec2(mapMainPos.x-mapSpaceX, mapMainPos.y-2*mapSpaceY),                                             vec2(mapMainPos.x, mapMainPos.y-2*mapSpaceY), vec2(mapMainPos.x+mapSpaceX,mapMainPos.y-2*mapSpaceY)                       }
    --set each position a little different each time 
    for numberOfMapPositions= 1, #buttonPositionsBase do
        buttonPositionsBase[numberOfMapPositions]= vec2(buttonPositionsBase[numberOfMapPositions].x +math.random(0, 5)*10-50, buttonPositionsBase[numberOfMapPositions].y +math.random(0, 5)*10-50)
    end
    
    --for number of maps, set position
    buttonPosition={}
    for numberOfMaps= 1, #Maps do
        table.insert(buttonPosition, buttonPositionsBase[numberOfMaps])
    end
    
    for numberOfButtons= 1, #Maps do
        --put actual buttons into dictionary
        buttons[numberOfButtons]= Button("Project:brown dot", vec2(buttonPosition[numberOfButtons].x, buttonPosition[numberOfButtons].y))
    end
    
    
    backButton= BasicSprites()
end
------------------------------------------------------------------------


function MapsScene:draw()
    -- Codea does not automatically call this method
    sprite("Project:parchment old", WIDTH/2, HEIGHT/2, WIDTH, HEIGHT)--bg
    
    for numberOfButtons= 1,#buttons do
        --draw the buttons
        local lockSize= WIDTH/12
        tint(255, 255, 255, 180)
        buttons[numberOfButtons]:draw()
        if MapsUnlocked[numberOfButtons]==false then
            --if not unlocked then draw locks
            tint(255, 255, 255, 190)
            sprite("Project:Lock", buttonPosition[numberOfButtons].x, buttonPosition[numberOfButtons].y, lockSize, lockSize) --locks
        end
        font("Papyrus-Condensed")
        fontSize(WIDTH/23)
        fill(116, 65, 35, 255)
        text("Floor "..tostring(Maps[numberOfButtons]["floor"]), buttonPosition[numberOfButtons].x, buttonPosition[numberOfButtons].y-40)
        
        --draw connecting dots in between them
        tint(255, 255, 255, 170)
        local smallDotSize= WIDTH/50
        if numberOfButtons==2 or numberOfButtons==3 or numberOfButtons==5 or numberOfButtons==6 or numberOfButtons==8 or numberOfButtons==9 or numberOfButtons==11 or numberOfButtons==12 or numberOfButtons==14 or numberOfButtons==15 then
            --if not the first or the last one, nor the first rows then
            local sDotX= (buttonPosition[numberOfButtons].x + buttonPosition[numberOfButtons-1].x)/2
            local sDotY= (buttonPosition[numberOfButtons].y + buttonPosition[numberOfButtons].y)/2
            
            sprite("Project:brown dot", 0.95*sDotX, 0.998*sDotY, smallDotSize, smallDotSize)
            sprite("Project:brown dot", 1.05*sDotX, 1.002*sDotY, smallDotSize, smallDotSize)
        end
    end
    
    font("Papyrus")
    fontSize(WIDTH/12)
    fill(36, 24, 22, 255)
    text("Maps", WIDTH/2, HEIGHT/1.2)
    
    
    backButton:drawBackButton()
end
------------------------------------------------------------------------


function MapsScene:touched(touch)
    -- Codea does not automatically call this method
    backButton:touched(touch)
    
    for numberOfButtons= 1,#buttons do
        buttons[numberOfButtons]:touched(touch)
        
        if buttons[numberOfButtons].selected==true then
            -- if button touched then
            sound("A Hero's Quest:Arrow Shoot 2")
            --go to walk scene
            if MapsUnlocked[numberOfButtons]==true then
                --if unlocked then
                UserHealth= HealthLevelAmountGlobal
                saveLocalData("userHealth", UserHealth)
                CurrentGameFloor= Maps[numberOfButtons]["floor"]
                saveLocalData("gameFloor", CurrentGameFloor)
                NextWords= "Floor "..tostring(CurrentGameFloor)
                print(NextWords)
                Mode= "walk"
                MonsterDefeated= ""
                CurrentMonsters= Monsters()
                Scene.Change("walk")
            end
        end
    end
end
