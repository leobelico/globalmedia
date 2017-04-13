class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

    before_save :set_full_name

    def superadmin?
    		role == "Superadmin"
  		end

  		def admin?
    		role == "Admin"
  		end
    private
    	def set_full_name
    		self.full_name = self.first_name + " " + self.last_name
    	end
end
