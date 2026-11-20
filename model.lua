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

        self[i]:rotate(math.rad(r or 0))
        
    end
end

function Model.mt:flip(h)

    for i = 1, #self do

        self[i]:flip(h or false)

    end

end

function Model.mt:scale(scalar)

    for i = 1, #self do

        self[i]:mul(scalar)

    end

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
