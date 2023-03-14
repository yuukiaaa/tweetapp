class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :user, null: false # 外部キー、user_idカラムが作成される
      t.references :article, null: false # 外部キー、article_idが作成される

      t.timestamps
    end
  end
end
