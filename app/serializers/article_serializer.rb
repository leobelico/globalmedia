class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :name, :short_description, :image, :video_url, :exclusive
  belongs_to :section, each_serializer: SectionSerializer 
end
