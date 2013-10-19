desc "Grab screenshots of every available section."
task :fetch_screenshots => :environment do
  timestamp = Time.now.to_i

  PublicationSection.all.each do |section|
    printf " - #{section.url}"
    Screenshooter.new(section, timestamp).grab
    puts ' => OK'
  end
end