class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

    before_save :set_full_name
    has_many :articles, dependent: :nullify
    has_many :hits, dependent: :delete_all
    validates :email, :first_name, :last_name, :role, presence: true
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
