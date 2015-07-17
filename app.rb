# require 'sinatra'
# require_relative 'lib/parse'
# require 'sinatra/reloader'
# require 'sinatra/activerecord'
# require 'pry'

get '/' do
  erb :main
end

get '/messages' do
  erb :main
end

post '/message/send' do
	# puts params.to_s.split(",")
	puts parse_encrypted(params)

  redirect '/'
end
