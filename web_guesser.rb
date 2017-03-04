require "sinatra"
require "sinatra/reloader"

number = rand(99) + 1
get '/' do
  erb :index, :locals => {:number => number}
end
