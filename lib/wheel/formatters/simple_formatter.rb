module Wheel
  module Formatter
    class SimpleFormatter < SilentFormatter
      # test results
      def success(name); "."; end
      def failure(name, ct); "F"; end
      def error(name, ct); "E"; end
      def pending(name, ct); "-"; end
      
      # result details
      def failure_details(fail, ct)
        non_success_details(ct, "FAILED", *fail)
      end
      
      def error_details(error, ct)
        non_success_details(ct, "ERROR", *error)
      end
      
      def pending_details(pending, ct)
        non_success_details(ct, "PENDING", *pending)
      end
      
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
      
      private
        # def non_success_details(exception, test_name, ct, non_success_type)
        def non_success_details(ct, non_success_type, exception, example)
          "#{ct + 1})\n" +
          "'#{example.full_name}' #{non_success_type}\n" +
          exception.message + "\n" +
          example.backtrace.reject{|l| l =~ /:in/}.first + "\n\n"
        end
        
        def example_results(runner)
          [ Formatter.pluralize("example", runner.examples),
            Formatter.pluralize("failure", runner.failures.size),
            Formatter.pluralize("error", runner.errors.size),
            Formatter.pluralize("pending", runner.pending.size)
          ].join(", ")
        end
    end
  end
end