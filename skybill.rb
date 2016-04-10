require 'sinatra'
require 'net/http'
require 'json'
require 'tilt/haml'

get '/' do
  json = Net::HTTP.get('safe-plains-5453.herokuapp.com', '/bill.json')
  @bill = JSON.parse(json, object_class: OpenStruct)
  haml :show
end
