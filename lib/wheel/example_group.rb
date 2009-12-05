module Wheel
  class ExampleGroup
    include Matchers

    attr_reader :name, :parent_name, :examples, :example_groups
    attr_accessor :before_all_blocks, :before_each_blocks
    attr_accessor :after_all_blocks, :after_each_blocks

    def initialize(name, parent_name, &block)
      @name, @parent_name = name, parent_name
      @examples, @example_groups = [], []
      @before_all_blocks, @before_each_blocks, @after_all_blocks, @after_each_blocks = [], [], [], []
      instance_eval(&block)
    end
    
    def include(mod)
      self.class.send(:include, mod)
    end
    
    def describe(name, &block)
      same_group_name = self.example_groups.find{|eg| eg.name == name}
      if same_group_name
        same_group_name.instance_eval(&block)
      else
        self.example_groups << ExampleGroup.new(name, self.full_name, &block)
      end
    end
    
    def it(name, &block)
      self.examples << Example.new(name, self.full_name, &block)
    end

    def it_should_behave_like(name)
      if Wheel.shared_examples.keys.include?(name)
        shared_examples = Wheel.shared_examples[name]
        shared_examples.each do |block|
          instance_eval(&block)
        end
      end
    end
    
    def before(frequency = :all, &block)
      if frequency == :all
        before_all_blocks << block
      else
        before_each_blocks << block
      end
    end
    
    def after(frequency = :all, &block)
      if frequency == :all
        after_all_blocks << block
      else
        after_each_blocks << block
      end      
    end
    
    def pending(name, &block)
      self.examples << Example.new(name, self.full_name)
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
      else
        raise(::Wheel::NoMatcher, "cannot find matcher for the name #{method.to_sym.inspect}")
      end
    end
  end
end