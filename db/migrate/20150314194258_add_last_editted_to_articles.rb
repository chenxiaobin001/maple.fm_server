class AddLastEdittedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :lastEditted, :timestamp
  end
end
