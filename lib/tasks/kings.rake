require 'csv'

namespace :kings do
  # Sets ids, so delete all cards first.
  desc "Import cards exported from Django/Postgres"
  task import_csv: :environment do
    # Header:
    # id,name,cost_in_coins,cost_txt,text,expansion_id,card_type_id,randomizable,"extra_field"
    #
    # Examples:
    # 1,Cellar,2,2,"text",0,0,t,"0,200,211"
    # 178,Overgrown Estate,1,1,"text",7,21,f,"24,214"

    csv_file = File.read "lib/tasks/dominion_cards_from_django.csv"
    headers = ["id", "name", "cost_in_coins", "cost_txt",
      "text", "expansion_id", "card_type_id",
      "randomizable","extra_field"]

    CSV.parse(csv_file, headers: headers).each do |row|
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
end
