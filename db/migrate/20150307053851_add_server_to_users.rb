class AddServerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :server, :integer
  end
end
