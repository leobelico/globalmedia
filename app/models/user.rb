class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

    before_save :set_full_name
    has_many :articles, dependent: :nullify
    has_many :hits, dependent: :delete_all
    has_many :hits_objectives, dependent: :delete_all
    validates :email, :first_name, :last_name, :role, presence: true
    def superadmin?
    		role == "Superadmin"
  		end

  		def admin?
    		role == "Admin"
  		end
    def total_hits_in_current_month
      Hit.joins("INNER JOIN articles ON articles.id = hits.article_id WHERE articles.articable_id = #{self.id} AND hits.created_at >= '#{Time.now.beginning_of_month}' AND hits.created_at <= '#{Time.now.end_of_month}'").sum(:number)
    end
    private
    	def set_full_name
    		self.full_name = self.first_name + " " + self.last_name
    	end
end
