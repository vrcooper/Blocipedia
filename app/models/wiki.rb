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


# users_id | wiki_id
# 1        | 2
# 2        | 2
# 3        | 1

# wiki_2.users => user_1, user_2
# user_ids = Collaborator.where(wiki_id: wiki.id).map(&:user_id)
# User.where(id: user_ids)