class HitObjective < ApplicationRecord
	belongs_to :section, optional: true
	belongs_to :author, optional: true
end
