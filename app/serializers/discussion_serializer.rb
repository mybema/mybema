class DiscussionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :slug, :class_name
end