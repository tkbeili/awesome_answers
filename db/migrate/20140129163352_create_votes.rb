class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :is_up
      t.references :user, index: true
      t.references :question, index: true

      t.timestamps
    end
  end
end
