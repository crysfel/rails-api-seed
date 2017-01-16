class AssetSerializer < ActiveModel::Serializer
  attributes :id, :file, :description
  attribute :file_file_name, key: :name

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
