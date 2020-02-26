class AddEmailToHumen < ActiveRecord::Migration[5.1]
  def change
    add_column :humen, :email, :string
  end
end
