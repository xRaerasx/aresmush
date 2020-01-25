module AresMUSH
  module Describe
    class LookCmd
      include AresMUSH::Plugin
      
      attr_accessor :target
            
      def initialize
        RendererFactory.build_renderers
        super
      end
      
      def setup_error_checkers
        self.class.must_be_logged_in
        self.class.no_switches
      end
      
      def want_command?(client, cmd)
        cmd.root_is?("look")
      end
      
      def crack!
        cmd.crack!(/(?<target>.+)/)
        self.target = trim_input(cmd.args.target) || 'here'
      end
      
      def handle
        VisibleTargetFinder.with_something_visible(target, client) do |model|
          desc = Describe.get_desc(model)
          client.emit(desc)
        end
      end      
    end
  end
end
