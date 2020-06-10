module AresMUSH
  module Scenes
    
    def self.custom_char_card_fields(char, viewer)

	{
     background: Website.format_input_for_html(char.background)
	}
    
    end
  end
end
