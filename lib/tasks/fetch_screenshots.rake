desc "Grab screenshots of every available section."
task :fetch_screenshots => :environment do
  timestamp = Time.now.to_i

  PublicationSection.all.each do |section|
    Screenshooter.grab section, timestamp
  end
end