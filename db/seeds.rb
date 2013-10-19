## Publications

puts
puts "Loading publications:"

YAML.load(open(Rails.root.join('config', 'publications.yml')))['publications'].each do |name, values|
  puts " - #{values['name']}"

  publication = Publication.where(name: values['name']).first || Publication.create(name: values['name'])
  publication.logo_url = values['logo_url']

  values['sections'].each do |section_name, section_values|
    if section_values['url'].present?
      publication.publication_sections.where(name: section_name).first || publication.publication_sections.create(name: section_name, url: section_values['url'])
    end
  end

  publication.save!
end

## Screenshots

puts
puts "Grabbing initial screenshots..."

require Rails.root.join('lib', 'screenshooter.rb')

timestamp = Time.now.to_i

PublicationSection.where(name: :home).each do |section|
  printf " - #{section.url}"
  Screenshooter.new(section, timestamp).grab
  puts ' => OK'
end