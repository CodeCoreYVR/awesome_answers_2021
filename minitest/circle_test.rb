require "minitest/autorun"

# TDD Circle class
#
# Write a Circle class following TDD principles. Initialize the circle with a radius attribute. It should have the following 3 methods

# diameter method that returns the diameter.
# area method that returns the area of the circle. Test with various circles that the area returned is correct.
# perimeter method that returns the length of circle's border (or perimeter). Test with various circles that the perimeter returned is correct.

class Circle
  attr_accessor :r

  def initialize(r)
    @r = r
  end

  def diameter 
    r * 2
  end

  def area
    ((r * r).to_f * Math::PI).round(12)
  end

  def circumference
    ((2 * Math::PI) * r).round(12)
  end
end

describe "Circle" do

  describe ".diameter" do

    it "returns the diameter of a circle" do
      circle = Circle.new(5)
      
      _(circle.diameter).must_equal(10)
    end

  end

  describe ".area" do
    
    it "returns the area of a circle with percision" do
      circle = Circle.new(5)

      _(circle.area).must_equal(78.539816339745)
    end
  end

  describe ".circumference" do

    it "returns the perimeter of a circle" do
      circle = Circle.new(5)

      _(circle.circumference).must_equal(31.415926535898)
    end
  end
end

