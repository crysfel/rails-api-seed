class CreateAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets do |t|
      t.integer :user_id
      t.references :assetable, polymorphic: true, index: true
      t.string  :name
      t.string  :content_type
      t.string  :size
      t.string  :path

      t.timestamps
    end

    add_foreign_key :assets, :users
  end
end
