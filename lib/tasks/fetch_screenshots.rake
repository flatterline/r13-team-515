desc ""
task :fetch_screenshots => :environment do
  PublicationSection.all.each do |section|
    if Rails.env.development?
      img  = IMGKit.new(section.url).to_png
      file = Tempfile.new(["template_#{section.id}", 'png'], 'tmp', :encoding => 'ascii-8bit')
      file.write(img)
      file.flush
      section.screenshots.create image: file
      file.unlink

    else
      # img  = IMGKit.new(section.url).to_png # will only work in dev as without using xvfb on server, some sites can't render
      %x[xvfb-run --server-args="-screen 0, 1280x1024x24" bin/wkhtmltoimage-amd64 --use-xserver #{section.url} temp.png]
      img  = File.open('temp.png')
      file = Tempfile.new(["template_#{section.id}", 'png'], 'tmp', :encoding => 'ascii-8bit')
      file.write(img.read)
      file.flush
      section.screenshots.create image: file
      file.unlink
    end
  end

  FileUtils.rm('temp.png') if Rails.env.production?
end