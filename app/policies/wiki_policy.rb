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

    class Scope < Scope
      
      def resolve
        wikis = []
        if user.role == 'admin' 
          wikis = scope.all # if the user is an admin, show them all the wikis
        elsif user.role == 'premium'
          all_wikis = scope.all
          all_wikis.each do |wiki|
            if wiki.public? || wiki.user == user || wiki.users.include?(user)
              wikis << wiki # if the user is premium, only show them public wikis, or the private wikis they created, or private wikis they are a collaborator on
            end
          end
        else # this is the standard user
          all_wikis = scope.all
          wikis = []
          all_wikis.each do |wiki|
            if wiki.public? || wiki.users.include?(user)
              wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
            end
          end 
        end
        wikis # return the wikis array we've built up
      end
    end
end