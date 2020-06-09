module AresMUSH
  module Custom
    class SetAspirationsCmd
      include CommandHandler
      
      attr_accessor :aspirations

      def parse_args
       self.aspirations = trim_arg(cmd.args)
      end

      def handle
        enactor.update(aspirations: self.aspirations)
        client.emit_success "Aspirations set!"
		Website.format_input_for_html(char.aspirations)
      end
    end
  end
end