module Wheel
  module Formatter
    NON_SUCCESS_COLORS = {
      "FAILED" => :red,
      "ERROR" => :yellow,
      "PENDING" => :cyan
    }

    @@formatter = nil
    def self.formatter; @@formatter; end
    def self.formatter=(formatter); @@formatter = formatter; end
    
    def self.pluralize(str, ct)
      [
        "#{ct}",
        "#{str}#{ct == 1 ? '' : 's'}"
      ].join(" ")
    end
  end
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "formatters"))

require 'silent_formatter'
require 'simple_formatter'
require 'simple_color_formatter'
require 'spec_formatter'
require 'spec_color_formatter'