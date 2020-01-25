module AresMUSH
  module Pose
    class PoseCmd
      include AresMUSH::Plugin

      attr_accessor :message
      
      def setup_error_checkers
        self.class.must_be_logged_in
        self.class.no_switches
      end
      
      def want_command?(client, cmd)
        cmd.root_is?("emit") ||
        cmd.root_is?("pose") || 
        cmd.root_is?("say") || 
        cmd.root_is?("ooc")
      end
      
      def crack!
        if (cmd.root_is?("emit"))
          self.message = PoseFormatter.format(client.name, "\\#{cmd.args}")
        elsif (cmd.root_is?("pose"))
          self.message = PoseFormatter.format(client.name, ":#{cmd.args}")
        elsif (cmd.root_is?("ooc"))
          msg = PoseFormatter.format(client.name, "#{cmd.args}")
          self.message = "%xc<OOC>%xn #{msg}"
        else
          self.message = PoseFormatter.format(client.name, "\"#{cmd.args}")
        end
      end
      
      def handle
        room = client.room
        room.emit self.message
      end
      
      def log_command
        # Don't log poses
      end
    end
  end
end
