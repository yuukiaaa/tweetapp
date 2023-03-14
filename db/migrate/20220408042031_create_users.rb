class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :description
      t.boolean :administrator, null: false, default: false # 管理者フラグ
      t.string :password_digest

      t.timestamps
    end
  end
end
