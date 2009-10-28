module Wheel
  class ExampleGroup
    attr_reader :name, :parent_name, :examples, :example_groups
    def initialize(name, parent_name, &block)
      @name, @parent_name = name, parent_name
      @examples, @example_groups = [], []
      instance_eval(&block)
    end
    
    def describe(name, &block)
      self.example_groups << ExampleGroup.new(name, self.full_name, &block)
    end
    
    def it(name, &block)
      self.examples << Example.new(name, self.full_name, &block)
    end
    
    def full_name
      ([parent_name, name].join(" ")).strip
    end
  end
end