local Renderer = {}

function Renderer.aspR(w,h, model)

    local p = {}

        for v = 1, #model do

            p[v] = {}

            p[v].y = model[v].y

            if h > w/2 then
            
                p[v].x = model[v].x * 2

            else

                p[v].x = model[v].x * math.floor((w/h))

            end

        end

    return p
    
end

--[[aspect ratio is probably just seeing what window width and height is ideal
for each shape and looking at the actual current width and height and adjusting model values

turns out, that fixes the issue when its at proper orientation and the
ideal window widht and height, but with window width and window height change
it turns unideal
but when rotated the issue persists, perhaps its because i didnt actually
make it dynamci, just multiplied width of box by 2, i'll try a proper
attempt later, but at this point in time im not convinced it will
fix the anomalous shape during rotation,


so when i made it dynamic it worked completely for every single aspect ratio
and window width and height, but rotation issues persist

rotation issues fixed but i just realized the aspect ratio is still kind of weird for
exotic aspect ratios but 'normal' for all 'normal'


why the f**k is hte model not drawing despite the logic being the same as before
and 0,0 is comfortably drawing?!?!?!?!?

nvm i fixed that cus it was bc i would set draw to the grid thing every time
it would loop trhough the model vertices, so if draw was set to the
approrpiate model draw thing, it owuld reset back to grid if not EVERY pointw
was the actual current point that the master loop is rendiering to, so use a boolena


now everything related to rendering is solid, by the foundation, meaning not like a bunch of stuff
but like the stuff needed to draw a rotating model is bugless, however that
doesnt mean there isnt room for improvement, cus i prob should adjust aspect
ratio for model drawing based on rotation to make exotic angles look less distorted


i got multiple model batching to work, but apparently this sh1t is runnign at 7 fps still (though faster before batching), so
ill prob optimise it by instead of getP for every model vertex every frame, a converted
model is stored along side the actual model and the converted model is drawn when the
actual model is put in the batch, and ill prob make it so that each vertex in the constructed
model isnt just the character used to draw it, but probably also the negative grid space as well
but i dont know how feasible that is cus transforming it would prob change stuff,
but maybe it could be that a constructed model does this:

it constructs the negative space based on what ever negative space is left, and the "frame" table
that is drawn once with io.write that has the batch will prob be comprised of tables that have the point (vertex/vector) but
ALSO a boolean that indicated whether it was changed by another model, and whatever model characters arent negative space
turns that boolean on

but thats just a possibility ill try later

the goal is for this to take 17 ms to run which would be roughly 60 FPS

wait nvm i actually cannot tell the speed of this program on this god forsaken website because
i testd out "hello world" in a blank project to see how fast that would run and that sh1t was
above 170 ms, so this website is clearly the problem lmao the pvssy @ss school district wont let us
get zerobrane on this sh1t because they are pvssies FVCK


also the previous thing where u fill negative space is defienitely unfeasible for every vertex but perhaps
it might be a useful speed up in the right situation so ill keep that in mind

--]]

function Renderer.make(w,h, grid)
    
    local r = {}
    
    center = {x = w/2, y = h/2}
    
    local function getP(batch)

        local p = {}
        
        for i = 1, #batch do

            p[i] = {}

            for a = 1, #batch[i] do

                local arp = Renderer.aspR(w,h, batch[i])

                p[i][a] = {x = arp[a].x + center.x, y = center.y - arp[a].y}

            end
            
        end
        
        return p
    end

    local function buildFrame(frame, batch)

        p = getP(batch)

        local frame = {}

        for a = 1, h do

            frame[a] = {}

            for b = 1, w do

                d = false

                for i = 1, #batch do

                    for v = 1, #batch[i] do

                        if math.ceil(p[i][v].x) == b and math.ceil(p[i][v].y) == a then

                            d = true

                        end

                    end

                end


                if d then

                    draw = "+"

                else

                    draw = grid or "-"

                end

                frame[a][b] = draw

            end

        end

        local s = ""

        for a = 1, h do

            for b = 1, w do 

                s = s .. frame[a][b]

            end

            s = s .. "\n"

        end

        return s

    end
    
    function r:draw(batch)
        
        io.write(buildFrame(frame, batch))
        
    end
    
    return r
    
end

function Renderer.draw(batch, r)
    
    r:draw(batch)

end

return Renderer

