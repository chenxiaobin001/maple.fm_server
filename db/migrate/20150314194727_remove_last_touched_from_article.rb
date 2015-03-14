class RemoveLastTouchedFromArticle < ActiveRecord::Migration
  def change
    remove_column :articles, :lastTouched, :timestamp
  end
end
