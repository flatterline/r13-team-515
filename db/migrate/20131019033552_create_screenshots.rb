class CreateScreenshots < ActiveRecord::Migration
  def change
    create_table :screenshots do |t|
      t.belongs_to :publication_section, index: true
      t.integer :timestamp, default: 0
      t.string :image_uid, :image_name

      t.timestamps
    end

    add_index :screenshots, [:timestamp, :publication_section_id], unique: true
  end
end
