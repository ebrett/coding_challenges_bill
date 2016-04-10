require 'rspec'
require 'rack/test'
require './skybill'

RSpec.describe "Display Sky Bill", type: :request do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before { get '/' }
  it "reads JSON to display a customer's sky bill" do
    expect(last_response).to be_ok
  end

  it 'shows statement due date' do
    expect(last_response.body).to include("Due: Jan 25, 2015")
  end
end
