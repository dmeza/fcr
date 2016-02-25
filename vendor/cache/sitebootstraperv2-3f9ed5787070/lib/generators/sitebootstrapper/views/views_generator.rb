module Sitebootstrapper
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      source_root File.expand_path('../../../../..', __FILE__)
      desc "Copies all Sitebootstrapper views to your application."

      def copy_views
        directory "app/views/.", "app/views/"
        copy_file "config/initializers/devise.rb", "config/initializers/devise.rb"
      end

    end
  end
end