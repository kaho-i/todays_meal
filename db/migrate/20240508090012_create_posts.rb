class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false #投稿ユーザー
      t.integer :shop_id, null: false #店舗名
      t.text :body, null: false #本文
      t.timestamps
    end
  end
end
