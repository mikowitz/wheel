describe "Wheel" do
  describe "Custom Matchers" do
    it "should handle equal correctly" do
      5.should equal 5
      "5".should_not equal "5"
    end
    
    it "should handle raise_error correctly" do
      5.should_not raise_error SyntaxError
      Proc.new {raise SyntaxError}.should raise_error SyntaxError
    end

    it "should handle include correctly" do
      [1,2,3,4,5].should include 4
      [1,2,3].should_not include 4
    end
    
    it "should handle be_close_to correctly" do
      5.should be_close_to 5.0001
      5.should be_close_to 5.001
      5.should_not be_close_to 5.01
      5.should_not be_close_to 4
      4.should be_close_to 4, 1.0
    end

    it "should handle be_a correctly" do
      5.should be_a Fixnum
      "hello".should be_a String
      [1,2,3].should be_an Array
    end

    it "should handle be correctly" do
      true.should be
      (1 == 2).should_not be
    end
    
    describe "on the fly defined matchers" do
      it "should handle be_nil correctly" do
        nil.should be_nil
        5.should_not be_nil
      end
      
      it "should handle be_empty correctly" do
        [1,2].should_not be_empty
        [].should be_empty
      end
    end
  end
end