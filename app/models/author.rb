class Author < ApplicationRecord
	has_many :articles, dependent: :nullify
	has_many :hit_objectives, dependent: :delete_all
	validates :name, :logo, presence: true

  	def total_hits_in_current_month
    	Hit.joins("INNER JOIN articles ON articles.id = hits.article_id WHERE articles.articable_id = #{self.id} AND hits.created_at >= '#{Time.now.beginning_of_month}' AND hits.created_at <= '#{Time.now.end_of_month}'").sum(:number)
  	end
end
