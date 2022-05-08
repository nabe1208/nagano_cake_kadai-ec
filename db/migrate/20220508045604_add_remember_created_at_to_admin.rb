class AddRememberCreatedAtToAdmin < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :remember_created_at, :datetime
  end
end
