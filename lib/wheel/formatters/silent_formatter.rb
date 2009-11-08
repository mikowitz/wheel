module Wheel
  module Formatter
    class SilentFormatter
      # test suite name
      def suite_name(name); end
      
      # test results
      def success(name); end
      def failure(name, ct); end
      def error(name, ct); end
      def pending(name, ct); end
      
      # result details
      def failure_details(fail, ct); end
      def error_details(error, ct); end
      def pending_details(pending, ct); end
      
      # test runner results
      def run_details(runner, run_time); end
      def example_results(runner); end

      def method_missing(method, *args, &block)
        if method.to_s =~ /^print_/
          method = method.to_s.gsub("print_", "")
          print self.send(method, *args, &block) || ""
        else
          super(method, *args, &block)
        end
      end
    end
  end
end