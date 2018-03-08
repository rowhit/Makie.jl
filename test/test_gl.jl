using Makie
using GeometryTypes

function Base.show(io::IO, ::MIME"text/plain", scene::Scene)
    isempty(scene.current_screens) || return
    screen = Screen(scene)
    for elem in scene.plots
        insert!(screen, scene, elem)
    end
    return
end
function Base.show(io::IO, m::MIME"text/plain", plot::Makie.AbstractPlot)
    show(io, m, Makie.parent(plot)[])
    nothing
end

scene = Scene()
scene.px_area[] = IRect(0, 0, 1920, 1080)
cam = cam2d!(scene)
cam.area[] = FRect(0, 0, normalize(widths(scene.px_area[])) * 3)
update_cam!(scene, cam)
ax = axis2d(scene, Makie.Node((linspace(0, 4, 5), linspace(0, 4, 5))))
scatter!(scene, [0, 0, 1, 1], [0, 1, 0, 1])
scene


x = lines!(scene, FRect(0, 0, 0.5, 0.5), linestyle = :dot)
x[:positions] = FRect(0, 0, 1.0, 0.5)
x[:visible] = true

# screen = Screen(scene)
a = text!(scene, "Hellooo", color = :white, textsize = 0.1, position = (0.5, 0.5))
b = scatter!(scene, rand(10), rand(10))
b = linesegments!(scene, rand(10), rand(10))
c = plot!(scene, rand(10), rand(10), color = :white)
d = meshscatter!(scene, rand(10), rand(10), rand(10));


# update_cam!(scene, FRect(0, 0, 1, 2))

# cam = Makie.cam2d!(scene)

# cam.rotationspeed[] = 0.1
# cam.pan_button[] = Mouse.right
# scene.events.window_dpi[]

# screenw = widths(scene.px_area[])
# camw = widths(scene.area[])
#
# screen_r = screenw ./ screenw[1]
# camw_r = camw ./ camw[1]
# r = (screen_r ./ camw_r)
# r = r ./ maximum(r)
#
# update_cam!(scene, FRect(minimum(scene.area[]), r .* camw))