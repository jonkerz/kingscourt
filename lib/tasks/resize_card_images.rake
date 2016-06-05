namespace :kings do
  desc "Resize full-resolution card assets to medium/small."
  task :resize_card_images do
    # Assets are not included in this repo.
    FULL_CARDS_PATH = "../dominion-assets/full_resolution_cards"
    CARDS_DIR = "public/cards"
    SMALL_CARDS_DIR = "public/cards/small"

    puts %x(
      if ! [ -d "#{FULL_CARDS_PATH}" ]; then
        echo "Cannot find #{FULL_CARDS_PATH}"
      fi

      if [ -d "#{CARDS_DIR}" ]; then
        echo "This will remove #{pwd}/#{CARDS_DIR}"
      fi
    )

    puts "Continue? y=yes"
    abort unless STDIN.gets.chomp == "y"

    puts "removing #{CARDS_DIR}..."
    `rm -rf #{CARDS_DIR}`

    # width:height ratio is ~ golden ratio ~ 1.6
    # Exclamation mark in "290x464!" means "ignore original ratio".

    # Large cards
    puts "copying full-sized cards to #{CARDS_DIR}..."
    `cp -rf #{FULL_CARDS_PATH} #{CARDS_DIR}`
    puts "mogrifying large cards..."
    `mogrify -resize 290x464! -quality 75 -strip #{CARDS_DIR}/*.jpg`

    # Small cards
    puts "copying full-sized cards to #{SMALL_CARDS_DIR}..."
    `cp -rf #{FULL_CARDS_PATH} #{SMALL_CARDS_DIR}`
    puts "mogrifying small cards..."
    `mogrify -resize 140x224! -quality 85 -strip #{SMALL_CARDS_DIR}/*.jpg`

    puts "Done."
  end
end
