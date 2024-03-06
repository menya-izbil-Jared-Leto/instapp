class CreateFollowers < ActiveRecord::Migration[7.1]
  def change
    create_table :followers do |t|
      t.references :follower, foreign_key: { to_table: :accounts }
      t.references :following, foreign_key: { to_table: :accounts }
      t.timestamps
    end
  end
end

