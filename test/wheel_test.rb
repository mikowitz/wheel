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
      assert_equal "should be true", @group.examples.first.name
      assert_equal "Test should be true", @group.examples.first.full_name
    end
  end
  
  context "extensions to the Proc class" do
    setup do
      @p = Proc.new {}
      @p2 = Proc.new {1}
    end
    
    should "correctly identify an empty proc as empty" do
      assert @p.empty?
    end
    
    should "correctly identify a non-empty proc as not empty" do
      assert !@p2.empty?
    end
    
    context "inside another function" do
      setup do
        def test_empty_block &block
          return false unless block
          !!block.empty?
        end
      end
      
      should "correctly identify an empty block passed as being empty" do
        ret = test_empty_block do
        end
        assert ret
      end
      
      should "correctly identify an empty block with an argument as being empty" do
        ret = test_empty_block {|x| }
        assert ret
      end
      
      should "correctly identify a non-empty block passed as not being empty" do
        ret = test_empty_block do
          "hello"
        end
        assert !ret
      end
      
      should "correctly identify no block passed as not empty" do
        ret = test_empty_block
        assert !ret
      end
    end
  end
end
