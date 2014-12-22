class AddPerProjectFormatSettingsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :kato_uses_markdown, :boolean, :default => false, :null => false
  end
end
