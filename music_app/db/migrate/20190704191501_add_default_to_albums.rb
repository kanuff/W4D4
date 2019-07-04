class AddDefaultToAlbums < ActiveRecord::Migration[5.2]
  def change
    change_column :albums, :studio, :boolean, :default => false
  end
end
