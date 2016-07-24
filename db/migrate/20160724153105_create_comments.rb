class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.string :user
      t.references :event
      
      t.timestamps
    end
  end
end
