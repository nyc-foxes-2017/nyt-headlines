require 'open-uri'
require 'Net/HTTP'
require 'JSON'
require 'pry'
require_relative 'view'
require_relative 'controller'

# ARTICLES: ["response"]["docs"]
# USE: ["headline"]["main"] && ["lead_paragraph"]

controller = Controller.new

controller.run
