describe "An example group" do
  describe "with a before :all block and a before :each block" do
    before do
      @a = "A"
    end
  
    before :each do
      @b = "B"
    end
    
    it "should persist data from both blocks" do
      @a.should == "A"
      @b.should == "B"
    end
    
    describe "in a sub block" do
      it "should still persist data" do
        @a.should == "A"
        @b.should == "B"        
      end
    end
  end
  
  describe "with 2 before :all blocks" do
    before do
      @a = "A"
    end
  
    before do
      @b = "B"
    end
  
    it "should persist data from both blocks" do
      @a.should == "A"
      @b.should == "B"
    end    
  end
  
  describe "with a before :all block and and after :each block" do
    before do
      @x = 0
    end

    after :each do
      @x += 1
    end
    
    it "x should still equal 0 when no tests have run" do
      @x.should == 0
    end
    
    it "x should equal 1 in the 2nd test" do
      @x.should == 1
    end
    
    describe "in a sub block" do
      it "x should be 2 in this test" do
        @x.should == 2
      end
      
      describe "in another sub block" do
        it "x should == 3 in this test" do
          @x.should == 3
        end
      end
    end
  end
  
  describe "with a before :all block" do
    before do 
      @x = 0
    end
    
    it "@x should equal 0" do
      @x.should == 0
    end
    
    describe "in a sub block" do
      it "@x should also equal 0" do
        @x.should == 0
      end
    end
  end
  
  describe "with a before :each block" do
    before :each do 
      @x = 0
    end
    
    it "@x should equal 0" do
      @x.should == 0
    end
    
    describe "in a sub block" do
      it "@x should also equal 0" do
        @x.should == 0
      end
      
      describe "in a sub sub block" do
        it "@x should still equal 0" do
          @x.should == 0
        end
      end
    end
  end
  
  describe "running before and after blocks in the correct order" do
    before do
      puts "outer before"
    end
    
    after do
      puts "outer after"
    end
    
    describe "and a sub block" do
      before do
        puts "inner before"
      end
      
      after do
        puts "inner after"
      end
      
      it "should be a thing" do
        puts "example"
      end
    end
  end
end

