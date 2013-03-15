class GameSerializer < ActiveModel::Serializer
  attributes :current_player
  has_many :points
end
