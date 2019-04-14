# routes.rb
route('/show') do
  status 200
  User.users(params)
end

route('/goodbye') do
  status 500
  'Goodbye!'
end
