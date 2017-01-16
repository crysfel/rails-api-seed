class AssetSerializer < ActiveModel::Serializer
  attributes :id, :description
  attribute :file_file_name, key: :name
  attribute :file_file_size, key: :size
  attribute :file_content_type, key: :contentType
  attribute :file, key: :url

  def file
    return {
      thumb: object.file.url(:thumb),
      small: object.file.url(:small),
      medium: object.file.url(:medium),
      large: object.file.url(:large),
      original: object.file.url(:original)
    }
  end
end
