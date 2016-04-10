require 'rspec'
require 'rack/test'
require 'capybara/rspec'
require './skybill'
require 'webmock/rspec'
require 'fake_statement'

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.before(:each) do
    WebMock.enable!
    stub_request(:any, /safe-plains-5453.herokuapp.com/).to_rack(FakeStatement)
  end
end


RSpec.describe "Display Sky Bill", type: :feature do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before { Capybara.app = app }

  context "main page" do
    before { visit '/' }

    let(:body) { last_response.body }
    it 'shows statement statement dates' do
      expect(page).to have_content("Generated: 2015-01-11")
      expect(page).to have_content("Billing period from: 2015-01-26")
      expect(page).to have_content("To: 2015-02-25")
      expect(page).to have_content("Bill payment due: 2015-01-25")
    end

    it 'provides navigation to sections' do
      expect(page).to have_link("Package")
      expect(page).to have_link("Call Charges")
      expect(page).to have_link("Sky Store")
    end

    it 'shows statement and section totals' do
      expect(page).to have_content "Statement Total: £136.03"
      expect(page).to have_content "Package Total: £71.4"
      expect(page).to have_content "Call Charges Total: £59.64"
      expect(page).to have_content "Sky Store Total: £24.97"
    end

  end
end
