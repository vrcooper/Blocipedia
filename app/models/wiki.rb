class Wiki < ActiveRecord::Base
  belongs_to :user

 scope :visible_to, -> (user) { user && ((user.role == 'premium') || (user.role == 'admin')) ? all : where("private = ? OR private IS NULL",  false)}


  def public?
    self.private != true
  end

end
