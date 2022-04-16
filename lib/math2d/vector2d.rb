# Namespace for the Math2D gem
module Math2D
  # Vector2D
  #
  # - An implementation of various 2-dimensional vector methods.
  #
  # @author Ualace Henrique <ualacehenrique@hotmail.com>
  # @note ALL ! (bang) methods that return a vector (e.g. #normalize!, #add!) change the vector in place
  #       and return _self_.
  # @note MOST (but not all) regular methods that return a vector create NEW _Vector2D_. Some however change the
  #       vector in place and return _self_, so be careful.
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

    # Creates a copy of the +other+ vector.
    #
    # @param [Vector2D] other Vector to copy
    # @return [Vector2D]
    def initialize_copy(other)
      @x = other.x
      @y = other.y
    end

    # Replace contents of this vector with contents of +other+ *in place*.
    #
    # @param [Vector2D] other
    # @return [Vector2D] modified vector
    def replace!(other)
      @x = other.x
      @y = other.y
      self
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
    # @return [Vector2D] new vector
    def -@
      Vector2D.new(-@x, -@y)
    end

    alias negate -@
    alias reverse -@

    #
    # Negate this vector, modifying it in place
    #
    # @return [Vector2D] modified self
    def reverse!
      @x = -@x
      @y = -@y
      self
    end

    alias negate! reverse!

    # Adds +self+ to another vector, scalar, or array of two scalars
    #
    # @param [Numeric, Vector2D, Array] other
    # @return [Vector2D] new vector
    def +(other)
      clone.plus!(other)
    end

    # Subtracts +self+ from another vector, scalar, or array of two scalars
    #
    # @param [Numeric, Vector2D, Array] other
    # @return [Vector2D] new vector
    def -(other)
      clone.minus!(other)
    end

    # Multiplies +self+ by another vector, scalar, or array of two scalars
    #
    # @param [Numeric, Vector2D, Array] other
    # @return [Vector2D] new vector
    def *(other)
      clone.times!(other)
    end

    # Divides +self+ by another vector, scalar, or array of two scalars
    #
    # @param [Numeric, Vector2D, Array] other
    # @return [Vector2D] new vector
    def /(other)
      clone.divide_by!(other)
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
    # @return [Vector2D] new vector
    def limit(max)
      msq = squared
      return self if msq <= (max**2)

      self * (max / Math.sqrt(msq))
    end

    # Constrains the magnitude of +self+ between a minimum value +min+ and maximum value +max+, returns a new
    # vector or itself.
    #
    # @note I haven't experienced this with other methods (yet), so I'm only going to document this
    #       here: you may end up with a broken magnitude (1.99999999 instead of 2, for example),
    #       so always remember to check and round according to your need.
    # @param [Numeric] min
    # @param [Numeric] max
    # @return [Vector2D] new vector, or self
    def constrain(min, max)
      min, max = max, min if min > max # swap
      mag2 = magnitude2
      if mag2 > max.abs2
        Vector2D.one.set_magnitude(max)
      elsif mag2 < min.abs2
        Vector2D.one.set_magnitude(min)
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
      times!(new_mag / mag)
    end

    alias magnitude! set_magnitude

    # Normalizes +self+ (set the magnitude to 1) and returns a new vector.
    # +unit+ is an alias for this method.
    #
    # @return [Vector2D] new vector
    def normalize
      clone.set_magnitude(1)
    end

    alias unit normalize

    # Normalizes +self+ (set the magnitude to 1) *in place*.
    # +unit!+ is an alias for this method.
    #
    # @return [Vector2D] modified self
    def normalize!
      set_magnitude(1)
    end

    alias unit! normalize!

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
    # @return [Vector2D] new vector
    def rotate(angle)
      clone.rotate!(angle)
    end

    # Clockwise rotates +self+ by +angle+ radians *in place*
    #
    # @param [Numeric] angle
    # @return [Vector2D] modified self
    def rotate!(angle)
      sin_ang = Math.sin(angle)
      cos_ang = Math.cos(angle)
      @x = @x * cos_ang - @y * sin_ang
      @y = @x * sin_ang + @y * cos_ang
      self
    end

    # Clockwise rotates +self+ +angle+ radians around a +pivot+ point and returns it as a new Vector2D.
    #
    # @param [Vector2D] pivot
    # @param [Numeric] angle
    # @return [Vector2D] new vector
    def rotate_around(pivot, angle)
      clone.rotate_around!(pivot, angle)
    end

    # Clockwise rotates +self+ by +angle+ radians around a +pivot+ point *in place*
    #
    # @param [Vector2D] pivot
    # @param [Numeric] angle
    # @return [Vector2D] modified self
    def rotate_around!(pivot, angle)
      pivot_x = pivot.x
      pivot_y = pivot.y
      dx = (@x - pivot_x)
      dy = (@y - pivot_y)
      sin_ang = Math.sin(angle)
      cos_ang = Math.cos(angle)
      @x = pivot_x + (dx * cos_ang) - (dy * sin_ang)
      @y = pivot_y + (dx * sin_ang) + (dy * cos_ang)
      self
    end

    # Linear interpolate +self+ and +other+ with an amount +amt+.
    #
    # @param [Numeric, Vector2D] other
    # @param [Numeric] amt
    # @return [Vector2D] new vector
    def lerp(other, amt)
      Vector2D.new @x + (other.x - @x) * amt,
                   @y + (other.y - @y) * amt
      # self + (other - self) * amt
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
      Vector2D.new @x - dot_prod * other.x * 2,
                   @y - dot_prod * other.y * 2
    end

    # Refracts +self+ and returns it as a new Vector2D.
    # +other+ is the normal of the plane where +self+ is refracted.
    #
    # @see https://www.khronos.org/registry/OpenGL/specs/gl/GLSLangSpec.1.20.pdf GLS Language Specification (page 66)
    # @see https://www.khronos.org/registry/OpenGL-Refpages/gl4/html/refract.xhtml
    #
    # @param [Vector2D] other
    # @param [Numeric] refractive_index
    # @return [Vector2D]
    def refract(other, refractive_index)
      dot_prod = other.dot(self)
      k = 1.0 - refractive_index.abs2 * (1.0 - dot_prod.abs2)
      return Vector2D.zero if k.negative?

      other_refraction = (refractive_index * dot_prod * Math.sqrt(k))
      x = refractive_index * @x - other_refraction * other.x
      y = refractive_index * @y - other_refraction * other.y
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

    # Returns a *new vector* of the clockwise perpendicular to this vector.
    #
    # @return [Vector2D]
    #
    def vector_cross_product
      Vector2D.new @y, -@x
    end

    alias perp vector_cross_product

    # Replace this vector with it's clockwise perpendicular
    #
    # @return [Vector2D] modified self
    def vector_cross_product!
      @x, @y = @y, -@x
      self
    end

    alias perp! vector_cross_product!

    # Returns a new Vector2D from an array +arr+.
    # If the array is bigger than 2 elements, only the first 2 will be considered.
    #
    # @param [Array<Numeric>] arr
    # @return [Vector2D]
    def self.to_vector(arr)
      raise ArgumentError, '`arr` must be an Array' if arr.class != Array

      Vector2D.new(arr[0], arr[1])
    end

    # Multiplies +self+ by +delta+ in place.
    #
    # @param [Numeric, Vector2D, Array] delta
    # @return [Vector2D] modified self
    def times!(delta)
      case delta
      when Vector2D
        @x *= delta.x
        @y *= delta.y
      when Array
        @x *= delta[0]
        @y *= delta[1]
      else
        @x *= delta
        @y *= delta
      end
      self
    end

    # Subtracts +delta+ from +self+ in place.
    #
    # @param [Numeric, Vector2D, Array] delta
    # @return [Vector2D] modified self
    def minus!(delta)
      case delta
      when Vector2D
        @x -= delta.x
        @y -= delta.y
      when Array
        @x -= delta[0]
        @y -= delta[1]
      else
        @x -= delta
        @y -= delta
      end
      self
    end

    # Adds +delta+ to +self+ in place.
    #
    # @param [Numeric, Vector2D, Array] delta
    # @return [Vector2D] modified self
    def plus!(delta)
      case delta
      when Vector2D
        @x += delta.x
        @y += delta.y
      when Array
        @x += delta[0]
        @y += delta[1]
      else
        @x += delta
        @y += delta
      end
      self
    end

    # Divides +self+ by +delta+ in place.
    #
    # @param [Numeric, Vector2D, Array] delta
    # @return [Vector2D] modified self
    def divide_by!(delta)
      case delta
      when Vector2D
        @x /= delta.x
        @y /= delta.y
      when Array
        @x /= delta[0]
        @y /= delta[1]
      else
        @x /= delta
        @y /= delta
      end
      self
    end

    # Add +dx+ and +dy+ to the current vector's components, respectively
    #
    # @param [Numeric] dx
    # @param [Numeric] dy
    # @return [Vector2d] modified self
    def add!(dx, dy)
      @x += dx
      @y += dy
      self
    end

    # Subtract +dx+ and +dy+ _from_ the current vector's components, respectively
    #
    # @param [Numeric] dx
    # @param [Numeric] dy
    # @return [Vector2d] modified self
    def subtract!(dx, dy)
      @x -= dx
      @y -= dy
      self
    end
  end
end
