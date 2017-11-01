class LatestArticle < ApplicationRecord
	validates :article_id, uniqueness: true
	
end
