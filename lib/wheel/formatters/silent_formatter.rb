module Wheel
  module Formatter
    class SilentFormatter
      # test suite name
      def print_suite_name(name); end
      
      # test results
      def print_success(name); end
      def print_failure(name, ct); end
      def print_error(name, ct); end
      def print_pending(name, ct); end
      
      # result details
      def print_failure_details(fail, ct); end
      def print_error_details(error, ct); end
      def print_pending_details(pending, ct); end
      
      # test runner results
      def print_run_details(runner, run_time); end
      def print_example_results(runner); end
    end
  end
end