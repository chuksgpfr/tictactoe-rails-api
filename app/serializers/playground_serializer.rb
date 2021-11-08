class PlaygroundSerializer < ActiveModel::Serializer
  attributes :id, :moves, :username, :roomName, :moves, :people, :next, :status, :scores, :wonby
end
