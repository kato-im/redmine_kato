class AddPerProjectFormatSettingsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :kato_uses_markdown, :boolean, :default => true, :null => false
  end
end
