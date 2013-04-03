class GameSerializer < ActiveModel::Serializer
  attributes :current_player, :dice

  def dice
    object.dice.to_s
  end

  has_many :points
end
