require 'sinatra'
require_relative 'parse'
# require 'sinatra/reloader'
# require 'sinatra/activerecord'
require 'pry'

get '/' do
  erb :main
end

post '/message/send' do
	# puts params.to_s.split(",")
	parse_encrypted(params)
	redirect '/'
end