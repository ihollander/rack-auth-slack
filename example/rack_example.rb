# Add to Gemfile:
# gem 'rack'
# gem 'rack-auth-slack'

require 'rack'
require 'rack/auth/slack'

# Sample application
class Application

  def call(env)
    resp = Rack::Response.new
      
    if Time.now.hour > 12
      resp.write "Good Afternoon!"
    else
      resp.write "Good Morning!"
    end

    resp.finish
  end

end

# Apply Rack::Auth::Slack middleware
use Rack::Auth::Slack, 'SLACK_SECRET'
run Application.new