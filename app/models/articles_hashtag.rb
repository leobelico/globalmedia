class ArticlesHashtag < ApplicationRecord
	belongs_to :hashtag
	belongs_to :article
end
