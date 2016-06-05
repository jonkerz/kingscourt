# Naming convention: Use camelCase. All "general types" (eg action, attacks,
# reactions) are named like this: "isAction", "isAttack", "isReaction". All
# other types ("trasher", givesTwoCoins") are just descriptive names.
#
# All cards should have their general types added as `CardAttribute`s, so
# Thief, being an Action-Attack should have both "isAction" and "isAttack".
# Bridge Troll (an Action-Attack-Duration) should have the same attributes,
# plus "isDuration". There are no "combination types" such as
# "Attack-Duration".
#
# The verbatim type that is written on the card is saved in another model
# (`CardType`), and is thus not included here. It's not possible to randomize
# cards by exact type, there just seems to be no reason for wanting a random
# card that is, eg, exactly an Action-Attack-Duration. However, randomizing
# Action + Attack + Duration is *almost* the same thing.
#
# Manually making sure that all cards have their general types as attributes is
# OK (or rather, use `rake kings:check:general_card_types`), because there's
# not too many of them, and trying to accomplish the same via code or
# validations is overkill.
#
# Bonus snippets:
# Unique general card types: `CardType.pluck(:name).join("-").split("-").uniq`
# All existing attributes: `CardAttribute.pluck(:name)`

class CardAttribute < ApplicationRecord
  include ByNameOrId

  has_many :card_attribute_links
  has_many :cards, through: :card_attribute_links, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
