class Snake
  attr_accessor :x, :y, :body

  def initialize
    @body = [[200, 200]]
    @dir_x = 1
    @dir_y = 0
  end

  def dead?
    @body[0][0].negative? || @body[0][0] > 580 || @body[0][1].negative? || @body[0][1] > 380
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
    @body.last[0] = @body.first[0] + @dir_x * 20
    @body.last[1] = @body.first[1] + @dir_y * 20
    @body.unshift(@body.pop)
  end

  def grow
    @body << [@body.last[0] - (25 * @dir_x), @body.last[1] - (25 * @dir_y)]
  end
end
