class AddUserToKingdoms < ActiveRecord::Migration[5.0]
  def change
    add_column :kingdoms, :user_id, :integer
  end
end
