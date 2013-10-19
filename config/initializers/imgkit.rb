class IMGKit
  def executable
    default = IMGKit.configuration.wkhtmltoimage
    if Rails.env.development?
      return default if default !~ /^\// # its not a path, so nothing we can do
      if File.exist?(default)
        default
      else
        default.split('/').last
      end
    end
  end
end

IMGKit.configure do |config|
  if Rails.env.production?
    config.default_options = {'use-xserver': true}
    config.wkhtmltoimage = "xvfb-run --server-args=\"-screen 0, 1280x1024x24\" #{Rails.root.join('bin/wkhtmltoimage-amd64').to_s}"
  else
    config.wkhtmltoimage = Rails.root.join('bin/wkhtmltoimage').to_s
  end
  config.default_format = :png
end