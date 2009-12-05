module Helpers
  def fee
    return "hello"
  end
  
  def self.included(base)
    puts "including Helpers..."
  end
end

describe "examples in a block that includes helper methods" do
  include Helpers

  def foo
    return 5
  end
  
  
  it "should recognize the defined helper methods" do
    foo.should == 5
  end
  
  it "should recognize externally defined and included helper methods" do
    fee.should == "hello"
  end
end