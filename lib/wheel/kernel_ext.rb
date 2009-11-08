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
  
  def pending
    raise Wheel::PendingExpectation.new(name, "TODO")
  end
  
  private :handle_expectation
end

class Proc
  EMPTY = "#<Proc:0x0000000000000000"
  
  def empty?
    self.to_s.gsub(/@.*$/, "") == EMPTY
  end
  
  def blank?
    self.empty? || self.nil?
  end
end