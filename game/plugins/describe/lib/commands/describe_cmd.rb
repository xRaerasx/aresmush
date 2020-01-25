module AresMUSH

  module Describe
    class DescCmd
      include AresMUSH::Plugin
      
      attr_accessor :target, :desc

      def setup_error_checkers
        self.class.must_be_logged_in
        self.class.no_switches
        self.class.argument_must_be_present "target", "desc"
        self.class.argument_must_be_present "desc", "desc"
      end
      
      # TODO - Permissions
      
      def want_command?(client, cmd)
        cmd.root_is?("describe") || cmd.root_is?("shortdesc")
      end

      def crack!
        cmd.crack!(/(?<target>[^\=]+)\=(?<desc>.+)/)
        self.target = trim_input(cmd.args.target)
        self.desc = cmd.args.desc
      end
      
      def handle
        VisibleTargetFinder.with_something_visible(target, client) do |model|
          
          if (!Describe.can_describe(client, model))
            client.emit_failure(t('describe.not_allowed'))
          end
          
          if (cmd.root_is?("shortdesc"))
            model.shortdesc = desc
          else
            Describe.set_desc(model, desc)
          end
          client.emit_success(t('describe.desc_set', :name => model.name))
        end
      end
        
    end
  end
end
