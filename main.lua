function love.load()
    target = {}
    target.x = math.random(currentRadius, love.graphics.getWidth() - currentRadius)
    target.y = math.random(currentRadius, love.graphics.getHeight() - currentRadius)
    target.radius = 50

    score = 0
    coins = 0
    timer = 0
    temptime = 0
    timediff = 0

    gameFont = love.graphics.newFont(40)
end

function love.update(dt)
    timer = timer + dt
end

function love.draw()
    love.graphics.setColor(1,0,0)
    love.graphics.circle("fill", target.x, target.y, target.radius)

    love.graphics.setColor(1,1,1)
    love.graphics.setFont(gameFont)

    love.graphics.print("Score:", 0, 0)
    love.graphics.print(score, 130, 0)

    love.graphics.print("Coins:", 500, 0)
    love.graphics.print(coins, 625, 0)
end

function love.mousepressed( x, y, button, istouch, presses)
    if button == 1 then
        local mouseToTarget = distanceBetween( x, y, target.x, target.y)
        
        if mouseToTarget <= target.radius then
            scored()
            moveCircle()
        end
        
        if mouseToTarget > target.radius then
            fined()
        end
    end
end

function distanceBetween( x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

function scored()
    score = score + 1
    timediff = timer - temptime

    if timediff > 0 then
        if timediff > 1 then
            timediff = 1
        end

        if timediff < 0.1 then
            timediff = 0.1
        end
            
        coins = coins + 1 / timediff
    end

    temptime = timer
    reduceRadius()
end

function fined()
    temptime = temptime + 10
end

function reduceRadius()
    if target.radius > 20 then
        target.radius = target.radius - 1
    end
end

function moveCircle()
    local currentRadius = target.radius
    target.x = math.random(currentRadius, love.graphics.getWidth() - currentRadius)
    target.y = math.random(currentRadius, love.graphics.getHeight() - currentRadius)
end