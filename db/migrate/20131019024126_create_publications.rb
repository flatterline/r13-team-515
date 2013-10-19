class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :name, :logo_url, :slug
      t.timestamps
    end

    add_index :publications, :slug, unique: true

    create_table :publication_sections do |t|
      t.belongs_to :publication, index: true
      t.string :name, :url
    end

    add_index :publication_sections, [:publication_id, :name], unique: true
  end
end
