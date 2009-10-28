module Wheel
  module Formatter
    class SimpleColorFormatter < SimpleFormatter
      def print_success; Color.green(".", false); end
      def print_failure(message, ct); Color.red("F", false); end
      def print_results(runner)
        color = runner.failures.size.zero? ? :green : :red
        Color.send(color,
          [ 
            Formatter.pluralize("example", runner.examples),
            Formatter.pluralize("failure", runner.failures.size)
          ].join(", "))
      end
      
      def print_failure_details(err, ct)
        puts "#{ct + 1})"
        Color.red("'#{err[1]}' FAILED\n#{err[0].message}")
        puts err[0].backtrace.reject{|l| l =~ /:in/}.first
        puts
      end
    end
  end
end