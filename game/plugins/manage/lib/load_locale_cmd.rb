module AresMUSH
  module Manage
    class LoadLocaleCmd
      include AresMUSH::Plugin

      def setup_error_checkers
        self.class.must_be_logged_in
      end
      
      def want_command?(client, cmd)
        cmd.root_is?("load") && cmd.args == "locale"
      end

      # TODO - check permissions
      
      def handle
        begin
          Global.locale.load!
          client.emit_success t('manage.locale_loaded')
        rescue Exception => e
          client.emit_failure t('manage.error_loading_locale', :error => e.to_s)
        end
      end
    end
  end
end
