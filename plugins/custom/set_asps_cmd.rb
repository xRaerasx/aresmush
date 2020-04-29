module AresMUSH
  module Custom
    class SetAspirationsCmd
      include CommandHandler
      
      attr_accessor :aspirations

      def parse_args
       self.asps = trim_arg(cmd.args)
      end

      def handle
        enactor.update(aspirations: self.asps)
        client.emit_success "Aspirations set!"
      end
    end
  end
end