require "sinatra"
require "sinatra/reloader"

secret_number = rand(99) + 1
@background_color = "Cornflower Blue"

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess, secret_number)
  erb :index, :locals => {:secret_number => secret_number, :message => message, :background_color => @background_color}
end


def check_guess(guess, secret_number)
  if guess == secret_number
    @background_color = "Green"
    message = "Correct! \nThe SECRET NUMBER is #{secret_number}."
  elsif guess > (secret_number + 5)
    @background_color = "Red"
    message = "Way too high!"
  elsif guess < (secret_number - 5)
    @background_color = "Red"
    message = "Way too low!"
  elsif guess > secret_number
    @background_color = "#ffb3b3"
    message = "Too high!"
  elsif guess < secret_number
    @background_color = "#ffb3b3"
    message = "Too low!"
  end
end
