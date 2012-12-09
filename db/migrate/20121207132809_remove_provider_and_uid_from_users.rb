class RemoveProviderAndUidFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :provider
    remove_column :users, :uid
  end
end
