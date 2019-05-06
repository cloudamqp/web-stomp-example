require 'sinatra/base'
require 'haml'
require 'json'
require 'uri'

class App < Sinatra::Base
  get '/' do
    u = URI.parse ENV['CLOUDAMQP_URL'] || 'amqp://guest:guest@localhost'
    @ws_stomp_uri = {
      protocol: u.scheme.sub('amqp', 'ws'),
      host: u.host,
      vhost: u.path[1..-1] || '/',
      user: "#{u.user}-web",
      password: 'web',
      port: u.scheme.end_with?('s') ? 443 : 15674,
    }.to_json
    haml :index
  end
end

