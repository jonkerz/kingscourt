class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :exception, if: Proc.new { |c| c.request.format != 'application/json' }
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  serialization_scope :view_context

  def index
  end

  def get_cards # TODO
    randomizers = Card.where(randomizable: true)
    cards = ActiveModel::Serializer::CollectionSerializer.new(randomizers, each_serializer: CardSerializer)
    render json: cards
  end

  def get_non_randomizers # TODO
    non_randomizers = Card.where(randomizable: false)
    cards = ActiveModel::Serializer::CollectionSerializer.new(non_randomizers, each_serializer: CardSerializer)
    render json: cards
  end

  def get_all_expansion_attributes # TODO
    json = {"0": ["givesBuys", "isTerminal", "isVictory", "givesCards", "givesOneBuy", "givesTwoActions", "isReaction", "givesTwoCards", "givesCoins", "isRemodeler", "givesThreeOrMoreCards", "givesActions", "isTrasher", "givesOneCard", "isNonAttackInteractive", "isAttack", "isActionReaction", "givesThreeOrMoreCoins", "givesVictoryPoins", "isGainer", "isActionAttack", "isCurser", "isDeckInspector", "givesOneAction", "isInteractive", "givesTwoCoins", "givesOneCoin"], "1": ["givesBuys", "isTreasure", "isTerminal", "isActionVictory", "isVictory", "givesCards", "givesOneBuy", "givesTwoActions", "isTreasureVictory", "isReaction", "givesTwoCards", "givesCoins", "isRemodeler", "givesThreeOrMoreCards", "givesActions", "isTrasher", "givesOneCard", "isNonAttackInteractive", "isAttack", "isActionReaction", "givesThreeOrMoreCoins", "givesVictoryPoins", "isGainer", "isActionAttack", "isCurser", "isDeckInspector", "givesOneAction", "isInteractive", "givesTwoCoins", "givesOneCoin"], "2": ["givesOneCard", "givesBuys", "givesTwoCards", "isActionDuration", "isActionVictory", "givesVictoryPoins", "isTerminal", "givesCoins", "isVictory", "isActionAttack", "givesCards", "givesTwoCoins", "isAttack", "givesActions", "givesOneCoin", "isTrasher"], "3": ["givesBuys", "isTreasure", "isTerminal", "isVictory", "givesCards", "givesOneBuy", "givesTwoActions", "givesTwoCards", "givesCoins", "givesActions", "isTrasher", "givesOneCard", "isNonAttackInteractive", "isAttack", "givesVictoryPoins", "isGainer", "isActionAttack", "isCurser", "isDeckInspector", "givesOneAction", "isInteractive", "givesOneCoin", "costsPotion"], "4": ["givesBuys", "isTreasure", "isTerminal", "isVictory", "givesCards", "givesOneBuy", "givesTwoActions", "isReaction", "givesTwoCards", "givesCoins", "givesThreeOrMoreCards", "givesActions", "isTrasher", "givesOneCard", "isNonAttackInteractive", "isAttack", "isActionReaction", "givesThreeOrMoreCoins", "givesVictoryPoins", "isGainer", "isActionAttack", "isCurser", "givesOneAction", "isInteractive", "givesTwoCoins", "givesOneCoin"], "5": ["givesBuys", "isTerminal", "isVictory", "givesCards", "isReaction", "givesTwoCards", "givesCoins", "givesThreeOrMoreCards", "isActionPrize", "givesActions", "isTrasher", "givesOneCard", "isTreasure", "isAttack", "isTreasurePrize", "isActionReaction", "givesThreeOrMoreCoins", "givesVictoryPoins", "isActionAttack", "isPrize", "isActionAttackPrize", "givesTwoCoins", "givesOneCoin"], "6": ["givesOneCard", "isTreasure", "givesBuys", "isActionReaction", "givesThreeOrMoreCoins", "isTerminal", "isReaction", "givesTwoCards", "isTreasureReaction", "givesCoins", "givesThreeOrMoreCards", "isVictory", "givesVictoryPoins", "givesCards", "givesTwoCoins", "isAttack", "isVictoryReaction", "givesActions", "isActionAttack", "givesOneCoin", "isTrasher"], "7": ["isTreasure", "isActionVictory", "isAttack", "isActionReaction", "isReaction", "givesVictoryPoins", "isActionAttackLooter", "isVictory", "isActionAttack", "isActionLooter"], "8": ["isActionAttack", "isAttack", "isTreasure"], "9": ["givesOneCard", "isTreasure", "givesBuys", "isTerminal", "givesTwoCards", "givesCoins", "isActionAttackLooter", "givesThreeOrMoreCards", "givesCards", "givesTwoCoins", "givesActions", "isTrasher"], "shared": ["isAction"]}
    render json: json
  end

  private
    def default_serializer_options
      { root: false }
    end
end
