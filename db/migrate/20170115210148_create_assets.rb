class CreateAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets do |t|
      t.integer :user_id
      t.references :assetable, polymorphic: true, index: true, null: true
      t.string  :description
      t.attachment :file

      t.timestamps
    end

    add_foreign_key :assets, :users
  end
end
