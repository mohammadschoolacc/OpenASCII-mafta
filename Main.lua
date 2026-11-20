local model = require "model"
local vec2 = require "vec2"
local render = require "render"
local models = require "models"

quad1 = model.buildModel(models.bulkysword)

quad1:rotate(math.random(1,360))

batch = {quad1}

r = render.make(70,30, " ")

render.draw(batch, r)
