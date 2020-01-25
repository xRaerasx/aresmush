module AresMUSH
  module Manage
    class PluginListCmd
      include AresMUSH::Plugin

      def setup_error_checkers
        self.class.must_be_logged_in
        self.class.no_args
      end
      
      def want_command?(client, cmd)
        cmd.root_is?("plugins")
      end

      # TODO - check permissions
      
      def handle
        list = Global.plugin_manager.plugins.map { |p| p.class.name.rest("AresMUSH::") }
        client.emit BorderedDisplay.table(list, 25, t('manage.plugins'))
      end
    end
  end
end
