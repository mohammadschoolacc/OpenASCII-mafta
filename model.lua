local Vec2 = require "vec2"

local Model = {}

Model.mt = {}

Model.mt.__index = Model.mt

function Model.mt:translate(vec)

    for i = 1, #self do
        
        self[i]:add(vec)

    end
end

function Model.mt:rotate(r)

    for i = 1, #self do

        self[i]:rotate(math.rad(r))
        
    end
end

function Model.mt:flip(h)

    for i = 1, #self do

        self[i]:flip(h or false)

    end

end

function Model.quad(scale)

    local quad = {}

    --blade
    quad[1] = Vec2.createVec(-1,5) * (scale or 1)
    quad[2] = Vec2.createVec(0,4) * (scale or 1)
    quad[3] = Vec2.createVec(1,-3) * (scale or 1)
    quad[4] = Vec2.createVec(-1,-3) * (scale or 1)
    quad[5] = Vec2.createVec(-1,-5) * (scale or 1)
    quad[6] = Vec2.createVec(1,-5) * (scale or 1)
    
    --hilt
    
    quad[7] = Vec2.createVec(-3,-5) * (scale or 1)
    quad[8] = Vec2.createVec(3,-5) * (scale or 1)
    quad[9] = Vec2.createVec(0,-6) * (scale or 1)
    quad[10] = Vec2.createVec(0,-7) * (scale or 1)
    quad[10] = Vec2.createVec(0,-8) * (scale or 1)
    
    setmetatable(quad, Model.mt)

    return quad
end

function Model.buildModel(data)

    if type(data) == "table" then

        local model = {}

        for i = 1, #data do

            model[i] = Vec2.createVec(data[i][1], data[i][2])

        end

        setmetatable(model, Model.mt)

        return model

    else

        return nil

    end
end

return Model
