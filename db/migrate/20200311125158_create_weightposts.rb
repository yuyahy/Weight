class CreateWeightposts < ActiveRecord::Migration[5.1]
  def change
    create_table :weightposts do |t|
      t.float :weight
      t.references :human, foreign_key: true

      t.timestamps
    end
    add_index :weightposts, [:human_id, :created_at]
  end
end
