require "vector"
require "mover"
require "liquid"

function love.load()
    love.window.setTitle("Acceleration")
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    love.graphics.setBackgroundColor(150 / 255, 150 / 255, 150 / 255)
    movers = {
        Mover:create(Vector:create(100, height/4), Vector:create(0, 0), 50, 20),
        Mover:create(Vector:create(300, height/4), Vector:create(0, 0), 70, 20),
        Mover:create(Vector:create(500, height/4), Vector:create(0, 0), 90, 20)
    }
    water = Liquid:create(0, height-300, width, 300, 0.0025)
    gravity = Vector:create(0, 0.01)
end

function love.update(dt)

    for i = 1, 3 do
        movers[i]:apply_force(gravity)
        friction = (movers[i].velocity * -1):norm()
        if friction then
            friction:mul(0.003)
            movers[i]:apply_force(friction)
        end
        if water:is_inside(movers[i]) then
            mag = movers[i].velocity:mag()
            local drag = water.c * mag * mag * movers[i].width
            drag_vec = (movers[i].velocity * -1):norm()
            drag_vec:mul(drag)
            movers[i]:apply_force(drag_vec)
        end
        movers[i]:check_boundaries()
        movers[i]:update()

    end
end

function love.draw()
    for i = 1, 3 do
        movers[i]:draw()
    end
    water:draw()
end