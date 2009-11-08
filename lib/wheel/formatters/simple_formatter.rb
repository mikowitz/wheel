module Wheel
  module Formatter
    class SimpleFormatter < SilentFormatter
      # test results
      def print_success(name); print "."; end
      def print_failure(name, ct); print "F"; end
      def print_error(name, ct); print "E"; end
      def print_pending(name, ct); print "-"; end
      
      # result details
      def print_failure_details(fail, ct)
        print_non_success_details(ct, "FAILED", *fail)
      end
      
      def print_error_details(error, ct)
        print_non_success_details(ct, "ERROR", *error)
      end
      
      def print_pending_details(pending, ct)
        print_non_success_details(ct, "PENDING", *pending)
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
        # def print_non_success_details(exception, test_name, ct, non_success_type)
        def print_non_success_details(ct, non_success_type, exception, example)
          puts "#{ct + 1})"
          puts "'#{example.full_name}' #{non_success_type}"
          puts exception.message
          puts example.backtrace.reject{|l| l =~ /:in/}.first
          puts
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