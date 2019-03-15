RSpec.describe Rack::Auth::Slack do

  it "has a version number" do
    expect(Rack::Auth::Slack::VERSION).not_to be nil
  end

  context 'middleware' do
    let(:test_app) { lambda {|env| [200, {'Content-Type' => 'text/plain'}, ['OK']]} }
    let(:app) { Rack::Auth::Slack.new(test_app, '') }

    it "returns 401 to unauthorized requests" do
      post '/'
      expect(last_response.status).to eq 401
    end
  end

end
