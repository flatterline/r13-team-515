class IMGKit
  def initialize(url_file_or_html, options = {})
    @source = Source.new(url_file_or_html)

    @stylesheets = []

    @options = IMGKit.configuration.default_options.merge(options)
    @options.merge! find_options_in_meta(url_file_or_html) unless source.url?

    # raise NoExecutableError.new unless File.exists?(IMGKit.configuration.wkhtmltoimage)
  end

  def executable
    default = IMGKit.configuration.wkhtmltoimage
    if Rails.env.development?
      return default if default !~ /^\// # its not a path, so nothing we can do
      if File.exist?(default)
        default
      else
        default.split('/').last
      end
    else
      default
    end
  end
end

IMGKit.configure do |config|
  if Rails.env.production?
    config.default_options = {"use-xserver" => true}
    config.wkhtmltoimage = "xvfb-run --server-args=\"-screen 0, 1280x1024x24\" #{Rails.root.join('bin/wkhtmltoimage-amd64').to_s}"
  else
    config.wkhtmltoimage = Rails.root.join('bin/wkhtmltoimage').to_s
  end
  config.default_format = :png
end