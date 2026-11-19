local Vec2 = {}

Vec2.mt = {}

Vec2.mt.__index = Vec2.mt

function Vec2.mt.__add(veca, vecb)
    return {x = veca.x + vecb.x, y = veca.y + vecb.y}
end

function Vec2.mt.__mul(veca, b)
    
    if type(b) == "table" then return setmetatable({x = veca.x * b.x, y = veca.y * b.y}, Vec2.mt) end
    
    if type(b) == "number" then return setmetatable({x = veca.x * b, y = veca.y * b}, Vec2.mt) end
    
end

function Vec2.mt:rotate(b)

    c = self.x
    d = self.y
    self.x = c * math.cos(b) - d * math.sin(b)
    self.y = c * math.sin(b) + d * math.cos(b)

end

function Vec2.mt:flip(h)

    c = self.x
    d = self.y

    if h then 
        
        self.x = c * math.cos(math.rad(180)) + d * math.sin(math.rad(180))
        self.y = c * math.sin(math.rad(180)) - d * math.cos(math.rad(180))

    else

        self.x = c * math.cos(0) + d * math.sin(0) self.y = c * math.sin(0) - d * math.cos(0)

    end

end

function Vec2.mt:add(b)

    if type(b) == "table" then self.x = self.x + b.x self.y = self.y + b.y end
    if type(b) == "number" then self.x = self.x + b self.y = self.y + b end

end

function Vec2.createVec(a,b)

    local vec = {}

    vec.x = a
    vec.y = b

    setmetatable(vec, Vec2.mt)

    return vec
end


return Vec2
