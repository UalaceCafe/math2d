# Namespace for the Math2D library
module Math2D
  # A collection of useful Mathematical tools in 2D space
  #
  # @author Ualace Henrique <ualacehenrique@hotmail.com>
  # @note Most if not all methods descriptions here present come from the p5.js website.
  # @see https://p5js.org/
  module Utils2D
    # Half the mathematical constant PI.
    HALF_PI      = Math::PI / 2
    # A quarter of the mathematical constant PI.
    QUARTER_PI   = Math::PI / 4
    # Twice the mathematical constant PI, also called TAU.
    TWO_PI = TAU = Math::PI * 2

    # Multiplication constant to convert a value in degrees to radians.
    # @note Can be used as a substitute to +Utils2D.to_rad+.
    DEG2RAD      = Math::PI / 180
    # Multiplication constant to convert a value in radians to degrees.
    # @note Can be used as a substitute to +Utils2D.to_deg+.
    RAD2DEG      = 180 / Math::PI

    # Returns +angle+ radians in degrees.
    #
    # @param [Numeric] angle
    # @return [Float]
    def self.to_deg(angle)
      angle * RAD2DEG
    end

    # Returns +angle+ degrees in radians.
    #
    # @param [Numeric] angle
    # @return [Float]
    def self.to_rad(angle)
      angle * DEG2RAD
    end

    # Returns the distance between two cartesian points.
    #
    # @param [Numeric] x1
    # @param [Numeric] y1
    # @param [Numeric] x2
    # @param [Numeric] y2
    # @return [Float]
    def self.distance(x1, y1, x2, y2)
      Math.sqrt((x2 - x1)**2 + (y2 - y1)**2)
    end

    # Calculates a number between two numbers at a specific increment.
    # The amt parameter is the amount to interpolate between the two
    # values where 0.0 equal to the first point, 0.1 is very near the
    # first point, 0.5 is half-way in between, and 1.0 is equal to the
    # second point.
    #
    # @param [Numeric] a
    # @param [Numeric] b
    # @param [Numeric] amt
    # @return [Float]
    def self.lerp(a, b, amt)
      (b - a) * (3.0 - amt * 2.0) * amt * amt + a
    end

    # Being the inverse of +#lerp+, it calculates the interpolation parameter t
    #  of the Lerp method given a range [+a+, +b+] and a interpolant value of +value+.
    #
    # @param [Numeric] a
    # @param [Numeric] b
    # @param [Numeric] value
    # @return [Float]
    def self.inverse_lerp(a, b, value)
      (value - a) / (b - a).to_f
    end

    # Re-maps a number from one range (+a1+..+a2+) to another (+b1+..+b2+).
    #
    # @param [Numeric] value
    # @param [Numeric] a1
    # @param [Numeric] a2
    # @param [Numeric] b1
    # @param [Numeric] b2
    # @return [Float]
    def self.map(value, a1, a2, b1, b2)
      raise ArgumentError, 'Division by 0 - a1 cannot be equal to a2' if a2 == a1

      slope = 1.0 * (b2 - b1) / (a2 - a1)
      b1 + slope * (value - a1)
    end

    # Normalizes a number from another range (+a+..+b+) into a value between 0 and 1.
    #
    # @param [Numeric] value
    # @param [Numeric] a
    # @param [Numeric] b
    # @return [Float]
    def self.normalize(value, a, b)
      map(value, a, b, 0.0, 1.0)
    end

    # Constrains a value +x+ between a minimum value +a+ and maximum value +b+.
    #
    # @param [Numeric] x
    # @param [Numeric] a
    # @param [Numeric] b
    # @return [Numeric]
    def self.constrain(x, a, b)
      [[x, a].max, b].min
    end

    class << self
      alias clamp constrain
    end

    # Returns the Perlin noise value at specified coordinates.
    # Perlin noise is a random sequence generator producing a more naturally
    # ordered, harmonic succession of numbers compared to the standard rand() method.
    # The main difference to the rand() method is that Perlin noise is defined in an
    # infinite n-dimensional space where each pair of coordinates corresponds to a fixed
    # semi-random value. Utils2D can compute 1D and 2D noise, depending on the number of
    # coordinates given. The resulting value will always be between 0.0 and 1.0.
    # @see https://en.wikipedia.org/wiki/Perlin_noise
    #
    # @param [Numeric] x
    # @param [Numeric] y
    # @return [Float]
    def self.noise(x, y = 0)
      x0 = x.to_i
      x1 = x0 + 1
      y0 = y.to_i
      y1 = y0 + 1

      sx = x - x0.to_f
      sy = y - y0.to_f

      n0 = dot_grid_gradient(x0, y0, x, y)
      n1 = dot_grid_gradient(x1, y0, x, y)
      ix0 = lerp(n0, n1, sx)

      n0 = dot_grid_gradient(x0, y1, x, y)
      n1 = dot_grid_gradient(x1, y1, x, y)
      ix1 = lerp(n0, n1, sx)
      lerp(ix0, ix1, sy)
    end

    # If no argument is passed, randomly generates a greyscale RGB array.
    # Otherwise, returns a greyscale array with that argument normalized.
    #
    # @param [Numeric] val
    # @return [Array<Float>]
    def self.grayscale(val = nil)
      c = if val
            normalize(val, 0, 255).abs
          else
            rand
          end
      [c, c, c, 1.0]
    end

    private

    # @private
    # @see https://en.wikipedia.org/wiki/Perlin_noise
    def self.random_gradient(ix, iy)
      random = 2920.0 * Math.sin(ix * 21_942.0 + iy * 171_324.0 + 8912.0) * Math.cos(ix * 23_157.0 * iy * 217_832.0 + 9758.0)
      [Math.cos(random), Math.sin(random)]
    end

    # @private
    # @see https://en.wikipedia.org/wiki/Perlin_noise
    def self.dot_grid_gradient(ix, iy, x, y)
      gradient = random_gradient(ix, iy)
      dx = x - ix.to_f
      dy = y - iy.to_f
      (dx * gradient[0]) + (dy * gradient[1])
    end
  end
end
