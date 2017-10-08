class Image < ApplicationRecord
	belongs_to :article, touch: true 
end
