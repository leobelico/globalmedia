class Article < ApplicationRecord
  belongs_to :articable, polymorphic: true, optional: true
  belongs_to :keyword, optional: true
  has_many :section_highlights, dependent: :delete_all
	attr_accessor :hashtags_names
  has_and_belongs_to_many :hashtags, uniq: true
  before_save :associate_tags, :to_slug
  belongs_to :user, optional: true

  def to_param
    slug
  end

  private
    def associate_tags
      if hashtags_names
        hashtags_names.split(" ").each do |name|
          self.hashtags << Hashtag.find_or_create_by( name: name )
        end
      end
    end

    def to_slug
      #strip the string
      ret = self.name.strip

      #blow away apostrophes
      ret.gsub! /['`]/,""

      ret.gsub! /[.]/,""
      # @ --> at, and & --> and
      ret.gsub! /\s*@\s*/, " en "
      ret.gsub! /\s*&\s*/, " y "

      #replace all non alphanumeric, underscore or periods with underscore
       ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'  

       #convert double underscores to single
       ret.gsub! /_+/,"-"

       #strip off leading/trailing underscore
       ret.gsub! /\A[_\.]+|[_\.]+\z/,""

      self.slug = ret + self.id
    end
end
