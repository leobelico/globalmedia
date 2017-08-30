class Device < ApplicationRecord
	validates_uniqueness_of :token
end
