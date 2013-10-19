desc ""
task :fetch_screenshots => :environment do
  PublicationSection.all.each do |section|
    img  = IMGKit.new(section.url).to_png
    file = Tempfile.new(["template_#{section.id}", 'png'], 'tmp',
                         :encoding => 'ascii-8bit')
    file.write(img)
    file.flush
    section.screenshots.create image: file
    file.unlink
  end
end