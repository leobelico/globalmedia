class Author < ApplicationRecord
	has_many :articles, dependent: :nullify
	validates :name, :logo, presence: true
end
