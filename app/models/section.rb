class Section < ApplicationRecord
	has_many :articles, as: :articable
end
