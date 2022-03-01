require 'ruby2d'
require 'math2d'

set(title: 'Lerp', width: 400, height: 400)

pos1 = Vector2D.new(35, 365)

AMT = 0.5

update do
  clear

  Circle.new(x: pos1.x, y: pos1.y, radius: 20, color: 'red')

  pos2 = Vector2D.new(Window.mouse_x, Window.mouse_y)
  Circle.new(x: pos2.x, y: pos2.y, radius: 20, color: 'yellow')

  pos3 = pos2.lerp(pos1, AMT)
  Circle.new(x: pos3.x, y: pos3.y, radius: 20, color: 'green')
end

show
