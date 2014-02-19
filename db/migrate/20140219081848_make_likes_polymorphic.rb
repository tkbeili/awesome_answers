class MakeLikesPolymorphic < ActiveRecord::Migration
  def change
    rename_column :likes, :question_id, :likeable_id
    add_column :likes, :likeable_type, :string

    add_index :likes, [:likeable_id, :likeable_type]
    Like.update_all(likeable_type: "question")
  end
end