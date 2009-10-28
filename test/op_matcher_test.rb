require 'test_helper'

class OpMatcherTest < Test::Unit::TestCase
  context "for ==" do
    setup do
      @matcher = Wheel::Matcher.new(:==, 5) do |_expected_|
        !!(_expected_ == 5)
      end
    end
    should "return the correct values" do
      assert @matcher.check_expectation(5)
      assert !@matcher.check_expectation(6)
    end
  end
  
  context "for =~" do
    setup do
      @matcher = Wheel::Matcher.new(:=~, "hello") do |_expected_|
        !!("hello" =~ _expected_)
      end
    end
    should "return the correct values" do
      assert @matcher.check_expectation(/ll/)
      assert !@matcher.check_expectation(/lx/)
    end
  end

  context "for >" do
    setup do
      @matcher = Wheel::Matcher.new(:>, 5) do |_expected_|
        !!(5 > _expected_)
      end
    end
    should "return the correct values" do
      assert @matcher.check_expectation(4)
      assert !@matcher.check_expectation(6)
    end
  end
  
  context "for >=" do
    setup do
      @matcher = Wheel::Matcher.new(:>=, 5) do |_expected_|
        !!(5 >= _expected_)
      end
    end
    should "return the correct values" do
      assert @matcher.check_expectation(4)
      assert @matcher.check_expectation(5)
      assert !@matcher.check_expectation(6)
    end
  end

  context "for <" do
    setup do
      @matcher = Wheel::Matcher.new(:<, 5) do |_expected_|
        !!(5 < _expected_)
      end
    end
    should "return the correct values" do
      assert @matcher.check_expectation(6)
      assert !@matcher.check_expectation(4)
    end
  end
  
  context "for <=" do
    setup do
      @matcher = Wheel::Matcher.new(:<=, 5) do |_expected_|
        !!(5 <= _expected_)
      end
    end
    should "return the correct values" do
      assert @matcher.check_expectation(6)
      assert @matcher.check_expectation(5)
      assert !@matcher.check_expectation(4)
    end
  end
end

