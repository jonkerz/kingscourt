require 'csv'

namespace :kings do
  # Sets ids, so delete all cards first.
  desc "Import cards exported from Django/Postgres"
  task import_csv: :environment do
    cvs_from_django.each do |row|
      card = row.to_hash
      new_card = Card.new id: card["id"],
        name: card["name"],
        text: card["text"],
        expansion_id: card["expansion_id"],
        card_type_id: card["card_type_id"],
        randomizable: card["randomizable"]

      new_card.save!
      puts "Imported #{new_card.name} (#{new_card.id})"
    end
  end

  desc 'Import card attributes'
  task import_card_attributes: :environment do
    unique_card_attributes = Set.new

    cvs_from_django.each do |row|
      card = row.to_hash
      ids = card["extra_field"].split(",") # "24,214"
      names = ids.map do |id|
        EXTRA_FIELD[id.to_i]
      end
      unique_card_attributes.merge names
    end

    unique_card_attributes.each do |attribute|
      CardAttribute.create! name: attribute
    end
  end

  desc 'Import card attribute links'
  task import_card_attribute_links: :environment do
    cvs_from_django.each do |row|
      card = row.to_hash
      ids = card["extra_field"].split(",") # "24,214"
      names = ids.map do |id|
        EXTRA_FIELD[id.to_i]
      end

      db_card = Card.find(card["id"])
      names.each do |name|
        attribute = CardAttribute.find_by(name: name)
        db_card.card_attributes << attribute
      end
    end
  end

  desc 'Import cost/cost in coins'
  task import_costs: :environment do
    cvs_from_django.each do |row|
      card = row.to_hash
      Card.find(card["id"]).update_attributes cost: card["cost_txt"],
        cost_in_coins: card["cost_in_coins"].to_i
    end
  end

  private
    # Header:
    # id,name,cost_in_coins,cost_txt,text,expansion_id,card_type_id,randomizable,"extra_field"
    #
    # Examples:
    # 1,Cellar,2,2,"text",0,0,t,"0,200,211"
    # 178,Overgrown Estate,1,1,"text",7,21,f,"24,214"
    def cvs_from_django
      csv_file = File.read "lib/tasks/dominion_cards_from_django.csv"
      headers = ["id", "name", "cost_in_coins", "cost_txt",
        "text", "expansion_id", "card_type_id",
        "randomizable","extra_field"]

      CSV.parse(csv_file, headers: headers)
    end

    # From dominiondb/dominion/card_choices.py
    EXTRA_FIELD = {
      # 1-99: basic types/variations
      0 => 'isAction',
      1 => 'isActionAttack',
      2 => 'isActionAttackKnight',
      3 => 'isActionAttackLooter',
      4 => 'isActionAttackPrize',
      5 => 'isActionAttackVictoryKnight',
      6 => 'isActionDuration',
      7 => 'isActionLooter',
      8 => 'isActionPrize',
      9 => 'isActionReaction',
      10 => 'isActionRuins',
      11 => 'isActionShelter',
      12 => 'isActionVictory',
      13 => 'isAttack',
      14 => 'isCurse',
      15 => 'isDuration',
      16 => 'isLooter',
      17 => 'isPrize',
      18 => 'isReaction',
      19 => 'isReactionShelter',
      20 => 'isTreasure',
      21 => 'isTreasurePrize',
      22 => 'isTreasureReaction',
      23 => 'isTreasureVictory',
      24 => 'isVictory',
      25 => 'isVictoryReaction',
      26 => 'isVictoryShelter',

      # 100-199: non-basic, e.g. Trasher
      100 => 'isTrasher',
      101 => 'isGainer',
      102 => 'isRemodeler',
      103 => 'isCurser',
      104 => 'isInteractive',
      105 => 'isNonAttackInteractive',
      106 => 'isDeckInspector',
      107 => 'isTerminal',
      108 => 'isMultipleChoice',
      109 => 'isVeryAnnoying',

      # 200-299: givesX..
      200 => 'givesActions',
      201 => 'givesOneAction',
      202 => 'givesTwoActions',
      203 => 'givesCoins',
      204 => 'givesOneCoin',
      205 => 'givesTwoCoins',
      206 => 'givesThreeOrMoreCoins',
      207 => 'givesBuys',
      208 => 'givesOneBuy',
      209 => 'givesTwoBuys',
      210 => 'givesCards',
      211 => 'givesOneCard',
      212 => 'givesTwoCards',
      213 => 'givesThreeOrMoreCards',
      214 => 'givesVictoryPoins',

      # 300-: other...
      300 => 'costsPotion',
      301 => 'eventOnTrash',
    }
end
