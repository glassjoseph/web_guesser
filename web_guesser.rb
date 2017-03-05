require "sinatra"
require "sinatra/reloader"


secret_number = rand(99) + 1  

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess, secret_number)
  erb :index, :locals => {:secret_number => secret_number, :message => message}
end


def check_guess(guess, secret_number)
  if guess == secret_number
    message = "Correct! \nThe SECRET NUMBER is #{secret_number}."
  elsif guess > (secret_number + 5)
    message = "Way too high!"
  elsif guess < (secret_number - 5)
    message = "Way too low!"
  elsif guess > secret_number
    message = "Too high!"
  elsif guess < secret_number
    message = "Too low!"
  end
end
