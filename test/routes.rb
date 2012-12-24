require 'sinatra'
require 'better_robots'

get '/robots.txt' do
  BetterRobots::Generator.call(env)
end