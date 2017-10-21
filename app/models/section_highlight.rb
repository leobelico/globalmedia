class SectionHighlight < ApplicationRecord
	belongs_to :section, optional: true
	belongs_to :article, optional: true
end
