Mover = {}
Mover.__index = Mover

function Mover:create(location, velocity, width, height)
    local mover = {}
    setmetatable(mover, Mover)
    mover.location = location
    mover.velocity = velocity
    mover.width = width
    mover.height = height
    mover.acceleration = Vector:create(0, 0)
    mover.weight = 1
    mover.size = mover.weight * 20
    return mover
end

function Mover:apply_force(force)
    self.acceleration:add(force * self.weight)
end

function Mover:draw()
    love.graphics.rectangle("fill", self.location.x, self.location.y, self.width, self.height)
end

function Mover:update()
    self.velocity:add(self.acceleration)
    self.location:add(self.velocity)
    self.acceleration:mul(0)
end

function Mover:check_boundaries()
    if self.location.x > width - self.size then
        self.location.x = width - self.size
        self.velocity.x = -1 * self.velocity.x
    elseif self.location.x < self.size then
        self.location.x = self.size
        self.velocity.x = -1 * self.velocity.x
    end
    if self.location.y > height - self.size then
        self.location.y = height - self.size
        self.velocity.y = -1 * self.velocity.y
    elseif self.location.y < self.size then
        self.location.y = self.size
        self.velocity.y = -1 * self.velocity.y
    end
end