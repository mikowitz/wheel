describe "Wheel" do
  before do
    @ex_group = Wheel::ExampleGroup.new("group name", "group parent name") do; end
    @example = Wheel::Example.new("example name", "group name") do; end
    @failure = [Wheel::FailedExpectation.new("test name", "message"), @example]
    @pending = [Wheel::PendingExpectation.new("test name", "pending message"), @example]
    @error = [SyntaxError.new, @example]
  end
  
  describe "SilentFormatter" do
    before do
      @formatter = Wheel::Formatter::SilentFormatter.new
      @name = "test name"
    end

    it "should call success" do
      @formatter.success(@name).should be_nil
    end
    
    it "should call failure" do
      @formatter.failure(@name, 0).should be_nil
    end
    
    it "should call error" do
      @formatter.error(@name, 0).should be_nil
    end
    
    it "should call pending" do
      @formatter.pending(@name, 0).should be_nil
    end
    
    it "should call failure_details" do
      @formatter.failure_details(@failure, 0).should be_nil
    end
    
    it "should call error_details" do
      @formatter.error_details(@error, 0).should be_nil
    end
    
    it "should call pending_details" do
      @formatter.pending_details(@pending, 0).should be_nil
    end
    
    it "should calls example_results" do
      @formatter.example_results(Wheel::TestRunner).should be_nil
    end    
  end
  
  describe "SimpleFormatter" do
    before do
      @formatter = Wheel::Formatter::SimpleFormatter.new
      @name = "test name"
    end

    it "should call success" do
      @formatter.success(@name).should == "."
    end
    
    it "should call failure" do
      @formatter.failure(@name, 0).should == "F"
    end
    
    it "should call error" do
      @formatter.error(@name, 0).should == "E"
    end
    
    it "should call pending" do
      @formatter.pending(@name, 0).should == "-"
    end
    
    it "should call failure_details" do
      details = @formatter.failure_details(@failure, 0)
      details.should =~ /1\)/
      details.should =~ /group name example name/
      details.should =~ /FAILED/
    end
    
    it "should call error_details" do
      details = @formatter.error_details(@error, 0)
      details.should =~ /1\)/
      details.should =~ /group name example name/
      details.should =~ /ERROR/
    end
    
    it "should call pending_details" do
      details = @formatter.pending_details(@pending, 0)
      details.should =~ /1\)/
      details.should =~ /group name example name/
      details.should =~ /PENDING/
    end
  end

  describe "SpecFormatter" do
     before do
       @formatter = Wheel::Formatter::SpecFormatter.new
       @name = "test name"
     end

     it "should call success" do
       @formatter.success(@name).should == "- test name\n"
     end

     it "should call failure" do
       @formatter.failure(@name, 1).should == "- test name (FAILED - 1)\n"
     end

     it "should call error" do
       @formatter.error(@name, 1).should == "- test name (ERROR - 1)\n"
     end

     it "should call pending" do
       @formatter.pending(@name, 1).should == "- test name (PENDING - 1)\n"
     end

     it "should call failure_details" do
       details = @formatter.failure_details(@failure, 0)
       details.should =~ /1\)/
       details.should =~ /group name example name/
       details.should =~ /FAILED/
     end

     it "should call error_details" do
       details = @formatter.error_details(@error, 0)
       details.should =~ /1\)/
       details.should =~ /group name example name/
       details.should =~ /ERROR/
     end

     it "should call pending_details" do
       details = @formatter.pending_details(@pending, 0)
       details.should =~ /1\)/
       details.should =~ /group name example name/
       details.should =~ /PENDING/
     end
   end
end