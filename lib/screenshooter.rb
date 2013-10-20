unless defined?(Screenshooter)
  class Screenshooter

    def initialize section, timestamp=Time.now.to_i
      @section   = section
      @timestamp = timestamp
    end

    def grab
      get_png
      encode
      create_screenshot
      cleanup
    end

  private

    def cleanup
      File.unlink @file
      FileUtils.rm(temp_image) if File.exists?(temp_image)
    end

    def create_screenshot
      @section.screenshots.create! image: @file, timestamp: @timestamp
    end

    def encode
      @file = Tempfile.new(["template_#{@section.id}", '.png'], 'tmp', encoding: 'ascii-8bit')
      @file.write(@image)
      @file.flush
    end

    def get_png
      if Rails.env.development?
        # IMGKit.new(@section.url).to_png
        %x[bin/wkhtmltoimage --javascript-delay 5000 --load-error-handling ignore #{@section.url} #{temp_image} > /dev/null 2>&1 ]
      else
        %x[xvfb-run --server-args="-screen 0, 1280x1024x24" bin/wkhtmltoimage-amd64 --use-xserver #{@section.url} #{temp_image}]
        image_optim = ImageOptim.new(:pngout => false)
        image_optim.optimize_image!(temp_image)
      end
      @image = File.open(temp_image).read
    end

    def temp_image
      Rails.root.join('tmp', "temp-#{@section.id}-#{@timestamp}.png")
    end
  end
end
