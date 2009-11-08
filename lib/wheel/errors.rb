module Wheel
  class FailedExpectation < Exception
    attr_reader :test_name, :message
    def initialize(test_name, message)
      @test_name, @message = test_name, message
    end
  end
  
  class PendingExpectation < Exception
    attr_reader :test_name, :message
    def initialize(test_name, message)
      @test_name, @message = test_name, message
    end
  end
end