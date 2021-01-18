module AresMUSH
  module Rpg
    class RpgSheetNotesCmd
      include CommandHandler
      
      attr_accessor :target, :notes
      
      def parse_args
        if (Rpg.can_set_sheets?(enactor) && cmd.args =~ /\=/)
          args = cmd.parse_args(ArgParser.arg1_equals_arg2)
          self.target = args.arg1
          self.notes = args.arg2
        else
          self.target = enactor_name
          self.notes = cmd.args
        end
      end
      
      def required_args
        [ self.target ]
      end
      
      def check_permission
        return nil if self.target == enactor_name
        return nil if Rpg.can_set_sheets?(enactor)
        return t('dispatcher.not_allowed')
      end
      
      def handle
        ClassTargetFinder.with_a_character(self.target, client, enactor) do |model|
          
          if (!Chargen.can_manage_apps?(enactor))
            error = Chargen.check_chargen_locked(model)
            if (error)
              client.emit_failure error
              return
            end
          end
          
          model.update(rpg_sheet_notes: self.notes)
          client.emit_success t('rpg.notes_set')
        end
      end
    end
  end
end