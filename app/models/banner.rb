class Banner < ApplicationRecord
	has_many :section_banners, dependent: :delete_all
	validates :name, :client, :large_image, :small_image, :url, presence: true
end
