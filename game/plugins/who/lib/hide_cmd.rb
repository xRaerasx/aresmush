module AresMUSH
  module Who
    class HideCmd
      include AresMUSH::Plugin

      def setup_error_checkers
        self.class.no_args
        self.class.no_switches
        self.class.must_be_logged_in
      end
      
      def want_command?(client, cmd)
         cmd.root_is?("hide") || cmd.root_is?("unhide")
      end
      
      def handle
        if cmd.root_is?("unhide")
          client.emit_success(t('who.hide_disabled'))
          client.char.hidden = false
        else
          client.emit_success(t('who.hide_enabled'))
          client.char.hidden = true
        end            
      end      
    end
  end
end
