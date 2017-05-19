class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :scheduled_time, :short_description, :plain_text, :image, :video_url, :exclusive
  belongs_to :section, each_serializer: SectionSerializer 
  belongs_to :author, each_serializer: AuthorSerializer  
end
