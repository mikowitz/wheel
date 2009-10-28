module Wheel
  class Matcher
    attr_reader :name, :messages
    def initialize(name, expected, &block)
      @name, @expected, @match_block = name, expected, block
    end
    
    def matches?(actual, pos=true)
      @actual = actual
      result = check_expectation(@actual)
      error_message(pos) unless result == pos
    end

    def check_expectation(actual)
      !!instance_exec(actual, &@match_block)
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
      define_method(operator) do |_actual_|
        Matcher.new(operator.to_sym, _actual_) do |_expected_|
          @messages = {
            true => "expected that #{_expected_} would #{operator} #{_actual_}",
            false => "did not expect that #{_expected_} would #{operator} #{_actual_}"            
          }
          !!_expected_.send(operator, _actual_)
        end.matches?(@actual, @pos)
      end
    end
  end
end