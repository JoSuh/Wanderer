-- Main Menu

--Created by: Heejo Suh
-- Created on: Dec 2016
-- Created for: ICS3U
-- This is the main menu scene.

------------------------------------------------------------------------


MainMenuScene = class()


------------------------------------------------------------------------


local buttons

local centerButtonSize= vec2(WIDTH/2.5, HEIGHT/8)

------------------------------------------------------------------------


function MainMenuScene:init()
    -- you can accept and set parameters here 
    print("Main menu")
    
    GoBackTo= "" --reset to nothing
    
    local middleButtonSpace= HEIGHT/7
    local middleButtonOriginalY= HEIGHT/1.9
    
    buttons= {                                                                                 {["sprite"]= "Project:button maps", ["position"]= vec2(WIDTH/2, middleButtonOriginalY), ["scene"]="maps"},                                                                                  {["sprite"]= "Project:button resume", ["position"]= vec2(WIDTH/2, middleButtonOriginalY - 1*middleButtonSpace), ["scene"]="game", ["mode"]= "resume"},                                           {["sprite"]= "Project:button practice", ["position"]= vec2(WIDTH/2, middleButtonOriginalY - 2*middleButtonSpace), ["scene"]="game", ["mode"]= "practice"},                                                                                 {["sprite"]= "Project:button spells", ["position"]= vec2(WIDTH/2, middleButtonOriginalY - 3*middleButtonSpace), ["scene"]="spells"},                                                                                 {["sprite"]= "Project:button settings", ["position"]= vec2(WIDTH/8, HEIGHT/1.1), ["scene"]="settings"},                                                                                                                                                                 {["sprite"]= "Project:button shop", ["position"]= vec2(WIDTH-WIDTH/8, HEIGHT/1.1), ["scene"]="shop"},                                                                                 }
    
    
    for numberOfButtons= 1, #buttons do
        --put actual buttons into dictionary
        local buttonImage= buttons[numberOfButtons]["sprite"]
        local buttonPosition= buttons[numberOfButtons]["position"]
        buttons[numberOfButtons]["button"]= Button(buttonImage, vec2(buttonPosition.x, buttonPosition.y))
    end
end

------------------------------------------------------------------------

function MainMenuScene:draw()
    -- Codea does not automatically call this method
    sprite("Project:bg1", WIDTH/2, HEIGHT/2, WIDTH, HEIGHT)--bg
    tint(72, 38, 30, 180)
    sprite("Project:bg1", WIDTH/2, HEIGHT/2, WIDTH, HEIGHT)--bg
    tint(255, 255, 255, 255)
    
    for numberOfButtons= 1,#buttons do
        --draw the buttons
        buttons[numberOfButtons]["button"]:draw()
    end
    
    sprite("Project:name", WIDTH/2, HEIGHT/1.25, WIDTH/2., WIDTH/2.) -- game name sprite
    
    --level
    fontSize (WIDTH/25)
    font("Papyrus")
    textMode (CENTER)
    pushStyle ()
    fill(227, 227, 227, 255)
    text("Level "..tostring(math.tointeger(Level)), WIDTH/2, HEIGHT/1.6)
    fill(10, 10, 10, 255)
end

------------------------------------------------------------------------

function MainMenuScene:touched(touch)
    -- Codea does not automatically call this method
    
    for numberOfButtons= 1,#buttons do
        local currentButtonDict= buttons[numberOfButtons]
        currentButtonDict["button"]:touched(touch)
        if currentButtonDict["button"].selected==true then
            -- if button touched then
            sound("Game Sounds One:Jump")
            
            if currentButtonDict["mode"]=="practice" then
                --practice
                Mode= "practice"
                SpriteEnemies= false
                print("Practice")
            else
                --game
                Mode= "game"
                SpriteEnemies= true
            end
            
            if currentButtonDict["mode"]=="resume" then
                --resume game
                if CurrentGameFloor==0 then
                    --if no data then do nothing
                else
                    NextWords= "Loading..."
                    -- create new monsters
                    CurrentMonsters= Monsters()
                    Scene.Change("walk")
                end
            else 
                print("Go to "..currentButtonDict["scene"])
                Scene.Change(currentButtonDict["scene"])
            end
        end
    end
    
end

