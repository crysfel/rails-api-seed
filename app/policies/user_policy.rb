
class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def update?
    user.admin? or user.id === record.id
  end

  def show?
    user.admin? or user.id === record.id
  end

  def create?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
