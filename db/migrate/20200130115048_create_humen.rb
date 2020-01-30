class CreateHumen < ActiveRecord::Migration[5.1]
  def change
    create_table :humen do |t|
      t.string :name
      t.float :weight

      t.timestamps
    end
  end
end
