module Wheel
  module TestRunner
    @@failures = []
    @@errors = []
    @@pending = []
    @@examples = 0
    @@current_parent_example_group = nil
    
    def self.failures; @@failures; end
    def self.errors; @@errors; end
    def self.pending; @@pending; end
    def self.examples; @@examples; end
    def self.examples=(val); @@examples = val; end
    
    def self.formatter; Formatter.formatter; end
    
    def self.run_tests
      start_time = Time.now

      ExampleSuite.example_groups.each do |eg|
        run_example_group(eg)
      end
      run_time = Time.now - start_time
      formatter.print_run_details(self, run_time)
    end
    
    def self.run_example_group(eg)
      @@current_parent_example_group ||= eg
      formatter.print_suite_name(eg.full_name) unless eg.examples.empty?
      run_setup_or_teardown_blocks(eg, @@current_parent_example_group, :before_all)
      eg.examples.each do |ex|
        run_setup_or_teardown_blocks(eg, @@current_parent_example_group, :before_each)
        _pass_or_die(ex, @@current_parent_example_group)
        run_setup_or_teardown_blocks(eg, @@current_parent_example_group, :after_each)
      end
      eg.example_groups.each do |sub_eg|
        sub_eg.before_each_blocks += (@@current_parent_example_group.before_each_blocks + eg.before_each_blocks).uniq
        sub_eg.after_each_blocks += (@@current_parent_example_group.after_each_blocks + eg.after_each_blocks).uniq
        run_example_group(sub_eg)
      end
      run_setup_or_teardown_blocks(eg, @@current_parent_example_group, :after_all)
      @@current_parent_example_group = nil if eg.parent_name.nil?
    end
    
    def self.run_setup_or_teardown_blocks(source, target, block_type)
      source.send("#{block_type.to_s}_blocks").each do |b|
        target.instance_eval(&b)
      end
    end
    
    def self._pass_or_die(ex, eg)
      self.examples += 1
      begin
        ex.run_example(eg)
        formatter.print_success(ex.name)
      rescue FailedExpectation => err
        self.failures << [err, ex]
        formatter.print_failure(ex.name, failures.size)
      rescue PendingExpectation => err
        self.pending << [err, ex]
        formatter.print_pending(ex.name, pending.size)
      rescue Exception => err
        self.errors << [err, ex]
        formatter.print_error(ex.name, errors.size)
      end
    end
    
    def self.summary_color
      if self.failures.empty?
        if self.errors.empty?
          if self.pending.empty?
            :green
          else
            :cyan
          end
        else
          :yellow
        end
      else
        :red
      end
    end
  end
end