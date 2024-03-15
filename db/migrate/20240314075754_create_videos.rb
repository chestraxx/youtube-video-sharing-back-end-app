class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :video_id
      t.string :video_url
      t.string :title
      t.text :description
      t.string :thumbnail
      t.string :embed_url
      t.string :embed_code
      t.integer :views_total
      t.integer :likes_total
      t.integer :user_id

      t.timestamps
    end
  end
end
