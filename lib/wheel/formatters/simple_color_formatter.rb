module Wheel
  module Formatter
    class SimpleColorFormatter < SimpleFormatter
      # test results
      def print_success(name); Color.green(".", false); end
      def print_failure(name, ct); Color.red("F", false); end
      def print_error(name, ct); Color.yellow("E", false); end
      def print_pending(name, ct); Color.cyan("-", false); end
      
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
        Color.send(runner.summary_color, example_results(runner))
      end
      
      private
        def print_non_success_details(ct, non_success_type, exception, example)
          color = Formatter::NON_SUCCESS_COLORS[non_success_type]
          puts "#{ct + 1})"
          Color.send(color, "'#{example.full_name}' #{non_success_type}")
          Color.send(color, exception.message)
          puts example.backtrace.reject{|l| l =~ /:in/}.first
          puts
        end
    end
  end
end