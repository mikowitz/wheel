module Wheel
  class Matcher
    attr_accessor :expected, :name, :messages, :match_block, :actual
    def initialize(name, &block)
      @name, @match_block = name, block
      MATCHERS[name.to_sym] = self
    end
    
    def matches?(actual, pos=true)
      result = check_expectation(actual, expected)
      error_message(pos) unless !!result == pos
    end
    
    def check_expectation(actual, expected)
      instance_exec(actual, expected, &@match_block)
    end
    
    def error_message(pos)
      message = @messages[pos]
      raise FailedExpectation.new(@name, message)
    end
  end
  
  class OpMatcher
    def initialize(actual, pos=true)
      @actual, @pos = actual, pos
    end
    
    %w{ == === =~ > >= < <= }.each do |operator|
      define_method(operator) do |expected|
        m = MATCHERS[operator.to_sym] || Matcher.new(operator.to_sym) do |_actual_, _expected_|
          @messages = {
            true => "expected that #{_actual_} would #{operator} #{_expected_}",
            false => "did not expect that #{_actual_} would #{operator} #{_expected_}"
          }
          !!_actual_.send(operator, _expected_)
        end
        m.expected = expected
        m.matches?(@actual, @pos)
      end
    end
  end
end