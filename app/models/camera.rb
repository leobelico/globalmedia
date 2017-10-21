class Camera < ApplicationRecord
	has_many :section_banners, as: :seleccionable
end
