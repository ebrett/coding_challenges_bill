require 'sinatra'
require 'net/http'
require 'json'
require 'tilt/haml'

get '/' do
  fetch_bill
  haml :show
end

get '/package' do
  fetch_bill
  haml :package
end

get '/call-charges' do
  fetch_bill
  haml :'call-charges'
end

get '/sky-store' do
  fetch_bill
  haml :'sky-store'
end

def store_title(title_code)
  {'rentals' => 'Rentals', 'buyAndKeep' => 'Buy and Keep'}[title_code]
end

def sub_type(subscription)
  {'tv' => 'TV', 'talk' => 'Sky Talk', 'broadband' => 'Sky Broadband'}[subscription.type]
end

def format_cost(cost)
  "£" + ("%.2f" % cost)
end

def format_date(date_str)
  Date.parse(date_str).strftime('%d %b %Y')
end

def format_period(period)
  format_date(period.from) + ' to ' + format_date(period.to)
end

private

def fetch_bill
  return if @bill
  json = Net::HTTP.get('safe-plains-5453.herokuapp.com', '/bill.json')
  @bill = JSON.parse(json, object_class: OpenStruct)
end
