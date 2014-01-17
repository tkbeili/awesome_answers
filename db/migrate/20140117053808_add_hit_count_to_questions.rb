class AddHitCountToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :hit_count, :integer, default: 0
  end
end
