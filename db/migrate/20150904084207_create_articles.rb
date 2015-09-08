class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.string :title
      t.text :text
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
