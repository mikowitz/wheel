module Wheel
  module TestRunner
    @@failures = []
    @@examples = 0
    
    def self.failures; @@failures; end
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
      formatter.print_suite_name(eg.full_name)
      eg.examples.each do |ex|
        self._pass_or_die(ex)
      end
      eg.example_groups.each do |sub_eg|
        run_example_group(sub_eg)
      end
    end
    
    
    def self._pass_or_die(ex)
      self.examples += 1
      begin
        result = ex.run_example
        formatter.print_test_name(ex.name)
        formatter.print_success
      rescue FailedExpectation => err
        formatter.print_failed_test_name(ex.name)
        formatter.print_failure(err.message, failures.size + 1)
        self.failures << [err, ex.full_name]
      rescue Exception => err
        formatter.print_failed_test(ex.name)
        formatter.print_error(err.message, failures.size + 1)
        self.failures << [err, ex.full_name]
      end
    end
  end
end