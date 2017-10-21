class SectionSerializer < ActiveModel::Serializer
  attributes :id, :name, :color
  # has_many :articles, each_serializer: ArticleSerializer 
end
