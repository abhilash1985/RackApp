require 'action'
require 'rack/cache'
# class User
class User
  def call(env)
    req = Rack::Request.new(env)
    result = req.get? ? User.users(req.params) : 'Only GET request allowed'
    case req.path_info
    when /users/
      [200, { 'Content-Type' => 'application/json' }, [result]]
    when '/'
      [200, { 'Content-Type' => 'application/json' }, ['Goto /users to see all users']]
    else
      [404, { 'Content-Type' => 'application/json' }, ['Invalid URL']]
    end
  end

  def self.users(params)
    users = DB[:users]
    if params['name'].nil?
      users.as_hash(:name).to_json
    else
      users.where(name: params['name']).as_hash(:name).to_json
    end
  end

  def self.app
    @app ||= begin
      Rack::Builder.new do
        use Rack::Auth::Basic, 'Authentication Required' do |username, password|
          username == 'user' && password == 'password'
        end
        use Rack::Cache
        use Rack::ConditionalGet
        use Rack::ETag

        map '/' do
          run User.new
        end
      end
    end
  end
end

def route(pattern, &block)
  User.app.map(pattern) do
    run Action.new(&block)
  end
end
