# db_config.rb
db_config_file = File.join(File.dirname(__FILE__), 'config', 'database.yml')
if File.exist?(db_config_file)
  config = YAML.load(File.read(db_config_file))
  DB = Sequel.connect(config)
  Sequel.extension :migration
end

# If there is a database connection, run all the migrations
Sequel::Migrator.run(DB, File.join(File.dirname(__FILE__), 'migrations')) if DB

users = DB[:users] # Create a dataset

# Populate the table
if users.count == 0
  users.insert(name: 'abc')
  users.insert(name: 'def')
  users.insert(name: 'ghi')
  users.insert(name: 'jkl')
  users.insert(name: 'mno')
end

# Print out the number of records
puts "User count: #{users.count}"

# # Connect Sqlite DB
# DB2 = Sequel.sqlite # memory database, requires sqlite3

# DB2.create_table :users do
#   primary_key :id
#   String :name
# end
# users2 = DB2[:users] # Create a dataset
