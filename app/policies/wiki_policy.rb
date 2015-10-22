class WikiPolicy < ApplicationPolicy

  def index?
    true
  end
    
  def show?
    return record.public? if user.blank?
    # | record.public? | user.role == 'admin' | user.role == 'premium' | result |
    # | true           | false                | false                  | true   |
    record.public? || (user.role == "admin") || (user.role == "premium")

    # (record.private? && (user.admin? || user.premium?)) || record.public?
    # record.private? || (user.present? && user.role == 'admin') || (user.present? && user.role == 'premium') 
  end
end