require "sinatra"
require "sinatra/reloader"


class WebGuesser
  attr_reader :secret_number
  attr_accessor :color, :guesses

  def initialize
    @secret_number = rand(99) + 1
    @color = "Cornflower Blue"
    @@guesses = 5
  end

  def restart
    @secret_number = rand(99) + 1
    @@guesses = 5
  end

  def set_color(color)
    @color = color
  end

  def check_guess(guess, secret_number)
    @@guesses -= 1
    if @@guesses == 0
      restart
      return "Sorry! Out of guesses! Try again."
    end
    if guess == secret_number
      set_color("Green")
      "Correct! \nThe SECRET NUMBER is #{secret_number}."
    elsif guess > (secret_number + 5)
      set_color("Red")
      "Way too high!"
    elsif guess < (secret_number - 5)
      set_color("Red")
      "Way too low!"
    elsif guess > secret_number
      set_color("#ffb3b3")
      "Too high!"
    elsif guess < secret_number
      set_color("#ffb3b3")
      "Too low!"
    end
  end
end

guesser = WebGuesser.new
get '/' do
  guess = params["guess"].to_i
  message = guesser.check_guess(guess, guesser.secret_number)
  erb :index, :locals => {:secret_number => @secret_number, :message => message, :color => guesser.color}
end
