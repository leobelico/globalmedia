class Banner < ApplicationRecord
	has_many :section_banners, dependent: :delete_all
end
