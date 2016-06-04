angular.module "KingsCourt"

.filter "expansionToString", ->
  ExpansionEnum =
    1:  "Dominion"
    2:  "Intrigue"
    3:  "Seaside"
    4:  "Alchemy"
    5:  "Prosperity"
    6:  "Cornucopia"
    7:  "Hinterlands"
    8:  "Dark Ages"
    9:  "Guilds"
    10: "Promo"
    11: "Adventures"

  (exp) -> ExpansionEnum[exp]
