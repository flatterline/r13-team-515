collection @screenshots
attributes :timestamp, :publication_section_id
node(:publication_id){ |screenshot| screenshot.publication_section.publication.id }
node(:image_url){ |screenshot| screenshot.image.url }