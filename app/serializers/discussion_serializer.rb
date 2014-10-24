class DiscussionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :class_name
end