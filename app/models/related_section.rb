class RelatedSection < ApplicationRecord
	belongs_to :section, optional: true
	belongs_to :section_reference, class_name: 'Section', optional: true
	
end
