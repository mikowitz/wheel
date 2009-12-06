describe "Revamping matchers" do
  it "should not create a new matcher for every expectation" do
    5.should == 5
    6.should == 6
    7.should_not == 6
  end
  
  
end