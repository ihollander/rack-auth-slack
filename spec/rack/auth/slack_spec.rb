RSpec.describe Rack::Auth::Slack do

  it "has a version number" do
    expect(Rack::Auth::Slack::VERSION).not_to be nil
  end

  context 'middleware' do
    let(:test_app) { lambda {|env| [200, {'Content-Type' => 'text/plain'}, ['OK']]} }
    let(:app) { Rack::Auth::Slack.new(test_app, '') }

    before(:each) do
      @body = "test"
      @timestamp = Time.now.to_i.to_s
      @signature = signature
    end

    def timestamp
      Time.now.to_i.to_s
    end

    def signature
      app.generate_hash(@timestamp, @body)
    end

    it "returns 401 to unauthorized requests" do
      post '/'
      expect(last_response.status).to eq 401
    end

    it "returns 200 to authorized requests" do
      header 'x-slack-signature', @signature
      header 'x-slack-request-timestamp', @timestamp
      post '/', @body
      expect(last_response.status).to eq 200
    end
  end

end
