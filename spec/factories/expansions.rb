FactoryBot.define do
  factory :expansion do
    initialize_with { Expansion.find_or_create_by(name: name) }

    name { "Dominion" }
    id { 1 }
  end
end
