# Pin npm packages by running ./bin/importmap

pin "application"

# https://github.com/rails/importmap-rails/issues/65
pin "bootstrap" # @5.3.3
pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.8

pin "chart.js" # @4.4.8
pin "@kurkle/color", to: "@kurkle--color.js" # @0.3.4

pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/turbo-rails", to: "turbo.min.js"

pin_all_from "app/javascript/controllers", under: "controllers"
