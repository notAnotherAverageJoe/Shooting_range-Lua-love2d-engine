--one of three functions needed to make this work
-- windowsize and globals
--major variables ere
function love.load()
    love.window.setTitle("Shooting Range")
    love.mouse.setVisible(false)


    target = {}
    target.x = 300
    target.y = 300
    target.radius = 50

    score = 0
    timer = 0
    gameState = 1

    gameFont = love.graphics.newFont(40)

    sprites = {}
    sprites.sky = love.graphics.newImage('sprites/sky.png')
    sprites.target = love.graphics.newImage('sprites/target.png')
    sprites.crosshairs = love.graphics.newImage('sprites/crosshairs.png')
end

--dt means delta time, second function needed to make a game work.
--the game loop, for every frame, love games run at 60 fps
--altered here
function love.update(dt)
    if timer > 0 then
        timer = timer - dt
    end
    --breaking it up removes the odd blip that shows a negative number for a second
    if timer < 0 then
        timer = 0
        gameState = 1;
    end
end

--final function needed, this is all the graphics and runs at every frame
--only graphics and images
--drawn here
function love.draw()
    love.graphics.draw(sprites.sky, 0, 0)


    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gameFont)
    love.graphics.print("Score: " .. score, 5, 5)
    --normal stuff here ceil rounds up the decimals and shows the int
    love.graphics.print("Time: " .. math.ceil(timer), 300, 5)

    if gameState == 1 then
        love.graphics.printf("Click anywhere to begin!", 0, 250, love.graphics.getWidth(), "center")
    end


    if gameState == 2 then
        love.graphics.draw(sprites.target, target.x - target.radius, target.y - target.radius)
    end
    love.graphics.draw(sprites.crosshairs, love.mouse.getX() - 20, love.mouse.getY() - 20)
end

-- the x an y are part of mousepressed it would be x1 y1
function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 and gameState == 2 then --                   mouse area  -- circle x y
        local mouseToTarget = distanceBetween(x, y, target.x, target.y)
        if mouseToTarget < target.radius then
            score = score + 1 -- this was 0,100 for reference
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
        end
    elseif button == 1 and gameState == 1 then
        gameState = 2
        timer = 10
        score = 0
    end
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end
