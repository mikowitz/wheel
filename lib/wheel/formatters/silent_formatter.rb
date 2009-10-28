module Wheel
  module Formatter
    class SilentFormatter
      def print_suite_name(name); end
      def print_test_name(name); end
      def print_failed_test_name(name); end
      def print_success; end
      def print_failure(message, ct); end
      def print_run_details(runner, run_time); end
      def print_failure_details(err, ct); end
      def print_results(runner); end
    end
  end
end