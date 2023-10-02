class Snake
  attr_accessor :x, :y

  def initialize
    @x = 200
    @y = 200
    @dir_x = 1
    @dir_y = 0
  end

  def dead?
    @x.negative? || @x > 580 || @y.negative? || @y > 380
  end

  def go_left
    return if @dir_x == 1

    @dir_x = -1
    @dir_y = 0
  end

  def go_right
    return if @dir_x == -1

    @dir_x = 1
    @dir_y = 0
  end

  def go_up
    return if @dir_y == 1

    @dir_x = 0
    @dir_y = -1
  end

  def go_down
    return if @dir_y == -1

    @dir_x = 0
    @dir_y = 1
  end

  def move
    @x += @dir_x * 20
    @y += @dir_y * 20
  end
end
