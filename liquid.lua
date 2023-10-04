Liquid = {}
Liquid.__index = Liquid

function Liquid:create(x, y, w, h, c)
    local liquid = {}
    setmetatable(liquid, Liquid)
    liquid.x = x
    liquid.y = y
    liquid.w = w
    liquid.h = h
    liquid.c = c
    return liquid
end

function Liquid:is_inside(object)
    local xc = object.location.x + object.size / 2
    local yc = object.location.y + object.size / 2
    if (xc > self.x and xc < self.x + self.w and yc > self.y and yc < self.y + self.h) then
        return true
    end
    return false
end

function Liquid:draw()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(0, 119/255, 190/255, 0.5)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    love.graphics.setColor(r, g, b, a)
end