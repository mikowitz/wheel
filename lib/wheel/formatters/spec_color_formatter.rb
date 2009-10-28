module Wheel
  module Formatter
    class SpecColorFormatter < SpecFormatter
      def print_suite_name(name); puts; Color.white(name); end
      def print_test_name(name); Color.green("- #{name}", false); end
      def print_failed_test_name(name); Color.red("- #{name}", false); end
      def print_success; puts; end
      def print_failure(message, ct); Color.red(" (FAILED - #{ct})") ; end
      def print_error(message, ct); Color.yellow(" (ERROR - #{ct})") ; end


      def print_failure_details(err, ct)
        puts "#{ct + 1})"
        Color.red "'#{err[1]}' FAILED"
        Color.red "#{err[0].message}"
        puts err[0].backtrace.reject{|l| l =~ /:in/ }.first
        puts
      end
    end
  end
end