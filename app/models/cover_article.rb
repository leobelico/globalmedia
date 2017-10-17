class CoverArticle < ApplicationRecord
	validates :article_id, uniqueness: true
end
