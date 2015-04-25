$LOAD_PATH.unshift File.expand_path('lib', __FILE__)

require 'sinatra'
require 'omniauth-withings'

enable :sessions

use OmniAuth::Builder do
  provider :withings, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
end

get '/' do
  <<-HTML
    <a href='/auth/withings'>Sing in with Withings</a>
  HTML
end

get '/auth/withings/callback' do
  request.env['omniauth.auth'].info.to_hash.inspect
end
