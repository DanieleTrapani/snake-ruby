require 'gosu'
class Game < Gosu::Window
  def initialize
    # puts update_interval
    super 600, 400
    self.caption = 'Snake Game'
    @snake = Snake.new
    @food = Food.new
    @score = 0
    @score_counter = Gosu::Font.new(28)
    @death_sound = Gosu::Song.new('death.wav')
    @eat_sound = Gosu::Song.new('eat.wav')
  end

  # main game logic
  def update
    if Gosu.button_down? Gosu::KB_LEFT
      @snake.go_left
    elsif Gosu.button_down? Gosu::KB_RIGHT
      @snake.go_right
    elsif Gosu.button_down? Gosu::KB_UP
      @snake.go_up
    elsif Gosu.button_down? Gosu::KB_DOWN
      @snake.go_down
    end
    @snake.move
    if @snake.dead?
      @death_sound.play
      sleep(1.5)
      @snake = Snake.new
    end
    return unless @snake.x == @food.x && @snake.y == @food.y

    @food.randomize
    @score += 100
    @eat_sound.play
  end

  # redraw the window
  def draw
    draw_rect(@snake.x, @snake.y, 20, 20, Gosu::Color::WHITE)
    draw_rect(@food.x, @food.y, 20, 20, Gosu::Color::RED)
    @score_counter.draw_text("Score: #{@score}", 10, 10, 1)
  end
end

# TODO: change the snake to be an array of coordinates
# TODO: update the death condition to be true if array.uniq.length is diff than array.length (2 coordinates overlap)
# TODO: when the snake eats it grows: pushes a new segment to the array. Update the move method so it changes each of the segments accordingly.
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

snake = Game.new
snake.update_interval = 120.0
snake.show
