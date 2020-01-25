require 'erubis'

module AresMUSH
  module Who
    class WhereCmd
      include AresMUSH::Plugin

      def initialize
        @renderer =  WhoRenderer.new("where.erb")
        super
      end

      def setup_error_checkers
        self.class.no_args
        self.class.no_switches
      end
      
      def want_command?(client, cmd)
        cmd.root_is?("where")
      end
      
      def handle
        client.emit @renderer.render
      end      
    end
  end
end
