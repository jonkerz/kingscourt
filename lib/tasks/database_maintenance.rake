namespace :kings do
  namespace :check do

    desc "all"
    task all: :environment do
      puts "Checking general card types...".blue
      Rake::Task["kings:check:general_card_types"].invoke

      puts "Checking implied card types...".blue
      Rake::Task["kings:check:implied_card_types"].invoke

      puts "Checking terminal/givesActions...".blue
      Rake::Task["kings:check:terminals"].invoke

      puts "Checking card image files...".blue
      Rake::Task["kings:check:card_image_files"].invoke
    end

    desc "eg that Action-Attack cards have 'isAction' and 'isAttack'"
    task general_card_types: :environment do
      Card.find_each do |card|
        should_have_types = card.card_type.name.split("-")
          .map { |type| "is#{type}"}

        should_have_types.each do |type|
          unless card.card_attributes.pluck(:name).include? type
            puts "#{card.name} is missing #{type}".red
            # card.card_attributes << CardAttribute[type] # Uncomment to add.
          end
        end
      end
    end

    desc "eg that 'givesOneAction' cards also are 'givesActions' cards"
    task implied_card_types: :environment do
      def check_card_type card_type, implied:
        CardAttribute[card_type].cards.each do |card|
          unless card.card_attributes.include? CardAttribute[implied]
            puts "plz add #{implied} to #{card.name}".red
          end
        end
      end

      { "givesOneAction" => "givesActions",
        "givesTwoActions" => "givesActions",

        "givesOneCard" => "givesCards",
        "givesTwoCards" => "givesCards",

        "givesOneCoin" => "givesCoins",
        "givesTwoCoins" => "givesCoins"
      }.each do |card_type, implied_card_type|
        check_card_type card_type, implied: implied_card_type
      end
    end

    desc "cannot be both terminal and give actions, and must be either"
    task terminals: :environment do
      CardAttribute["isAction"].cards.each do |card|
        attributes = card.card_attributes
        gives_actions = attributes.include? CardAttribute["givesActions"]
        terminal = attributes.include? CardAttribute["terminal"]

        if gives_actions && terminal
          puts "#{card.name} gives actions and is terminal".red
        end

        unless gives_actions || terminal
          puts "#{card.name} gives no actions and is not terminal".red
        end
      end
    end

    desc "that each card has an image"
    task card_image_files: :environment do
      Card.find_each do |card|
        image_path = "public/cards/#{card.image}"
        unless File.file? image_path
          puts "#{card.name}: could not find #{image_path}".red
        end

        small_image_path = "public/cards/small/#{card.image}"
        unless File.file? small_image_path
          puts "#{card.name}: could not find #{image_path}".red
        end
      end
    end

  end
end
