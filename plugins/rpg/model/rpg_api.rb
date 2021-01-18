module AresMUSH
  module Rpg
    def self.save_char(char, chargen_data)
      traits = {}
      
      sheet = chargen_data[:rpg][:sheet]
      notes = chargen_data[:rpg][:sheet_notes]

      
      char.update(rpg_sheet: Website.format_input_for_mush(sheet))
      char.update(rpg_sheet_notes: Website.format_input_for_mush(notes))
      
      return []
    end
    
    def self.get_sheet_for_web_viewing(char, viewer)
      is_owner = (viewer && viewer.id == char.id)
      show_sheet = Rpg.can_view_sheets?(viewer) || is_owner
    
      return { can_view: false } if !show_sheet
    
      {
        sheet: Rpg.format_sheet_for_viewing(char),
        sheet_notes: Website.format_markdown_for_html(char.rpg_sheet_notes),
        sheet_format: Global.read_config('rpg', 'sheet_format'),
        can_view: true
      }
    end
    
    def self.get_sheet_for_web_editing(char, viewer)
      is_owner = (viewer && viewer.id == char.id)
      show_sheet = Rpg.can_view_sheets?(viewer) || is_owner
    
      return {} if !show_sheet
    
      {
        sheet: Rpg.format_sheet_for_editing(char),
        sheet_notes: Website.format_input_for_html(char.rpg_sheet_notes),
        sheet_format: Global.read_config('rpg', 'sheet_format')
      }
    end
  end
end