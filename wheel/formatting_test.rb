# # test suite name
# def print_suite_name(name); end
# 
# # test results
# def print_success(name); end
# def print_failure(name, ct); end
# def print_error(name, ct); end
# def print_pending(name, ct); end
# 
# # result details
# def print_failure_details(fail, ct); end
# def print_error_details(error, ct); end
# def print_pending_details(pending, ct); end
# 
# # test runner results
# def print_run_details(runner, run_time); end
# def print_example_results(runner); end

describe "Wheel" do
  before do
    @ex_group = Wheel::ExampleGroup.new("group name", "group parent name") do; end
    @example = Wheel::Example.new("example name", "group name", @ex_group) do; end
    @failure = [Wheel::FailedExpectation.new("test name", "message"), @example]
    @pending = [Wheel::PendingExpectation.new("test name", "pending message"), @example]
    @error = [SyntaxError, @example]
  end
  describe "SilentFormatter" do
    before do
      @formatter = Wheel::Formatter::SilentFormatter.new
    end
    

  end
  
  describe "SimpleFormatter" do

  end
  # 
  # describe "SimpleColorFormatter" do
  #   it "should call print_success"
  #   it "should call print_failure"
  #   it "should call print_error"
  #   it "should call print_pending"
  #   
  #   it "should call print_failure_details"
  #   it "should call print_error_details"
  #   it "should call print_pending_details"
  #   
  #   it "should call print_run_details"
  #   it "should calls print_example_results"
  # end
  # 
  # describe "SpecFormatter" do
  #   it "should call print_success"
  #   it "should call print_failure"
  #   it "should call print_error"
  #   it "should call print_pending"
  #   
  #   it "should call print_failure_details"
  #   it "should call print_error_details"
  #   it "should call print_pending_details"
  #   
  #   it "should call print_run_details"
  #   it "should calls print_example_results"
  # end
  # 
  # describe "SpecColorFormatter" do
  #   it "should call print_success"
  #   it "should call print_failure"
  #   it "should call print_error"
  #   it "should call print_pending"
  #   
  #   it "should call print_failure_details"
  #   it "should call print_error_details"
  #   it "should call print_pending_details"
  #   
  #   it "should call print_run_details"
  #   it "should calls print_example_results"
  # end
end