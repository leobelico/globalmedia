class ArticleRelationship < ApplicationRecord
	belongs_to :article, optional: true
	belongs_to :articable, polymorphic: true, optional: true
end
