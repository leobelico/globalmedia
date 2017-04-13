class Section < ApplicationRecord
	has_many :articles, as: :articable
  	before_save :to_slug
  	has_many :section_highlights, dependent: :delete_all
	

	def to_param
    	slug
  	end

  	private
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
	       ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '_'  

	       #convert double underscores to single
	       ret.gsub! /_+/,"_"

	       #strip off leading/trailing underscore
	       ret.gsub! /\A[_\.]+|[_\.]+\z/,""

	      self.slug = ret
	    end
end
