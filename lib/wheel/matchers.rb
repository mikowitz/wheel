module Wheel
  module Matchers
    def equal(expected)
      m = MATCHERS[:equal] || Matcher.new(:equal) do |_actual_, _expected_|
        @messages = {
          true => "expected #{_actual_} to equal #{_expected_}",
          false => "did not expected #{_actual_} to equal #{_expected_}"
        }
        !!(_actual_.equal?(_expected_))
      end
      m.expected = expected
      m
    end
    
    def raise_error(expected)
      m = MATCHERS[:raise_error] || Matcher.new(:raise_error) do |_actual_, _expected_|
        @messages = {
          true => "expected to raise #{_expected_.name}, but none was raised",
          false => "expected no error, but #{_expected_.name} was raised"
        }
        if _actual_.respond_to?(:call)
          begin
            _actual_.call
            false
          rescue Exception => err
            err.class == _expected_
          end
        end
      end
      m.expected = expected
      m
    end
    
    def contain(expected)
      m = MATCHERS[:contain] || Matcher.new(:contain) do |_actual_, _expected_|
        @messages = {
          true => "expected #{_actual_.inspect} to contain #{_expected_.inspect}",
          false => "did not expect #{_actual_.inspect} to contain #{_expected_.inspect}"
        }
        _actual_.include?(_expected_)
      end
      m.expected = expected
      m
    end
    
    def be_close_to(expected, range=0.001)
      m = MATCHERS[:be_close_to] || Matcher.new(:be_close_to) do |_actual_, _expected_|
        @messages = {
          true => "expected #{_actual_} to be within #{range} of #{_expected_}",
          false => "did not expect #{_actual_} to be within #{range} of #{_expected_}"
        }
        n = 10**((1.0 / range).to_i.to_s.size)
        diff = (_expected_ - _actual_).abs
        ((diff * n).round.to_f / n) <= range
      end
      m.expected = expected
      m
    end
    
    def be_a(expected)

      m = MATCHERS[:be_a] || Matcher.new(:be_a) do |_actual_, _expected_|
        @messages = {
          true => "expected #{_actual_} to be an instance of #{_expected_}",
          false => "did not expect #{_actual_} to be an instance of #{_expected_}"
        }
        _actual_.is_a?(_expected_)
      end
      m.expected = expected
      m
    end
    alias :be_an :be_a
    
    def be(expected=true)
      m = MATCHERS[:be] || Matcher.new(:be) do |_actual_, _expected_|
        @messages = {
          true => "expected #{_actual_.inspect} to be #{_expected_}",
          false => "did not expect #{_actual_.inspect} to be #{_expected_}"
        }
        !!_actual_ == _expected_
      end
      m.expected = expected
      m
    end
   
    def respond_to(expected)
      m = MATCHERS[:respond_to] || Matcher.new(:respond_to) do |_actual_, _expected_|
        @messages = {
          true => "expected #{_actual_.inspect} to respond to #{_expected_.to_sym.inspect}",
          false => "did not expect #{_actual_.inspect} to respond to #{_expected_.to_sym.inspect}"          
        }
        !!_actual_.respond_to?(_expected_.to_sym)
      end
      m.expected = expected
      m
    end
    
    def have_assigned_attribute(expected)
      m = MATCHERS[:have_assigned_attribute] || Matcher.new(:have_assigned_attribute) do |_actual_, _expected_|
        @messages = {
          true => "expected #{_actual_.inspect} to have a non-nil value assigned to #{_expected_.to_sym.inspect}",
          false => "did not expect #{_actual_.inspect} to have a non-nil value assigned to #{_expected_.to_sym.inspect}"          
        }
        !!(_actual_.respond_to?(_expected_.to_sym) && !_actual_.send(_expected_.to_sym).nil?)
      end
      m.expected = expected
      m
    end
  end
end