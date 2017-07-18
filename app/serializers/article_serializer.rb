class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :scheduled_time, :short_description, :raw_note, :image, :video_url, :exclusive
  belongs_to :section, each_serializer: SectionSerializer 
  belongs_to :author, each_serializer: AuthorSerializer  
  has_many :hashtags, each_serializer: HashtagSerializer
  has_many :images, serializer: ImageSerializer
end
