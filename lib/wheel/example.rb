module Wheel
  class Example
    include CustomMatchers
    attr_reader :name, :parent_name
    
    def initialize(name, parent_name, &block)
      @name, @parent_name, @block = name, parent_name, block
    end
    
    def run_example
      instance_eval(&@block)
    end
    
    def full_name
      ([parent_name, name].join(" ")).strip
    end
    
    def method_missing(method, *args, &block)
      method = method.to_s
      if method =~ /^be_/
        tested_method = method.match(/^be_(.*)$/)[1]
        Matcher.new(tested_method.to_sym, nil) do |_actual_|
          @messages = {
            true => "expected #{_actual_.inspect} to be #{tested_method}",
            false => "did not expect #{_actual_.inspect} to be #{tested_method}"
          }
          !!_actual_.send("#{tested_method}?")
        end
      end
    end
  end
end