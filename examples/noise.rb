require 'ruby2d'
require 'math2d'

set(title: 'Utils2D#noise', width: 600, height: 400, background: 'white', diagnostics: true)

width = Window.width
height = Window.height
scale = 0.02

update do
  clear

  width.times do |x|
    val = Utils2D.noise((Window.mouse_x + x) * scale, Window.mouse_y * scale)
    Line.new(x1: x, y1: Window.mouse_y + val * 200, x2: x, y2: height, color: 'black')
  end
end

show
