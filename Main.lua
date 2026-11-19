local model = require "model"
local vec2 = require "vec2"
local render = require "render"


quad = model.quad(1)
quad1 = model.buildModel()

batch = {quad, quad1}

r = render.make(70,30, " ")

render.draw(batch, r)