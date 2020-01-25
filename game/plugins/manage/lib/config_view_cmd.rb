module AresMUSH
  module Manage
    class ConfigViewCmd
      include AresMUSH::Plugin

      attr_accessor :section
      
      def setup_error_checkers
        self.class.must_be_logged_in
        self.class.argument_must_be_present "section", "config"
      end
      
      def want_command?(client, cmd)
        cmd.root_is?("config") && cmd.switch.nil? && !cmd.args.nil?
      end

      def crack!
        self.section = trim_input(cmd.args)
      end
      
      def check_section_exists
        return t('manage.invalid_config_section') if !Global.config.has_key?(self.section)
        return nil
      end
      
      # TODO - check permissions
      
      def handle
        title = t('manage.config_section', :name => self.section)
        text = PP.pp(Global.config[self.section], "")
        client.emit BorderedDisplay.text(text, title)
      end
    end
  end
end