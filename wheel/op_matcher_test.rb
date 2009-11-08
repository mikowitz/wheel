describe "Wheel" do
  describe "OpMatchers" do
    it "should handle == correctly" do
      5.should == 5
      5.should_not == 5.0001
    end
    
    it "should handle =~ correctly" do
      "hello".should =~ /ll/
      "hello".should_not =~ /lll/
    end
    
    it "should handle > correctly" do
      5.should > 4
      5.should_not > 5
    end
    
    it "should handle < correctly" do
      5.should < 6
      5.should_not < 4
    end

    it "should handle < correctly (for inheritance)" do
      String.should < Object
      Object.should_not < String
    end

    it "should handle >= correctly" do
      5.should >= 4
      5.should >= 5
      5.should_not >= 6
    end

    it "should handle <= correctly" do
      5.should <= 6
      5.should <= 5
      5.should_not <= 4
    end
  end
end