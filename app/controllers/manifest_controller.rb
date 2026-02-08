class ManifestController < ApplicationController
  def show
    render json: {
      name: "Foxy Lady Ultimate",
      short_name: "Foxy Lady",
      start_url: "/",
      display: "standalone",
      background_color: "#212529",
      theme_color: "#212529",
      icons: [
        {
          src: helpers.asset_path("icon.png"),
          sizes: "512x512",
          type: "image/png"
        },
        {
          src: helpers.asset_path("icon.svg"),
          sizes: "any",
          type: "image/svg+xml"
        }
      ]
    }
  end
end
