require 'rspec'
require 'rack/test'
require './skybill'

RSpec.describe "Display Sky Bill", type: :request do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "reads JSON to display a customer's sky bill" do
    get '/'
    expect(last_response).to be_ok
  end

end
