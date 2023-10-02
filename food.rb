class Food
  attr_accessor :x, :y

  def initialize
    @x = (0..580).each_slice(20).map(&:first).sample
    @y = (0..380).each_slice(20).map(&:first).sample
  end

  def randomize
    @x = (0..580).each_slice(20).map(&:first).sample
    @y = (0..380).each_slice(20).map(&:first).sample
  end
end
