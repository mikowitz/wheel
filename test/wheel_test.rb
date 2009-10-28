require 'test_helper'

class WheelTest < Test::Unit::TestCase
  context "Given a describe block" do
    setup do
      describe "Test" do
        it "should be true" do
          true
        end
      end
      @group = Wheel::ExampleSuite.example_groups.first
    end
    
    should "add an example_group to ExampleSuite" do
      assert_equal 1, Wheel::ExampleSuite.example_groups.size
    end
    should "add the correct data to ExampleSuite" do
      assert_equal "Test", @group.name
      assert_equal "Test", @group.full_name
    end
    should "add the correct data to the first ExampleGroup" do
      assert_equal 1, @group.examples.size
      assert_equal "should be true", @group.examples.first.name
      assert_equal "Test should be true", @group.examples.first.full_name
    end
  end
end
