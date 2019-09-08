-- Settings

--Created by: Heejo Suh
-- Created on: Dec 2016
-- Created for: ICS3U
-- This is the settings scene

------------------------------------------------------------------------


SettingsScene = class()
------------------------------------------------------------------------

local backButton

local musicOnButton
local onOffWords

local helpButton

local currentLevel
local currentExpPoints
local expGage


------------------------------------------------------------------------

function SettingsScene:init()
    -- you can accept and set parameters here
    backButton= BasicSprites()
    
    musicOnButton= Button("Project:onoff button", vec2(4*WIDTH/7, HEIGHT/1.7))
    if MusicMuted==false then
        onOffWords= "On"
    else
        onOffWords= "Off"
    end
    
    
    helpButton= Button("Project:brown dot", vec2(WIDTH/2, 3*HEIGHT/7))
    
    expGage= GageBar(ExpPoints, ExpNeedAmount, vec2(WIDTH/4, HEIGHT/1.5), color(255, 184, 0, 255), WIDTH/2)   
    
end

------------------------------------------------------------------------

function SettingsScene:draw()
    -- Codea does not automatically call this method
    sprite("Project:bg1", WIDTH/2, HEIGHT/2, WIDTH, HEIGHT)--bg
    tint(48, 48, 48, 100)
    sprite("Project:bg1", WIDTH/2, HEIGHT/2, WIDTH, HEIGHT)
    tint(255, 255, 255, 255)
    
    backButton:drawBackButton()
    
    --music
    musicOnButton:draw()
    textWrapWidth(WIDTH/1.4)
    fontSize(WIDTH/20)
    fill(11, 9, 9, 90)
    font("Noteworthy-Bold")
    text(onOffWords, 4*WIDTH/7, HEIGHT/1.69)
    font("Papyrus-Condensed")
    fill(0, 0, 0, 255)
    text("Music:", 2.7*WIDTH/7, HEIGHT/1.75)
    
    --level
    fill(255, 255, 255, 230)
    font("Papyrus-Condensed")
    textWrapWidth(WIDTH/1.4)
    fontSize(WIDTH/10)
    text("Lv."..tostring(math.tointeger(Level)), WIDTH/2, HEIGHT/1.15)
    fontSize(WIDTH/20)
    text("Exp:  "..tostring(math.tointeger(ExpPoints)).." / "..tostring(math.tointeger(ExpNeedAmount)), WIDTH/2, HEIGHT/1.25)
    
    --exp points
    expGage:draw()
    
    --credits
    matrix()
    fill(255, 255, 255, 170)
    font("AmericanTypewriter")
    textWrapWidth(WIDTH/1.1)
    fontSize(WIDTH/27)
    textMode(CENTER)
    text("CREDITS:\n\nDesigned by: Heejo Suh\nProgrammed by: Heejo Suh\nMusic by: Yun\nMain Artwork by: Heejo Suh", WIDTH/2, HEIGHT/4.5)
    popMatrix()
    
    
    --tutorials
    helpButton:draw()
    fill(255, 255, 255, 255)
    font("Papyrus")
    fontSize(WIDTH/9)
    text("i", WIDTH/2, 3*HEIGHT/7)
end

------------------------------------------------------------------------

function SettingsScene:touched(touch)
    -- Codea does not automatically call this method
    backButton:touched(touch)
    
    musicOnButton:touched(touch)
    if musicOnButton.selected== true then
        if onOffWords== "On" then
            onOffWords= "Off"
            MusicMuted= true
        else
            onOffWords= "On"
            MusicMuted= false
            music("Project:GameBgm", true, 1)
        end
        music.paused= MusicMuted
        saveLocalData("musicMuted", MusicMuted)
    end
    
    helpButton:touched(touch)
    if helpButton.selected== true then
        Scene.Change("help")
    end
end
