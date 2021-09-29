class AddTokenUniqueIndexToUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :token, unique: true
  end
end
