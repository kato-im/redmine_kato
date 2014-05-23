class AddKatoUrlToProject < ActiveRecord::Migration
  def change
    add_column :projects, :kato_url, :string, :default => "", :null => false
  end
end
