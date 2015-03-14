class AddLastTouchedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :lastTouched, :timestamp
  end
end
