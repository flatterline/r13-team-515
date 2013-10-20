collection @screenshots
attributes :timestamp
node(:publication_id) { |screenshot| screenshot.publication_section.publication.id }
node(:image_url) { |screenshot| screenshot.image.url }
node(:section_name) { |screenshot| screenshot.publication_section.name }
