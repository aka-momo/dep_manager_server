class CreateSystemDependencies < ActiveRecord::Migration[5.0]
  def change
    create_table :system_dependencies do |t|
      t.string :name
      t.integer :package_id
      t.integer :operating_system, default: 0

      t.timestamps
    end
  end
end
