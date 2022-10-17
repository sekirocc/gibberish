class CreateMurmurs < ActiveRecord::Migration[7.0]
  def change
    create_table :murmurs do |t|
      t.text :content
      t.string :location
      t.integer :visibility
      t.boolean :deleted

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
