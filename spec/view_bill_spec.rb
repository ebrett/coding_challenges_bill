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

    it 'shows statement statement dates' do
      expect(page).to have_content("Statement date: 11 Jan 2015")
      expect(page).to have_content("For period: 26 Jan 2015 to 25 Feb 2015")
      expect(page).to have_content("Payment due: 25 Jan 2015")
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

  context "package details" do
    before { visit '/' }

    it 'can be navigated to from main page' do
      click_link 'Package'
      expect(page).to have_content("Subscriptions")
    end
  end
end
