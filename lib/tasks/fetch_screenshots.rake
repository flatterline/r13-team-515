desc "Grab screenshots of every available section."
task :fetch_screenshots => :environment do
  timestamp = Time.now.to_i
  puts '*' * 50
  puts Time.zone.now.strftime("%m/%d/%Y %I:%m %p")
  puts '*' * 50
  PublicationSection.all.each do |section|
    printf " - #{section.url}"
    Screenshooter.new(section, timestamp).grab
    puts ' => OK'
  end
end