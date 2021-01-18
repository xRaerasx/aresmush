module AresMUSH
  module Rpg
    def self.can_view_sheets?(enactor)
      return true if Global.read_config('rpg', 'public_sheets')
      enactor && enactor.has_permission?('rpg_admin')
    end
    
    def self.can_set_sheets?(enactor)
      enactor && enactor.has_permission?('rpg_admin')
    end
    
    def self.format_sheet_for_viewing(char)
      case Global.read_config('rpg', 'sheet_format')
      when 'text'
         Website.format_markdown_for_html(char.rpg_sheet)
       else
         char.rpg_sheet
       end
    end
    
    def self.format_sheet_for_editing(char)
      case Global.read_config('rpg', 'sheet_format')
      when 'text'
         Website.format_input_for_mush(char.rpg_sheet)
       else
         char.rpg_sheet
       end
    end
  end
end