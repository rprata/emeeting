class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.integer :is_admin
      t.string :password_digest

      t.timestamps
    end
  end
end
