require 'sinatra'
require 'net/http'
require 'json'

get '/' do
  json = Net::HTTP.get('safe-plains-5453.herokuapp.com', '/bill.json')
  puts JSON.parse(json)
end
