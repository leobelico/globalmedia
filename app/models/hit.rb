class Hit < ApplicationRecord
	belongs_to :article, optional: true

	def self.search(params)
	  # join("created_at < ?", "%#{search[:end_date]}%")
	  # where("created_at > ?", "%#{search[:initial_date]}%") 
	  # where("created_at < ?", "%#{search[:end_date]}%")
      joins("INNER JOIN articles ON articles.id = hits.article_id WHERE articles.articable_id = #{params[:section_id]} AND hits.created_at >= '#{params[:initial_date]}' AND hits.created_at <= '#{params[:end_date]}'")	
	end
end
