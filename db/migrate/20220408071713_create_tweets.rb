class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.string :tweet

      t.timestamps
    end
  end
end
