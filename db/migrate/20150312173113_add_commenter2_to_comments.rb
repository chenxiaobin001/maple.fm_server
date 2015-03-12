class AddCommenter2ToComments < ActiveRecord::Migration
  def change
    add_column :comments, :commenter2, :string
  end
end
