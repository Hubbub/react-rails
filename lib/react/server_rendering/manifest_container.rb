module React
  module ServerRendering
    # Get asset content by reading the compiled file from disk using a Sprockets::Manifest.
    #
    # This is good for Rails production when assets are compiled to public/assets
    # but sometimes, they're compiled to other directories (or other servers)
    class ManifestContainer
      def initialize
        @manifest = ::Rails.application.assets_manifest
      end

      def find_asset(logical_path)
        puts "Manifest assets #{@manifest.assets.inspect}"
        asset_path = @manifest.assets[logical_path] || raise("No compiled asset for #{logical_path}, was it precompiled? #{@manifest.assets.inspect}")
        asset_full_path = ::Rails.root.join("public", @manifest.dir, asset_path)
        File.read(asset_full_path)
      end
    end
  end
end
