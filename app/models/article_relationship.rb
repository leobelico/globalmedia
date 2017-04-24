class ArticleRelationship < ApplicationRecord
	belongs_to :article, optional: true
	belongs_to :relationship, optional: true
end
