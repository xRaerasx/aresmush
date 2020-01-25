module AresMUSH
  module Utils
    class EchoCmd
      include AresMUSH::Plugin
      
      attr_accessor :message
      
      def setup_error_checkers
        self.class.no_switches
        self.class.argument_must_be_present "message", "echo"
      end
      
      def want_command?(client, cmd)
        cmd.root_is?("echo")
      end
      
      def crack!
        self.message = cmd.args
      end
        
      def handle
        client.emit self.message
      end
    end
  end
end
