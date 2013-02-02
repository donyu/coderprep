require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'
require 'yaml'

enable :sessions
set :database, "mysql2://root@localhost/coderprep"

class User < ActiveRecord::Base
	attr_accessible :id, :username, :pass_salt, :pass_hash
	def exists(username)
		if User.where(:username => username).first
			return true
		else
			return false
		end
	end
end

helpers do
	def login?
		if session[:username].nil?
			return false
		else
			return true
		end
	end

	def username
		return session[:username]
	end
end

get '/' do
	erb :index
end

get '/signup' do
	erb :signup
end

post '/signup' do
	new_id = User.all.last.id + 1
	salt = BCrypt::Engine.generate_salt
	hash = BCrypt::Engine.hash_secret(params[:password], salt)
	User.create(id: new_id, username: params[:username], pass_salt: salt, pass_hash: hash)
	session[:username] = params[:username]
	redirect '/'
end

post '/login' do
	if User.exists(params[:username])
		user = User.where(:username => params[:username])
		if user.pass_hash == BCrypt::Engine.hash_secret(params[:password], user.pass_salt)
			session[:username] = params[:username]
			redirect '/'
		end
	end
end

get '/logout' do
	session[:username] = nil
	redirect '/'
end
