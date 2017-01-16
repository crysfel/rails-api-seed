
class AssetPolicy < ApplicationPolicy

  def index?
    # Any one can list images
    true
  end

  def update?
    # Admin or owners can update the image
    user.admin? or user.id === record.user_id
  end

  def show?
    # Anyone can see assets
    true
  end

  def create?
    # Anyone can upload assets
    true
  end

  def destroy?
    # Admin or owners can remove images
    user.admin? or user.id === record.user_id
  end
end
