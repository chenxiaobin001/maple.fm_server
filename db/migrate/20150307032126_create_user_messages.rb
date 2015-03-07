class CreateUserMessages < ActiveRecord::Migration
  def change
    create_table :user_messages do |t|
      t.integer :user_id
      t.integer :message_id

      t.timestamps null: false
    end
    execute "ALTER TABLE 'user_messages' ADD PRIMARY KEY (user_id,message_id);"
  end
end
