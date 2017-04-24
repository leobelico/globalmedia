class Investigation < ApplicationRecord
	validates :name, presence: true
	has_many :articles, dependent: :nullify
  before_save :to_slug
	
	def to_param
    	slug
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

      # Revisar slugs repetidos 

      self.slug =  ret
    end
end
