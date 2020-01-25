module AresMUSH
  module Pose
    class PoseCatcher
      include AresMUSH::Plugin

      def setup_error_checkers
        self.class.must_be_logged_in
        self.class.no_switches
      end
      
      def want_command?(client, cmd)
        cmd.raw.start_with?("\"") ||
        cmd.raw.start_with?("\\") ||
        cmd.raw.start_with?(":") ||
        cmd.raw.start_with?(";")
      end
      
      def handle
        room = client.room
        room.emit PoseFormatter.format(client.name, cmd.raw)
      end

      def log_command
        # Don't log poses
      end 
    end
  end
end
