#=
# Controls:
#   Mouse      - move the yellow ball around
#   Arrow Up   - increase the amount of interpolation
#   Arrow Down - decrease the amount of interpolation
#=
require 'ruby2d'
require 'math2d'

set(title: 'Lerp', width: 400, height: 400)

pos1 = Vector2D.new(35, 365)

amt = 0.5

on :key_down do |event|
  case event.key
  when 'up'
    amt += 0.1
  when 'down'
    amt -= 0.1
  end
  amt = amt > 1 ? 1 : amt
  amt = amt.negative? ? 0 : amt
  puts "Amount: #{amt.round(1)}"
end

update do
  clear

  Circle.new(x: pos1.x, y: pos1.y, radius: 20, color: 'red')

  pos2 = Vector2D.new(Window.mouse_x, Window.mouse_y)
  Circle.new(x: pos2.x, y: pos2.y, radius: 20, color: 'yellow')

  pos3 = pos2.lerp(pos1, amt)
  Circle.new(x: pos3.x, y: pos3.y, radius: 20, color: 'green')
end

show
