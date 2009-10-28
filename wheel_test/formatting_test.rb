describe "My Test" do
  it "should handle include correctly" do
    [1,2,3].should include 2
    [1,2,3].should_not include 5
  end
  
  it "should fail this test" do
    5.should == 6
  end
  
  describe "sub tests" do
    it "should be an error" do
      aoeoencoec.should == 5
    end
  end
end