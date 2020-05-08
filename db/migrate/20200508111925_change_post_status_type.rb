class ChangePostStatusType < ActiveRecord::Migration[5.0]
  def change
    change_column :posts, :status, :integer
  end
end
