require 'sinatra'
require 'data_mapper'
require 'json'

ENV['AUTH_TOKEN']         ||= 'foobar'
ENV['PBKDF2_ITERATIONS']  ||= '64000'
ENV['PBKDF2_ALGORITHM']   ||= 'sha256'
ENV['DB_PATH']            ||= 'postgres://discourse:discourse@localhost/discourse_development'
ENV['FREE_AUTH']          ||= 'deny'

require './pbkdf2'
require './data'
require './helpers'

before do
  content_type 'application/json'
  protected!
end

get '/users/:username' do
  user = User.first(username: params[:username])
  user.to_json
end

post '/users/:username/auth' do
  user = User.first(username: params[:username])
  password_hash = hash_password(params[:password], user.salt)

  if password_hash == user.password_hash
    user.to_json
  else
    status 418
    { error: 'Auth failed' }.to_json
  end
end
