class Highlight < ApplicationRecord
	validates :order, :article_id, uniqueness: true
	belongs_to :article, optional: true
end
