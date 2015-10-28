class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

 scope :visible_to, -> (user) { user && ((user.role == 'premium') || (user.role == 'admin')) ? all : where("private = ? OR private IS NULL",  false)}


  def public?
    self.private != true
  end

  def collaborator_for(user)
    collaborators.where(user: user).first
  end

end
