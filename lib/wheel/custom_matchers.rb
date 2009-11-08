module Wheel
  module CustomMatchers
    def equal(expected)
      Matcher.new(:equal, expected) do |_actual_|
        @messages = {
          true => "expected #{_actual_} to equal #{expected}",
          false => "did not expected #{_actual_} to equal #{expected}"
        }
        !!(_actual_.equal?(expected))
      end
    end
    
    def raise_error(expected)
      Matcher.new(:raise_error, expected) do |_actual_|
        @messages = {
          true => "expected to raise #{expected.name}, but none was raised",
          false => "expected no error, but #{expected.name} was raised"
        }
        if _actual_.respond_to?(:call)
          begin
            _actual_.call
            false
          rescue Exception => err
            err.class == expected
          end
        end
      end
    end
    
    def include(expected)
      Matcher.new(:include, expected) do |_actual_|
        @messages = {
          true => "expected #{_actual_.inspect} to include #{expected.inspect}",
          false => "did not expect #{_actual_.inspect} to include #{expected.inspect}"
        }
        _actual_.include?(expected)
      end
    end
    
    def be_close_to(expected, range=0.001)
      Matcher.new(:be_close_to, expected) do |_actual_|
        @messages = {
          true => "expected #{_actual_} to be within #{range} of #{expected}",
          false => "did not expect #{_actual_} to be within #{range} of #{expected}"
        }
        n = 10**((1.0 / range).to_i.to_s.size)
        diff = (expected - _actual_).abs
        ((diff * n).round.to_f / n) <= range
      end
    end
    
    def be_a(expected)
      Matcher.new(:be_a, expected) do |_actual_|
        @messages = {
          true => "expected #{_actual_} to be an instance of #{expected}",
          false => "did not expect #{_actual_} to be an instance of #{expected}"
        }
        _actual_.is_a?(expected)
      end
      
    end
    alias :be_an :be_a
    
    def be(expected=true)
      Matcher.new(:be, expected) do |_actual_|
        @messages = {
          true => "expected #{_actual_.inspect} to be #{expected}",
          false => "did not expect #{_actual_.inspect} to be #{expected}"
        }
        !!_actual_ == expected
      end
    end
  end
end