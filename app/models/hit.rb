class Hit < ApplicationRecord
	belongs_to :article, optional: true
end
