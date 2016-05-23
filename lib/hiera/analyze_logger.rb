class Hiera
  module Analyze_logger
    class << self
      def warn(msg)
        write_log("ANALYZE: %s: %s" % [Time.now.to_s, msg])
      end

      def debug(msg)
        STDERR.puts("DEBUG: %s: %s" % [Time.now.to_s, msg])
      end

      private

      def analyze_log
        Hiera::Config[:analyze_log] || '/var/log/hiera_anaylze.log'
      end

      def write_log(msg)
        open(analyze_log, 'a') { |f|
          f.puts msg
        }
      end
    end
  end
end
