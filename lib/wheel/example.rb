module Wheel
  class Example
    include CustomMatchers
    attr_reader :name, :parent_name, :backtrace, :block
    attr_reader :parent_group
    
    def initialize(name, parent_name, parent_group, &block)
      @backtrace = caller(0)
      @parent_group = parent_group
      @name, @parent_name = name, parent_name, (block || lambda { raise PendingExpectation.new(name, "Not Yet Implemented")})
      if block.nil? or block.empty?
        @block = lambda { raise PendingExpectation.new(name, "Not Yet Implemented")}
      else
        @block = block
      end
    end
    
    def run_example
      parent_group.instance_eval(&@block)
    end
    
    def full_name
      ([parent_name, name].join(" ")).strip
    end
  end
end