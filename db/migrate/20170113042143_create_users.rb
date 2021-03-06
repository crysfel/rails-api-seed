class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email,              null: false
      t.string :password_digest,    null: false
      t.string   :confirmation_token
      t.boolean  :admin,            null: false, default: false
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at

      t.timestamps
    end
  end
end
