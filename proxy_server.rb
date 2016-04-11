require 'sinatra'
require 'net/http'

class ProxyServer < Sinatra::Application
  get '/bill.json' do
    content_type :json
    status 200
    Net::HTTP.get('safe-plains-5453.herokuapp.com', '/bill.json')
  end
end
