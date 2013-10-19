IMGKit.configure do |config|
  if Rails.env.production?
    config.wkhtmltoimage = Rails.root.join('bin/wkhtmltoimage-amd64').to_s
  else
    config.wkhtmltoimage = Rails.root.join('bin/wkhtmltoimage').to_s
  end
  config.default_format = :png
end