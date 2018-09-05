require "fritid/version"
require "thor"
module Fritid
  class CLI < Thor

    attr_accessor :mins, :secs, :span_secs

    option :m, type: :boolean
    desc 'start [work interval] [break interval]', 'Sets/starts an egg timer with a specified work and break interval.'
    def start(*args)
      if args.size > 2
        puts 'ERROR: Incorrect number of arguments. Please supply only a start and break interval.'
        exit(0)
      end

      settings = {
          work:  args[0].to_i,
          break: args[1].to_i
      }
      if options[:m]
        egg_timer(settings, 60)
      else
        egg_timer(settings, 1)
      end


    end

    no_commands do
      def init_vars
        @mins = 0
        @secs = 0
        @span_secs = 0

      end

      def egg_timer(settings, sec_val)
        @secs = settings[:work] * sec_val

        timer = Thread.new do
          while @secs > 0
            dec_time
            @secs -= 1
          end
        end

        STDIN.gets
        timer.kill
      end

      def dec_time
        puts @secs
        sleep 1
      end
    end
  end
end
