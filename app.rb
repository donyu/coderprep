require 'sinatra'
require 'sinatra/activerecord'
require 'yaml'

get '/' do
	erb :index
end
