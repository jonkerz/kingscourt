class RenameCostToCostInTextInCardModel < ActiveRecord::Migration[5.0]
  def change
    rename_column :cards, :cost, :cost_in_text
  end
end
