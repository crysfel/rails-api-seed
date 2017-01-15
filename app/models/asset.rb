class Asset < ApplicationRecord
  has_attached_file :file

  # Relationships
  belongs_to :assetable, polymorphic: true
end
