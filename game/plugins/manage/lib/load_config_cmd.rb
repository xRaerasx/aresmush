module AresMUSH
  module Manage
    class LoadConfigCmd
      include AresMUSH::Plugin

      def setup_error_checkers
        self.class.must_be_logged_in
      end
      
      def want_command?(client, cmd)
        cmd.root_is?("load") && cmd.args == "config"
      end

      # TODO - check permissions
      
      def handle
        begin
          Global.config_reader.read
          client.emit_success t('manage.config_loaded')
        rescue Exception => e
          client.emit_failure t('manage.error_loading_config', :error => e.to_s)
        end
      end
      
    end
  end
end
