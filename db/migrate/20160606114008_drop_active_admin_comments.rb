class DropActiveAdminComments < ActiveRecord::Migration[5.0]
  def change
    drop_table :active_admin_comments
  end
end
