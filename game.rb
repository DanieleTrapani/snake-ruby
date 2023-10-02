require 'gosu'
require_relative 'food'
require_relative 'snake'
class Game < Gosu::Window
  def initialize
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

snake = Game.new
snake.update_interval = 120.0
snake.show
