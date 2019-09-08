-- Main

--Created by: Heejo Suh
-- Created on: Dec 2016
-- Created for: ICS3U
-- This is main program for the CPT game

--RESET DATA Hehehehehe
--              clearLocalData()
------------------------------------------------------------------------

--Set global variables

--Default level one, 100 coins to start with
LevelGlobal= readLocalData("level", 1)
Level= LevelGlobal


MoneyHaveGlobal= readLocalData("money", 100)
MoneyHave= MoneyHaveGlobal



--    Wands[hdhdjd]= {["wand name"]=wandName, ["sprite"]=wandSpriteImage, ["cost"]=cost, ["level"]= LevelToUse, ["power"]= powerOfWand, ["x"]= widthOfWand}
Wands= {}

Wands[1]= {["wand name"]="Beginner's wand", ["sprite"]="Space Art:Green Bullet", ["cost"]=0, ["level"]= 1, ["power"]= 1, ["x"]= 80}

Wands[2]= {["wand name"]="Intermediate's wand", ["sprite"]="Space Art:Beam", ["cost"]=200, ["level"]= 1, ["power"]= 2, ["x"]= 50}

Wands[3]= {["wand name"]="Advanced wand", ["sprite"]="Project:Wand 3", ["cost"]=500, ["level"]= 3, ["power"]= 3, ["x"]= WIDTH/3}

Wands[4]= {["wand name"]="Expert's wand", ["sprite"]="Project:Wand 2", ["cost"]=700, ["level"]= 5, ["power"]= 4, ["x"]= WIDTH/3}

Wands[5]= {["wand name"]="Old Pine wand", ["sprite"]="Project:Wand 4", ["cost"]=1500, ["level"]= 8, ["power"]= 5, ["x"]= WIDTH/3}

Wands[6]= {["wand name"]="Maple wand", ["sprite"]="Project:Wand 1", ["cost"]=2000, ["level"]= 10, ["power"]= 7, ["x"]= WIDTH/3}


CurrentWandNumberGlobal= readLocalData("wandNumber", 1)
CurrentWandNumber= CurrentWandNumberGlobal

WandUnlockedGlobal={}
table.insert(WandUnlockedGlobal, 1, readLocalData("wandUnlocked1", true))
for numberOfWands= 2, #Wands do
    --Wands unlocked or not
    table.insert(WandUnlockedGlobal,numberOfWands, readLocalData("wandUnlocked"..tostring(numberOfWands), false))
end
WandUnlocked= WandUnlockedGlobal




Mode= "game"
CurrentGameFloorGlobal= readLocalData("gameFloor", 0)
CurrentGameFloor= CurrentGameFloorGlobal


CurrentMonsterGlobal= readLocalData("currentMonster", {})
CurrentMonster= CurrentMonsterGlobal
CurrentMonsters= {}


SpellCastedNumber= 0
Attacked= false
NextWords= "o" --set to nothing



UserHealthGlobal= readLocalData("userHealth", 100)
UserHealth= UserHealthGlobal
HealthLevelAmountGlobal= readLocalData("healthLevel", 100)
HealthLevelAmount= HealthLevelAmountGlobal


ExpPointsGlobal= readLocalData("expPoints", 0)
ExpPoints= ExpPointsGlobal

ExpNeedAmountGlobal= readLocalData("expNeedAmount", 50)
ExpNeedAmount= ExpNeedAmountGlobal


--Used for going back to different scenes
GoBackTo= ""

--checks if given exp and everything
GotCoinsAndExpGlobal= readLocalData("gotThings", true)
GotCoinsAndExp= GotCoinsAndExpGlobal




Maps= {                                                                                                      {["floor"]= 1},                                                                                                                                                                                                                                                              {["floor"]= 5},                                                                                                                                                                                                                     {["floor"]= 10},                                                                                                                                                                                                                      {["floor"]= 20},                                                                                                                                                                                                                                                        {["floor"]= 30},                                                                                                                                                                                                                      {["floor"]= 40},                                                                                                                                                                                                                      {["floor"]= 50},                                                                                                                                                                                                                      {["floor"]= 60},                                                                                                                                                                                                                      {["floor"]= 70},                                                                                                                                                                                                                      {["floor"]= 80},                                                                                                                                                                                                                      {["floor"]= 90},                                                                                                                                                                                                                      {["floor"]= 100},                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      }

MapsUnlockedGlobal={}
table.insert(MapsUnlockedGlobal, 1, readLocalData("mapsUnlocked1", true))
for numberOfMaps= 2, #Maps do
    --Wands unlocked or not
    table.insert(MapsUnlockedGlobal,numberOfMaps, readLocalData("mapsUnlocked"..tostring(numberOfMaps), false))
end
MapsUnlocked= MapsUnlockedGlobal



--                                                                 Spells[hdjdjdj]={["spell name"]= "spellName", ["power"]=spellAttackPoints(average=15), ["type"]= "GrowTurn", ["spell"]= "spellNumbers", ["sprite"]= spellSpriteImage, ["level"]=3, ["description"]= "Spell strength: Medium   Difficulty: Medium"}

Spells= {}

Spells[1]= {["spell name"]= "Dividi Bavidiboo", ["power"]= 18, ["type"]= "grow", ["spell"]= "123", ["sprite"]= "Project:spell 1", ["level"]=1, ["description"]= "Spell strength: Low   Difficulty: Low"}

Spells[2]= {["spell name"]= "Abracadabra", ["power"]= 10, ["type"]= "grow", ["spell"]= "456", ["sprite"]= "Project:spells 3", ["level"]=1, ["description"]= "Spell strength: Low   Difficulty: Low"} 

Spells[3]= {["spell name"]= "Ispears", ["power"]= 15, ["type"]= "turn", ["spell"]= "4569", ["sprite"]= "Project:spells 2", ["level"]=1, ["description"]= "Spell strength: Low   Difficulty: Low"} 

Spells[4]= {["spell name"]= "Sccarre", ["power"]= 20, ["type"]= "turn", ["spell"]= "3214789", ["sprite"]= "Project:spell sprite-01", ["level"]=2, ["description"]= "Spell strength: Low   Difficulty: Low"} 

Spells[5]= {["spell name"]= "Thunder lash", ["power"]= 20, ["type"]= "turn", ["spell"]= "258789", ["sprite"]= "Project:spell sprite-07", ["level"]=2, ["description"]= "Spell strength: Low   Difficulty: Low Medium"} 

Spells[6]= {["spell name"]= "Starstruck", ["power"]= 25, ["type"]= "turn", ["spell"]= "2457", ["sprite"]= "Project:spell sprite-03", ["level"]=3, ["description"]= "Spell strength: Low Medium   Difficulty: Low"} 

Spells[7]= {["spell name"]= "Fire blast", ["power"]= 22, ["type"]= "grow", ["spell"]= "321478963", ["sprite"]= "Project:spell sprite-16", ["level"]=3, ["description"]= "Spell strength: Low Medium   Difficulty: Low Medium"}

Spells[8]= {["spell name"]= "Locker", ["power"]= 30, ["type"]= "grow", ["spell"]= "456369", ["sprite"]= "Project:spell sprite-06", ["level"]=4, ["description"]= "Spell strength: Low Medium   Difficulty: Low"}


Spells[9]= {["spell name"]= "Hallucinate", ["power"]= 28, ["type"]= "grow", ["spell"]= "326598", ["sprite"]= "Project:spell sprite-04", ["level"]=4, ["description"]= "Spell strength: Low Medium   Difficulty: Low"}

Spells[10]= {["spell name"]= "Cloud kill", ["power"]=35, ["type"]= "grow", ["spell"]= "9317", ["sprite"]= "Project:spell sprite-17", ["level"]=4, ["description"]= "Spell strength: Medium   Difficulty: Low Medium"}

Spells[11]= {["spell name"]= "Unlock", ["power"]=30, ["type"]= "grow", ["spell"]= "2547896", ["sprite"]= "Project:spell sprite-05", ["level"]=5, ["description"]= "Spell strength: Low Medium   Difficulty: Medium"}

Spells[12]= {["spell name"]= "Ignite", ["power"]=36, ["type"]= "turn", ["spell"]= "453", ["sprite"]= "Project:spell sprite-18", ["level"]=6, ["description"]= "Spell strength: Medium   Difficulty: Low"}

Spells[13]= {["spell name"]= "Poison", ["power"]=38, ["type"]= "turn", ["spell"]= "759", ["sprite"]= "Project:spell sprite-18", ["level"]=7, ["description"]= "Spell strength: Medium   Difficulty: Low"}

Spells[14]= {["spell name"]= "Wall of fire", ["power"]=40, ["type"]= "turn", ["spell"]= "987654321", ["sprite"]= "Project:spell sprite-02", ["level"]=8, ["description"]= "Spell strength: Medium   Difficulty: Medium"}

Spells[15]= {["spell name"]= "Death star", ["power"]= 1000, ["type"]= "grow", ["spell"]= "2576352", ["sprite"]= "Project:spell sprite-15", ["level"]=100, ["description"]= "Spell strength: Extreme   Difficulty: Medium"}

MonsterDefeated= ""


NumberOfPotionsGlobal= readLocalData("potionNumber", 3)
NumberOfPotions= NumberOfPotionsGlobal

MusicMutedGlobal= readLocalData("musicMuted", false)
MusicMuted= MusicMutedGlobal




--for tutorials
FirstGamePlay= readLocalData("tutorials", true)

------------------------------------------------------------------------

function setup()
    supportedOrientations(PORTRAIT)
    displayMode(FULLSCREEN_NO_BUTTONS)
    --displayMode(FULLSCREEN)
    noFill()
    noSmooth()
    noStroke()
    pushStyle()
    
    
    if MusicMuted==false then
        music("Project:GameBgm", true, 1)
    else
        music.paused= true
    end
    
    --define scenes
    Scene("splash", SplashScene)
    Scene("mainMenu", MainMenuScene)
    Scene("spells", SpellsScene)
    Scene("shop", ShopScene)
    Scene("settings", SettingsScene)
    Scene("maps", MapsScene)
    Scene("game", GameScene)
    Scene("walk", WalkingScene)
    Scene("attack", AttackScene)
    Scene("pause", PausedScene)
    Scene("dead", DeadScene)
    Scene("help", HelpScene)
    
    
    --go to splash scene first
    --Scene.Change("splash")
    Scene.Change("splash")
end
 
------------------------------------------------------------------------

function draw()
    background(0, 0, 0, 255) 
    Scene:Draw()
end

------------------------------------------------------------------------

--Touched needed in the main.
function touched(touch)
    Scene.Touched(touch)
end
