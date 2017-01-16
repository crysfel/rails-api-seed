###
# Interpolations for custom paths on S3
###

Paperclip.interpolates :user_id do |attachment, style|
  attachment.instance.user_id
end

Paperclip.interpolates :image_name do |attachment, style|
  "#{attachment.instance.id.to_s}-:basename"
end
