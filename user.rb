require 'action'
require 'rack/cache'
# class User
class User
  def call(env)
    env['HTTP_ACCEPT'] = 'application/json'
    req = Rack::Request.new(env)
    result = req.get? ? User.users(req.params) : 'Only GET request allowed'
    User.new.response(req, result)
  end

  def response(req, result)
    case req.path_info
    when /users/
      [200, User.header_types, [result]]
    when '/'
      [200, User.header_types, ['Goto /users to see all users']]
    else
      [404, User.header_types, ['Invalid URL']]
    end
  end

  def self.header_types
    # { 'Content-Type' => 'application/json', 'ETag' => Digest::MD5.new.to_s }
    { 'Content-Type' => 'application/json' }
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

        path = Rack::Directory.new('').root
        use Rack::Cache, metastore: "file:#{path}/cache/rack/meta",
                         entitystore: "file:#{path}/cache/rack/body", verbose: true
                         # allow_reload: false, allow_revalidate: false
        use Rack::ETag
        use Rack::ConditionalGet
        
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
