class ArticlesHashtag < ApplicationRecord
	belongs_to :hashtag
	# belongs_to :article
	belongs_to :article, touch: true
end
