require "uglifier"

helpers do

end

page "/templates/*", :layout => false

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :haml, { :ugly => true, :format => :html5 }

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript, :compressor => ::Uglifier.new(define: { DEVMODE: false  })

end

after_configuration do
  if defined?(RailsAssets)
    RailsAssets.load_paths.each do |path|
      sprockets.append_path path
    end
  end
end

activate :s3_sync do |s3_sync|
  s3_sync.bucket  = 'wandering-labs-availability-2'
  s3_sync.region  = 'us-east-1'
  s3_sync.verbose = true
  s3_sync.delete  = false
end
