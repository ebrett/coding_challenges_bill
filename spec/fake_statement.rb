require 'sinatra/base'

class FakeStatement < Sinatra::Base
  get '/bill.json' do
    respond_with('bill.json')
  end

  def respond_with(response_file)
    file_name = File.dirname(__FILE__) + '/' + response_file
    if File.exist?(file_name)
      content_type :json
      status 200
      File.open(file_name, 'rb').read
    else
      content_type :json
      status 404
    end
  end
end
