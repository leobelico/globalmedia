class Section < ApplicationRecord
	has_many :articles, as: :articable
	before_create :to_slug
	has_many :section_highlights
	has_many :section_banners, as: :seleccionable
	has_many :hits_objectives
	validates :name, presence: true
	# has_many :related_sections
	has_many :related_sections, class_name: 'RelatedSection', :foreign_key => 'section_reference'

	def to_param
  	slug
	end

  	def total_hits_in_current_month
    	Hit.joins("INNER JOIN articles ON articles.id = hits.article_id WHERE articles.articable_id = #{self.id} AND hits.created_at >= '#{Time.now.beginning_of_month}' AND hits.created_at <= '#{Time.now.end_of_month}'").sum(:number)
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
	       ret.gsub! /\s*[^A-Za-z0-9ÁáÉéÍíÓóÚú\.\-]\s*/, '-'  

	       #convert double underscores to single
	       ret.gsub! /_+/,"_"

	       #strip off leading/trailing underscore
	       ret.gsub! /\A[_\.]+|[_\.]+\z/,""

	      self.slug = ret
	    end
end
