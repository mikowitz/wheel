module Wheel
  module Matchers
    def be_greater_than(expected)
      m = MATCHERS[:greater_than] || Matcher.new(:greater_than) do |_actual_, _expected_|
        @messages = {
          true => "expected #{_actual_} to be greater than #{_expected_}",
          false => "did not expect #{_actual_} to be greater than #{_expected_}"
        }
        !!(_actual_ > _expected_)
      end
      m.expected = expected
      m
    end
  end
end

describe "my very own matcher" do
  it "should work properly" do
    5.should be_greater_than 4
  end
end