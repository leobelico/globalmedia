class ArticlesHashtag < ApplicationRecord
	belongs_to :hashtag, touch: true
	# belongs_to :article
	belongs_to :article, touch: true
end
