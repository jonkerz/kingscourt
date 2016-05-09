class AddCardAttributesToCard < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :card_attributes, :string
  end
end
