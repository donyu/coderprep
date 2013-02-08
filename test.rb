require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'
require 'yaml'

get '/' do
	erb :index
end
