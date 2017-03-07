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
    message = "Sorry! Out of guesses! Try again."
  end

  def check_guess(guess, secret_number)
    @@guesses -= 1
    restart if @@guesses == 0
    if guess == secret_number
      @color = "Green"
      message = "Correct! \nThe SECRET NUMBER is #{secret_number}."
    elsif guess > (secret_number + 5)
      @color = "Red"
      message = "Way too high!#{secret_number}, #{@@guesses}"
    elsif guess < (secret_number - 5)
      @color = "Red"
      message = "Way too low!#{secret_number}, #{@@guesses}"
    elsif guess > secret_number
      @color = "#ffb3b3"
      message = "Too high#{secret_number}, #{@@guesses}!"
    elsif guess < secret_number
      @color = "#ffb3b3"
      message = "Too low#{secret_number}, #{@@guesses}!"
    end
  end
end

guesser = WebGuesser.new
get '/' do
  guess = params["guess"].to_i
  message = guesser.check_guess(guess, guesser.secret_number)
  erb :index, :locals => {:secret_number => @secret_number, :message => message, :color => guesser.color}
end
