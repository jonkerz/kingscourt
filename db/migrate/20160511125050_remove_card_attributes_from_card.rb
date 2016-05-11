class RemoveCardAttributesFromCard < ActiveRecord::Migration[5.0]
  def up
    remove_column :cards, :card_attributes
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
