# migrations/001_create_table_users.rb
class CreateTableUsers < Sequel::Migration
  def up
    create_table :users do
      primary_key :id
      column :name, :text
      column :created_at, :timestamp
      column :updated_at, :timestamp
    end
  end

  def down
    drop_table :users
  end
end
