class CreateCardTypes < ActiveRecord::Migration[5.0]
  def up
    create_table :card_types do |t|
      t.string :name
      t.timestamps
    end

    card_types.each do |card_type, id|
      CardType.create! name: card_type
    end

    # Previously the first id was 0
    Card.find_each do |card|
      card.card_type_id += 1
      card.save!
    end
  end

  def down
    drop_table :card_types

    Card.find_each do |card|
      card.card_type_id -= 1
      card.save!
    end
  end
end

# From dominiondb/dominion/card_choices.py, but starting from 1.
def card_types
  [
    ['Action', 1],
    ['Action-Reaction', 2],
    ['Action-Attack', 3],
    ['Victory', 4],
    ['Action-Victory', 5],
    ['Treasure-Victory', 6],
    ['Action-Duration', 7],
    ['Treasure', 8],
    ['Action-Prize', 9],
    ['Treasure-Prize', 10],
    ['Action-Attack-Prize', 11],
    ['Treasure-Reaction', 12],
    ['Victory-Reaction', 13],
    ['Action-Looter', 14],
    ['Action-Attack-Looter', 15],
    ['Curse', 16],
    ['Action-Attack-Knight', 17],
    ['Action-Attack-Victory-Knight', 18],
    ['Action-Ruins', 19],
    ['Reaction-Shelter', 20],
    ['Action-Shelter', 21],
    ['Victory-Shelter', 22],
  ]
end
