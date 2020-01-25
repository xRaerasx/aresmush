module AresMUSH
  module Manage
    class ConfigListCmd
      include AresMUSH::Plugin

      def setup_error_checkers
        self.class.must_be_logged_in
        self.class.no_args
      end
      
      def want_command?(client, cmd)
        cmd.root_is?("config") && cmd.switch.nil? && cmd.args.nil?
      end

      # TODO - check permissions
      
      def handle
        client.emit BorderedDisplay.table(Global.config.keys, 25, t('manage.config_sections'))
      end
    end
  end
end