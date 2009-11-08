module Wheel
  module Formatter
    class SpecFormatter < SimpleFormatter
      # test suite name
      def print_suite_name(name); puts; puts name; end

      # test results
      def success(name); "- #{name}\n"; end
      def failure(name, ct); "- #{name} (FAILED - #{ct})\n"; end
      def error(name, ct); "- #{name} (ERROR - #{ct})\n"; end
      def pending(name, ct); "- #{name} (PENDING - #{ct})\n"; end
      
      # test runner results
      def print_run_details(runner, run_time)
        puts; puts
        runner.failures.each_with_index do |failure, ct|
          print_failure_details(failure, ct)
        end
        runner.errors.each_with_index do |err, ct|
          print_error_details(err, ct)
        end
        runner.pending.each_with_index do |pend, ct|
          print_pending_details(pend, ct)
        end
        puts
        puts "Finished in #{run_time} seconds"
        puts
        puts example_results(runner)
      end
    end
  end
end