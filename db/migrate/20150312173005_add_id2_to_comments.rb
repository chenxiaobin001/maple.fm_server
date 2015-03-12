class AddId2ToComments < ActiveRecord::Migration
  def change
    add_column :comments, :id2, :integer
  end
end
