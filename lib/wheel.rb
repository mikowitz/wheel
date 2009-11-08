$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "wheel"))

begin
  require 'rubygems'
  require 'mikowitz-color'
rescue
  module Color
    def self.method_missing(method, *args)
      if args[1] == false
        print args.first
      else
        puts args.first
      end
    end
  end
end

require 'custom_matchers'
require 'errors'
require 'example'
require 'example_group'
require 'example_suite'
require 'formatter'
require 'kernel_ext'
require 'matcher'
require 'test_runner'

module Wheel
  module Wheel
    def describe(name, &block)
      same_group_name = ExampleSuite.example_groups.find{|eg| eg.name == name}
      if same_group_name
        same_group_name.instance_eval(&block)
      else
        ExampleSuite.example_groups << ExampleGroup.new(name, nil, &block)
      end
    end
  end
end