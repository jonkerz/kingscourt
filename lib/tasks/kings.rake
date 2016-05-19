# temporary rake tasks

require "csv"

namespace :kings do
  task remove_orphaned_kingdom_cards: :environment do
    KingdomCard.find_each do |kingdom_card|
      unless kingdom_card.kingdom
        puts "Deleted #{kingdom_card.id}, kingdom: #{kingdom_card.kingdom_id}"
        kingdom_card.delete
      end
    end
  end

  desc "rake -T"
  task unique_general_card_types: :environment do
    puts unique_general_card_types
  end

  desc "rake -T"
  task add_general_card_types_to_cards: :environment do
    Card.find_each do |card|
      types_from_attribute = card.card_type.name.split("-").map { |type| "is#{type}"}
      types_from_attribute.each do |type|
        if card.card_attributes.pluck(:name).include? type
          puts "not adding #{type} to #{card.name}"
        else
          puts "adding missing #{type} to #{card.name}".green
          card.card_attributes << CardAttribute.find_or_create_by(name: type)
        end
      end
    end
  end

  desc "rake -T"
  task check_card_types: :environment do
    check_card_types "givesOneAction", "givesActions"
    check_card_types "givesTwoActions", "givesActions"

    check_card_types "givesOneCard", "givesCards"
    check_card_types "givesTwoCards", "givesCards"
  end
end

def check_card_types card_type, implied_card_type
  puts "\n\nchecking that #{card_type}-cards also have #{implied_card_type}".blue
  CardAttribute[card_type].cards.each do |card|
    unless card.card_attributes.include? CardAttribute[implied_card_type]
      puts "plz add #{implied_card_type} to #{card.name}".red
    else
      puts "is ok (has #{implied_card_type})".green
    end
  end
end

def unique_general_card_types
  CardType.pluck(:name).join("-").split("-").uniq
end
