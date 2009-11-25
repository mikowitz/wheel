shared_examples_for "shared examples" do
  before do
    @a = "A"
  end
  
  it "should be run correctly" do
    5.should == 5
  end
  
  it "should recognize instance variables" do
    @x.should == "X"
    @a.should == "A"
  end
  
  describe "shared examples sub block" do
    before do
      @y = "Y"
    end
    
    it "should get run" do
      [1,2,3].should include 3
    end
    
    it "should recognize instance variables" do
      @a.should == "A"
      @x.should == "X"
      @y.should == "Y"
    end
  end
end

describe "Shared example tests" do
  before do
    @x = "X"
  end
  
  it_should_behave_like "shared examples"

  it "should recognize instance variables" do
    @x.should == "X"
  end
  
  it "should recognize instance variables set in the shared_examples_for block" do
    @a.should == "A"
  end
end

describe "A 2nd block of shared example tests" do
  before do
    @x = "X"
  end


  it_should_behave_like "shared examples"
end