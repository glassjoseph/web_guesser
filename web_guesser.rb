require "sinatra"
require "sinatra/reloader"

number = rand(99) + 1
get '/' do
  "The secret number is #{number}"
end
