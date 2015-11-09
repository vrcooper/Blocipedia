class CollaboratorPolicy < ApplicationPolicy
  def create?
    return false if user.blank?
    return (user.role == 'admin' || user.role == 'premium') && (record.wiki.user == user)
  end 
end