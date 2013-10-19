class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :name, :logo_url
      t.timestamps
    end

    create_table :publication_sections do |t|
      t.belongs_to :publication, index: true
      t.string :name, :url
    end
  end
end
