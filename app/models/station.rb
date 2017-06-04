class Station < ApplicationRecord
	validates :name, :image, :stream_url, presence: true
	has_many :timetables, dependent: :delete_all
  has_many :section_banners, as: :seleccionable

	accepts_nested_attributes_for :timetables, reject_if: proc { |attributes| attributes['name'].blank? }, :allow_destroy => true
  has_many :article_relationships, dependent: :nullify, as: :articable
  has_many :podcasts, dependent: :delete_all
	before_create :to_slug
	def to_param
    	slug
  end
	def to_slug
      #strip the string
      ret = self.name.strip
      ret.gsub!('Ñ','N')
      ret.gsub!('ñ','n')
      #blow away apostrophes

      ret.gsub! /[.]/,""
      # @ --> at, and & --> and
      ret.gsub! /\s*@\s*/, " en "
      ret.gsub! /\s*&\s*/, " y "

      #replace all non alphanumeric, underscore or periods with underscore
       ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, ''  

       #convert double underscores to single
       ret.gsub! /_+/,"-"

       #strip off leading/trailing underscore
       ret.gsub! /\A[_\.]+|[_\.]+\z/,""

      # Revisar slugs repetidos 

      self.slug = ret
    end
end
