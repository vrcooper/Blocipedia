class WikiPolicy < ApplicationPolicy

  def index?
    true
  end
    
  def show?
  record.private? || (user.present? && user.role == 'admin') || (user.present? && user.role == 'premium') 
  end
end