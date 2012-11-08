# Use the app.rb file to load Ruby code, modify or extend the models, or
# do whatever else you fancy when the theme is loaded.


class Site
  # Uncomment the Rack::Static line below if your theme has assets
  # (i.e images or JavaScript).
  #
  # Put your assets in themes/<%= @name %>/public/<%= @name %>.
  #
  # use Rack::Static, :urls => ["/<%= @name %>"], :root => "themes/<%= @name %>/public"

  helpers do
    # Add new helpers here.
    def latest_release
      Hw::ContentFile.articles_by_tag("releases").first
    end
    def releases
      Hw::ContentFile.articles_by_tag("releases")
    end
    
    def bundles
      Hw::ContentFile.find_all.select { |item| item.flagged_as?('bundle')}
    end
  end
  
  

end
module Hw
  
  class ContentFile
    def template
      fallback = metadata('bundle') ? 'plugin_page' : 'page'
      (metadata('template') || fallback).to_sym
    end
  
    def self.plugins_by_bundle(bundle)
      Hw::ContentFile.find_all.select { |item| item.bundle_name == bundle and not item.flagged_as?('bundle')}
    end

    def bundle_name
      metadata('Bundle')
    end
       
    def bundle
      Hw::ContentFile.find_by_path("/plugins/bundles/#{bundle_name}")
    end
    
    def bundle_plugins
      Hw::ContentFile.plugins_by_bundle(bundle_name)
    end
  end

end

module Nesta
  Page = Hw::ContentFile
end