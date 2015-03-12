class AddId1ToComments < ActiveRecord::Migration
  def change
    add_column :comments, :id1, :integer
  end
end
