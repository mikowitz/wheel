module Wheel
  module Formatter
    class SimpleFormatter < SilentFormatter
      def print_success; print "."; end
      def print_failure(message, ct); print "F"; end
      def print_run_details(runner, run_time)
        puts; puts
        runner.failures.each_with_index do |failure, ct|
          print_failure_details(failure, ct)
        end
        puts
        puts "Finished in #{run_time} seconds"
        puts
        print_results(runner)
      end
      def print_failure_details(failure, ct)
        puts "#{ct + 1})\n'#{err[1]}' FAILED\n#{err[0].message}"
        puts err[0].backtrace.reject{|l| l =~ /:in/}.first
      end
      def print_results(runner)
        puts [
              Formatter.pluralize("example", runner.examples),
              Formatter.pluralize("failure", runner.failures.size)
             ].join(", ")
      end
    end
  end
end