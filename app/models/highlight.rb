class Highlight < ApplicationRecord
	# validates :article_id, uniqueness: true
	belongs_to :article, optional: true, touch: true
end
