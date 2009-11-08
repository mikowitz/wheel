module Wheel
  module TestRunner
    @@failures = []
    @@errors = []
    @@pending = []
    @@examples = 0
    
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
      formatter.print_suite_name(eg.full_name) unless eg.examples.empty?
      eg.instance_eval(&eg.before_all_block) if eg.before_all_block
      eg.examples.each do |ex|
        eg.instance_eval(&eg.before_each_block) if eg.before_each_block
        self._pass_or_die(ex, eg.before_each_block)
      end
      eg.example_groups.each do |sub_eg|
        run_example_group(sub_eg)
      end
    end
    
    def self._pass_or_die(ex, proc)
      self.examples += 1
      begin
        ex.run_example
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