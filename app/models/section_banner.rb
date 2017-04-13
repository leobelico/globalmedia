class SectionBanner < ApplicationRecord
	belongs_to :sectionable, polymorphic: true, optional: true
	belongs_to :banner, optional: true
end
