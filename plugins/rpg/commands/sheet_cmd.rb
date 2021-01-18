module AresMUSH
  module Rpg
    class RpgSheetCmd
      include CommandHandler
      
      attr_accessor :target
      
      def parse_args
        self.target = !cmd.args ? enactor_name : titlecase_arg(cmd.args)
      end
      
      def check_permission
        return nil if self.target == enactor_name
        return nil if Rpg.can_view_sheets?(enactor)
        return t('rpg.no_permission_to_view_sheet')
      end
      
      def handle
        ClassTargetFinder.with_a_character(self.target, client, enactor) do |model|
          if (!model.rpg_sheet)
            client.emit_failure t('rpg.sheet_not_set', :name => model.name)
            return
          end
          
          template = SheetTemplate.new model, client
          client.emit template.render
        end
      end
    end
  end
end