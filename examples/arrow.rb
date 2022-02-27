#=
# Example inspired by: https://p5js.org/reference/#/p5.Vector/magSq
#=
require 'ruby2d'
require 'math2d'

set(title: 'Arrow', width: 200, height: 200, background: Utils2D.grayscale(200))

WIDTH = Window.width
HEIGHT = Window.height

def draw_arrow(base, vector)
  Line.new(x1: base.x, y1: base.y, x2: base.x + vector.x, y2: base.y + vector.y, width: 5, color: 'red')

  heading = vector.heading
  mag = vector.magnitude
  arrow_size = 25
  translation = mag - arrow_size

  p1 = Vector2D.new(translation, arrow_size / 2.0).rotate(heading)
  p2 = Vector2D.new(translation, -arrow_size / 2.0).rotate(heading)
  p3 = Vector2D.new(mag + 5, 0).rotate(heading)
  Triangle.new(x1: p1.x, y1: p1.y, x2: p2.x, y2: p2.y, x3: p3.x, y3: p3.y, color: 'red')
end

v1 = Vector2D.zero

update do
  clear

  v2 = Vector2D.new(Window.mouse_x, Window.mouse_y)
  draw_arrow(v1, v2)

  Text.new("Magnitude: #{v2.length.round(2)}", x: 10, y: 150, color: 'black')
  Text.new("Heading: #{(v2.heading * Utils2D::RAD2DEG).round(2)}°", x: 10, y: 172, color: 'black')
end

show
