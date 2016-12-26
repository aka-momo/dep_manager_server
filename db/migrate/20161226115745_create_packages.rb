class CreatePackages < ActiveRecord::Migration[5.0]
  def change
    create_table :packages do |t|
      t.string :name
      t.integer :language, default: 0
      t.string :source_url

      t.timestamps
    end
  end
end
