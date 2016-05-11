class CreateExpansions < ActiveRecord::Migration[5.0]
  def up
    create_table :expansions do |t|
      t.string :name
      t.timestamps
    end

    expansions.each do |expansion, id|
      Expansion.create! name: expansion
    end

    # Previously the first id was 0
    Card.find_each do |card|
      card.expansion_id += 1
      card.save!
    end
  end

  def down
    drop_table :expansions

    Card.find_each do |card|
      card.expansion_id -= 1
      card.save!
    end
  end
end

def expansions
  [
    ['Dominion', 1],
    ['Intrigue', 2],
    ['Seaside', 3],
    ['Alchemy', 4],
    ['Prosperity', 5],
    ['Cornucopia', 6],
    ['Hinterlands', 7],
    ['Dark Ages', 8],
    ['Guilds', 9],
  ]
end
