class Asset < ApplicationRecord
  has_attached_file :file,
    styles: { :thumb => "300x300#", :small  => "400x400>", :medium  => "800x800>", :large  => "1200x1200>" },
    path: "/assets/:user_id/:style/:image_name.:extension"

  # Validations
  validates_attachment :file, presence: true
  validates_attachment :file, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif", "video/mp4", "application/x-mpegURL", "video/MP2T", "video/quicktime"] }

  # Relationships
  belongs_to :user
  # belongs_to :assetable, polymorphic: true
end
