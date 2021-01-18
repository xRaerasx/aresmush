$:.unshift File.dirname(__FILE__)

module AresMUSH
     module Rpg

    def self.plugin_dir
      File.dirname(__FILE__)
    end

    def self.shortcuts
      Global.read_config("rpg", "shortcuts")
    end

    def self.get_cmd_handler(client, cmd, enactor)
      case cmd.root
      when "sheet"
        case cmd.switch
        when "set"
          return RpgSheetSetCmd
        when "notes"
          return RpgSheetNotesCmd
        else
          return RpgSheetCmd
        end
      end
      nil
    end

    def self.get_event_handler(event_name)
      nil
    end

    def self.get_web_request_handler(request)
      nil
    end

  end
end
