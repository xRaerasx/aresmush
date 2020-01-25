module AresMUSH

  module Describe
    class OutfitSetCmd
      include AresMUSH::Plugin
      
      attr_accessor :name, :desc
      
      def setup_error_checkers
        self.class.must_be_logged_in
        self.class.argument_must_be_present "name", "outfit"
        self.class.argument_must_be_present "desc", "outfit"
      end
      
      def want_command?(client, cmd)
        cmd.root_is?("outfit") && cmd.switch_is?("set")
      end
      
      def crack!
        cmd.crack!(/(?<name>[^\=]+)\=(?<desc>.+)/)
        self.name = titleize_input(cmd.args.name)
        self.desc = cmd.args.desc
      end
      
      def handle
        client.char.outfits[self.name] = self.desc
        client.char.save!
        client.emit_success t('describe.outfit_set')
      end
    end
  end
end
