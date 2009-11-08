require 'test_helper'

class CustomMatcherTest < Test::Unit::TestCase
  context "equal" do
    setup do
      @matcher = Wheel::Matcher.new(:equal, 5) do |_actual_|
        !!(_actual_.equal?(5))
      end
      @matcher2 = Wheel::Matcher.new(:equal, "5") do |_actual_|
        !!(_actual_.equal?("5"))
      end
    end
    
    should "work correctly for integers" do
      assert @matcher.check_expectation(5)
      assert !@matcher.check_expectation("5")
    end
    
    should "work correctly for strings" do
      assert !@matcher.check_expectation("5")
    end
  end
  
  context "include" do
    setup do
      @matcher = Wheel::Matcher.new(:include, 5) do |_actual_|
        _actual_.include?(5)
      end
    end
    
    should "work correctly" do
      assert @matcher.check_expectation([1,2,5])
      assert !@matcher.check_expectation([1,2,3])
    end
  end
  
  context "be_a" do
    setup do
      @matcher = Wheel::Matcher.new(:be_a, String) do |_actual_|
        _actual_.is_a? String
      end
    end
    
    should "work correctly" do
      assert @matcher.check_expectation("hello")
      assert !@matcher.check_expectation(0.25)
    end
  end

  context "be" do
    setup do
      @matcher = Wheel::Matcher.new(:be, true) do |_actual_|
        !!_actual_ = true
      end
    end
    
    should "work correctly" do
      assert @matcher.check_expectation(true)
    end
  end


  context "be_close_to" do
    setup do
      @matcher = Wheel::Matcher.new(:be_close_to, 5) do |_actual_|
        pow = 10**((1.0 / 0.001).to_i.to_s.size)
        diff = (5 - _actual_).abs
        ((diff * pow).round.to_f / pow) <= 0.001
      end
    end
    
    should "work correctly" do
      assert @matcher.check_expectation(5.0001)
      assert !@matcher.check_expectation(5.01)
    end
  end
  
  context "raise_error" do
    setup do
      @matcher = Wheel::Matcher.new(:raise_error, SyntaxError) do |_actual_|
        if _actual_.respond_to?(:call)
          begin
            _actual_.call
            false
          rescue Exception => err
            err.class == SyntaxError
          end
        end
      end
    end
    
    should "work correctly" do
      assert @matcher.check_expectation(Proc.new { raise SyntaxError })
      assert !@matcher.check_expectation(true)
    end
  end
end