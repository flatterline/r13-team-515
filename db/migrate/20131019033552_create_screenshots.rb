class CreateScreenshots < ActiveRecord::Migration
  def change
    create_table :screenshots do |t|
      t.belongs_to :publication_section
      t.string :image_uid
      t.string :image_name

      t.timestamps
    end
  end
end
