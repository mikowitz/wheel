module Wheel
  module Formatter
    class SpecFormatter < SimpleFormatter
      def print_suite_name(name); puts; puts name; end
      def print_test_name(name); print "- #{name}"; end
      def print_failed_test_name(name); print_test_name(name); end
      def print_success; puts; end
      def print_failure(message, ct); puts " (FAILED - #{ct})"; end
    end
  end
end