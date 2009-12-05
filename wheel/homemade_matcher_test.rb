module Wheel
  module Matchers
    def be_greater_than(expected)
      Matcher.new(:greater_than, expected) do |_actual_|
        @messages = {
          true => "expected #{_actual_} to be greater than #{expected}",
          false => "did not expect #{_actual_} to be greater than #{expected}"
        }
        !!(_actual_ > expected)
      end
    end
  end
end

describe "my very own matcher" do
  it "should work properly" do
    5.should be_greater_than 4
  end
end