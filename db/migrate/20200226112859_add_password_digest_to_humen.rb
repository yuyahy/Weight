class AddPasswordDigestToHumen < ActiveRecord::Migration[5.1]
  def change
    add_column :humen, :password_digest, :string
  end
end
