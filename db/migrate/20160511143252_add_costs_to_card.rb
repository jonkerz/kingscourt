class AddCostsToCard < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :cost_in_coins, :integer
    add_column :cards, :cost, :string
  end
end
