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
      @score = 0
      sleep(1.5)
      @snake = Snake.new
    end
    return unless @snake.body[0][0] == @food.x && @snake.body[0][1] == @food.y

    @snake.grow
    @score += 100
    @eat_sound.play
    @food.randomize
  end

  def draw
    draw_snake
    draw_rect(@food.x, @food.y, 20, 20, Gosu::Color::RED)
    @score_counter.draw_text("Score: #{@score}", 10, 10, 1)
  end

  def draw_snake
    @snake.body.each do |arr|
      draw_rect(arr[0], arr[1], 20, 20, Gosu::Color::WHITE)
    end
  end
end

snake = Game.new
snake.update_interval = 120.0
snake.show
