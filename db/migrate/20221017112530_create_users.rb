class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :nickname
      t.date :birthday
      t.integer :gender, default: 0
      t.integer :status, default: 0
      t.string :username
      t.string :password_hash
      t.string :email
      t.boolean :email_confirmed, default: false
      t.string :mobile
      t.string :wechat
      t.string :weibo
      t.string :avatar_url
      t.datetime :member_since

      t.timestamps
    end
  end
end
