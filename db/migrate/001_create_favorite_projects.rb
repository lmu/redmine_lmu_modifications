class CreateFavoriteProjects < ActiveRecord::Migration
  def self.up
    create_table :favorite_projects do |t|
      t.column :project_id, :integer
      t.column :user_id, :integer
    end
  end

  def self.down
    drop_table :favorite_projects
  end
end
