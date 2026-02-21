Globals = {}
Globals.Graphics = require("src.utils.graphics")
Globals.Animation = require("src.utils.animation")
Globals.Bullets = {}
Globals.Rockets = {}
Globals.Score = 0
Globals.scoreTimer = 0
Globals.rocketSpawnTimer = nil
Globals.playerHealth = 3
Globals.maxPlayerHealth = 3

GameState = {
    current = nil,
    state_paths = {
        menu = "src.states.menu",
        play = "src.states.play",
        gameOver = "src.states.gameover"
    },
    loaded_states = {}
}


function GameState:changeState(newState)
  if GameState.current and GameState.current.onExit then
    GameState.current.onExit()
  end
  
  if not GameState.loaded_states[newState] then
    local path = GameState.state_paths[newState]
    GameState.loaded_states[newState] = require(path)
  end
  
  GameState.current = GameState.loaded_states[newState]
  
  if GameState.current and GameState.current.onEnter then
    GameState.current.onEnter()
  end
end


function love.load()
  Globals.Screen = {
      x = 0,
      y = 0,
      width = love.graphics.getWidth(),
      height = love.graphics.getHeight()
  }
  
  Globals.Graphics:loadFonts()
  Globals.Graphics:loadSprites()
  
  GameState:changeState("menu")
end


function love.update(dt)
  dt = math.min(dt, 0.07)
  
  if GameState.current and GameState.current.update then
    GameState.current.update(dt)
  end
end


function love.mousepressed(x, y, button)
  if GameState.current and GameState.current.mousepressed then
    GameState.current.mousepressed(x, y, button)
  end
end


function love.mousereleased(x, y, button)
  if GameState.current and GameState.current.mousereleased then
	GameState.current.mousereleased(x, y, button)
  end
end


function love.draw()
  if GameState.current and GameState.current.draw then
    GameState.current.draw()
  end
end
