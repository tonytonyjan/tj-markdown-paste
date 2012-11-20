class AddIsTitleShownToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :show_title, :boolean
  end
end
