# Namespace for the Math2D gem
module Math2D
  # Vector2D
  #
  # - An implementation of various 2-dimensional vector methods.
  #
  # @author Ualace Henrique <ualacehenrique@hotmail.com>
  # @note MOST methods return a NEW Vector2D instead of changing
  #       self and returning it, so be careful.
  # @attr [Numeric] x The x coordinate of the Vector
  # @attr [Numeric] y The y coordinate of the Vector
  class Vector2D
    attr_accessor :x, :y

    # Creates a new vector (x, y).
    #
    # @param [Numeric] x
    # @param [Numeric] y
    # @return [Vector2D]
    def initialize(x = 0, y = 0)
      @x = x.to_f
      @y = y.to_f
    end

    # Sets the +x+ and +y+ components of the vector.
    # Each argument is optional, so you can change a single component
    # and keep the other one's current value.
    #
    # @param [Numeric] x
    # @param [Numeric] y
    # @return [Vector2D] self
    def set(x = self.x, y = self.y)
      @x = x.to_f
      @y = y.to_f
      self
    end

    # Shorthand for writing Vector2D.new(0, 0).
    #
    # @return [Vector2D]
    def self.zero
      Vector2D.new(0, 0)
    end

    # Shorthand for writing Vector2D.new(1, 1).
    #
    # @return [Vector2D]
    def self.one
      Vector2D.new(1, 1)
    end

    # Shorthand for writing Vector2D.new(0, -1).
    # NOTE: the y-axis is inverted as per Ruby2D's y-axis orientation
    #
    # @return [Vector2D]
    def self.up
      Vector2D.new(0, -1)
    end

    # Shorthand for writing Vector2D.new(0, 1).
    #
    # @return [Vector2D]
    def self.down
      Vector2D.new(0, 1)
    end

    # Shorthand for writing Vector2D.new(-1, 0).
    #
    # @return [Vector2D]
    def self.left
      Vector2D.new(-1, 0)
    end

    # Shorthand for writing Vector2D.new(1, 0).
    #
    # @return [Vector2D]
    def self.right
      Vector2D.new(1, 0)
    end

    # Negates both x and y values of +self+ and returns a new Vector2D.
    #
    # @return [Vector2D]
    def -@
      Vector2D.new(-@x, -@y)
    end

    alias negate -@
    alias reverse -@

    # Adds +self+ to another vector or to a scalar.
    #
    # @param [Numeric, Vector2D] other
    # @return [Vector2D]
    def +(other)
      return Vector2D.new(@x + other.x, @y + other.y) if other.instance_of?(Vector2D)

      Vector2D.new(@x + other, @y + other)
    end

    # Subtracts +self+ to another vector or to a scalar.
    #
    # @param [Numeric, Vector2D] other
    # @return [Vector2D]
    def -(other)
      return Vector2D.new(@x - other.x, @y - other.y) if other.instance_of?(Vector2D)

      Vector2D.new(@x - other, @y - other)
    end

    # Multiplies +self+ by another vector or by a scalar.
    #
    # @param [Numeric, Vector2D] other
    # @return [Vector2D]
    def *(other)
      return Vector2D.new(@x * other.x, @y * other.y) if other.instance_of?(Vector2D)

      Vector2D.new(@x * other, @y * other)
    end

    # Divides +self+ by another vector or by a scalar.
    #
    # @param [Numeric, Vector2D] other
    # @return [Vector2D]
    def /(other)
      return Vector2D.new(@x / other.x, @y / other.y) if other.instance_of?(Vector2D)

      Vector2D.new(@x / other, @y / other)
    end

    # Compares +self+ and +other+ according to their components.
    #
    # @param [Vector2D] other
    # @return [Boolean]
    def ==(other)
      (@x == other.x) && (@y == other.y)
    end

    # Calculates the dot product between +self+ and +other+, where:
    # A.B (A dot B) = (Ax * Bx) + (Ay * By)
    #
    # @param [Vector2D] other
    # @return [Numeric]
    def dot(other)
      (@x * other.x) + (@y * other.y)
    end

    # Calculates the "cross product" (see note) between +self+ and +other+, where:
    # A^B (A wedge B) = (Ax * By) - (Bx * Ay)
    #
    # @note Strictly speaking, the cross product is not defined in a 2-dimensional space,
    # instead what is being calculated here is called a `wedge product`, which is defined
    # in any space of dimension greater than 1.
    #
    # @param [Vector2D] other
    # @return [Numeric]
    def cross(other)
      (@x * other.y) - (other.x * @y)
    end

    alias wedge cross

    # Returns the magnitude squared of +self+.
    #
    # @return [Numeric]
    def squared
      (@x**2) + (@y**2)
    end

    alias magnitude2 squared

    # Returns the magnitude of +self+.
    #
    # @return [Float]
    def magnitude
      Math.sqrt(@x**2 + @y**2)
    end

    alias length magnitude

    # Returns the squared Euclidean distance between +self+ and +other+. When comparing
    # distances, comparing the squared distance yields the same result without the
    # overhead of a square-root operation.
    #
    # @param [Vector2D] other
    # @return [Float]
    def distance2(other)
      (other.x - @x)**2 + (other.y - @y)**2
    end

    # Returns the Euclidean distance between +self+ and +other+.
    #
    # @param [Vector2D] other
    # @return [Float]
    def distance(other)
      Math.sqrt((other.x - @x)**2 + (other.y - @y)**2)
    end

    # Returns the ratio (x / y) of +self+.
    #
    # @return [Float]
    def ratio
      x.to_f / y
    end

    # Limit the magnitude of +self+ to +max+ and returns a new vector.
    #
    # @param [Numeric] max
    # @return [Vector2D]
    def limit(max)
      msq = squared
      return self if msq <= (max**2)

      self * (max / Math.sqrt(msq)) if msq > (max**2)
    end

    # Constrains the magnitude of +self+ between a minimum value +a+ and maximum value +b+, returns a new
    # vector or itself.
    #
    # @note I haven't experienced this with other methods (yet), so I'm only going to document this
    #       here: you may end up with a broken magnitude (1.99999999 instead of 2, for example),
    #       so always remember to check and round according to your need.
    # @param [Numeric] a
    # @param [Numeric] b
    # @return [Vector2D]
    def constrain(a, b)
      mag2 = magnitude2
      if mag2 > b.abs2
        Vector2D.one.set_magnitude(b)
      elsif mag2 < a.abs2
        Vector2D.one.set_magnitude(a)
      else
        self
      end
    end

    alias clamp constrain

    # Sets the magnitude of +self+ to +new_mag+.
    #
    # @param [Numeric] new_mag
    # @return [Vector2D] modified self
    def set_magnitude(new_mag)
      mag = magnitude
      mag = Float::INFINITY if mag.zero?
      self * (new_mag / mag)
      # Vector2D.new((@x * new_mag) / mag, (@y * new_mag) / mag)
    end

    alias magnitude! set_magnitude

    # Normalizes +self+ (set the magnitude to 1).
    # +unit+ is an alias for this method.
    #
    # @return [Vector2D] modified self
    def normalize
      set_magnitude(1)
    end

    alias normalize! normalize
    alias unit! normalize!
    alias unit normalize!

    # Returns true if the magnitude of +self+ is equal to 1, false otherwise.
    # +unit?+ is an alias for this method.
    #
    # @return [Boolean]
    def normalized?
      magnitude == 1
    end

    alias unit? normalized?

    # Returns the x-heading angle of +self+ in radians.
    # The x-heading angle is the angle formed between +self+ and the x-axis.
    #
    # @return [Float]
    def heading
      Math.atan2(@y.to_f, @x)
    end

    # Returns the y-heading angle of +self+ in radians.
    # The y-heading angle is the angle formed between +self+ and the y-axis.
    #
    # @return [Float]
    def y_heading
      Utils2D::HALF_PI - heading
    end

    # Returns a new Vector2D from a given angle +theta+ with length +len+.
    #
    # @param [Numeric] theta
    # @param [Numeric] len
    # @return [Vector2D]
    def self.from_angle(theta, len = 1)
      Vector2D.new(len * Math.cos(theta), len * Math.sin(theta))
    end

    # Returns the angle between +self+ and +other+ in radians.
    #
    # @param [Vector2D] other
    # @return [Float]
    def angle_between(other)
      Math.acos((@x * other.x + @y * other.y) / (magnitude * other.magnitude))
    end

    # Checks if +self+ is facing the opposite direction of +other+.
    #
    # @param [Vector2D] other
    # @return [Boolean]
    def opposite?(other)
      dot(other).negative?
    end

    # Clockwise rotates +self+ +angle+ radians and returns it as a new Vector2D.
    #
    # @param [Numeric] angle
    # @return [Vector2D]
    def rotate(angle)
      Vector2D.new(
        @x * Math.cos(angle) - @y * Math.sin(angle),
        @x * Math.sin(angle) + @y * Math.cos(angle)
      )
    end

    # Clockwise rotates +self+ +angle+ radians around a +pivot+ point and returns it as a new Vector2D.
    #
    # @param [Vector2D] pivot
    # @param [Numeric] angle
    # @return [Vector2D]
    def rotate_around(pivot, angle)
      x_rotated = pivot.x + ((@x - pivot.x) * Math.cos(angle)) - ((@y - pivot.y) * Math.sin(angle))
      y_rotated = pivot.y + ((@x - pivot.x) * Math.sin(angle)) + ((@y - pivot.y) * Math.cos(angle))

      Vector2D.new(x_rotated, y_rotated)
    end

    # Linear interpolate +self+ and +other+ with an amount +amt+.
    #
    # @param [Numeric, Vector2D] other
    # @param [Numeric] amt
    # @return [Vector2D]
    def lerp(other, amt)
      self + (other - self) * amt
    end

    # Calculates the parameter t of the +#lerp+ method between +self+ and +other+ given an interpolant +value+.
    #
    # @param [Numeric, Vector2D] other
    # @param [Vector2D] value
    # @return [Vector2D]
    def inverse_lerp(other, value)
      (value - self) / (other - self)
    end

    # Reflects +self+ and returns it as a new Vector2D.
    # +other+ is the normal of the plane where +self+ is reflected.
    #
    # @param [Vector2D] other
    # @return [Vector2D]
    def reflect(other)
      other = other.normalize
      dot_prod = other.dot(self)
      x = @x - dot_prod * other.x * 2
      y = @y - dot_prod * other.y * 2
      Vector2D.new(x, y)
    end

    # Refracts +self+ and returns it as a new Vector2D.
    # +other+ is the normal of the plane where +self+ is refracted.
    #
    # @see https://www.khronos.org/registry/OpenGL/specs/gl/GLSLangSpec.1.20.pdf GLS Language Specification (page 66)
    #
    # @param [Vector2D] other
    # @param [Numeric] refractive_index
    # @return [Vector2D]
    def refract(other, refractive_index)
      dot_prod = other.dot(self)
      k = 1.0 - refractive_index * refractive_index * (1.0 - dot_prod * dot_prod)
      return Vector2D.zero if k.negative?

      x = refractive_index * @x - (refractive_index * dot_prod * Math.sqrt(k)) * other.x
      y = refractive_index * @y - (refractive_index * dot_prod * Math.sqrt(k)) * other.y
      Vector2D.new(x, y)
    end

    # Returns a new Vector2D with random components but magnitude equal to 1.
    #
    # @return [Vector2D]
    def self.random
      theta = rand(-Utils2D::TWO_PI..Utils2D::TWO_PI)
      Vector2D.new(Math.cos(theta), Math.sin(theta))
    end

    # Converts +self+ to an array.
    #
    # @return [Array<Numeric>]
    def to_a
      [@x, @y]
    end

    # Converts +self+ to a string.
    #
    # @return [String]
    def to_s
      to_a.to_s
    end

    # Returns a new Vector2D from an array +arr+.
    # If the array is bigger than 2 elements, only the first 2 will be considered.
    #
    # @param [Array<Numeric>] arr
    # @return [Vector2D]
    def self.to_vector(arr)
      raise ArgumentError, '`arr` must be an Array' if arr.class != Array

      Vector2D.new(arr[0], arr[1])
    end
  end
end
