module Wheel
  class Example
    include CustomMatchers
    attr_reader :name, :parent_name, :backtrace, :block
    
    def initialize(name, parent_name, &block)
      @backtrace = caller(0)
      @name, @parent_name = name, parent_name, (block || lambda { raise PendingExpectation.new(name, "Not Yet Implemented")})
      if block.nil? or block.empty?
        @block = lambda { raise PendingExpectation.new(name, "Not Yet Implemented")}
      else
        @block = block
      end
    end
    
    def run_example(example_group)
      example_group.instance_eval(&@block)
    end
    
    def full_name
      ([parent_name, name].join(" ")).strip
    end
  end
end