module Kernel
  def should(matcher=nil)
    handle_expectation(matcher, self, true)
  end
  
  def should_not(matcher=nil)
    handle_expectation(matcher, self, false)
  end
  
  def handle_expectation(matcher, expected, positive_expectation)
    return Wheel::OpMatcher.new(expected, positive_expectation) if matcher.nil?
    matcher.matches?(expected, positive_expectation)
  end
  
  private :handle_expectation
end