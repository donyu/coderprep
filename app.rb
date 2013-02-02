require 'sinatra'
require 'sinatra/activerecord'
require 'yaml'

enable :sessions
set :database, "mysql2://root@localhost/coderprep"

class User < ActiveRecord::Base
end

get '/' do
	"#{User.all}"
	#erb :index
end
