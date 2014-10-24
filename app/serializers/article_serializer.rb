class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :class_name
end