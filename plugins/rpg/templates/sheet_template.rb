module AresMUSH
  module Rpg
    class SheetTemplate < ErbTemplateRenderer
      
      attr_accessor :char, :client
      
      def initialize(char, client)
        @char = char
        @client = client
        super File.dirname(__FILE__) + "/sheet.erb"
      end
     
      def approval_status
        Chargen.approval_status(@char)
      end
    
    end
  end
end