module Wheel
  module Matchers
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
    
    def contain(expected)
      Matcher.new(:contain, expected) do |_actual_|
        @messages = {
          true => "expected #{_actual_.inspect} to contain #{expected.inspect}",
          false => "did not expect #{_actual_.inspect} to contain #{expected.inspect}"
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
   
    def respond_to(expected)
      Matcher.new(:respond_to, expected) do |_actual_|
        @messages = {
          true => "expected #{_actual_.inspect} to respond to #{expected.to_sym.inspect}",
          false => "did not expect #{_actual_.inspect} to respond to #{expected.to_sym.inspect}"          
        }
        !!_actual_.respond_to?(expected.to_sym)
      end
    end
    
    def have_assigned_attribute(expected)
      Matcher.new(:have_assigned_attribute, expected) do |_actual_|
        @messages = {
          true => "expected #{_actual_.inspect} to have a non-nil value assigned to #{expected.to_sym.inspect}",
          false => "did not expect #{_actual_.inspect} to have a non-nil value assigned to #{expected.to_sym.inspect}"          
        }
        !!(_actual_.respond_to?(expected.to_sym) && !_actual_.send(expected.to_sym).nil?)
      end
    end

  end
end