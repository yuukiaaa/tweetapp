class CreateArticleImages < ActiveRecord::Migration[5.2]
  def change
    create_table :article_images do |t|
      t.references :article
      t.string :alt_text, null: false, default: ""
      t.integer :position
      t.timestamps
    end
  end
end
