module AresMUSH
  module WoD2e
    def self.plugin_dir
      File.dirname(__FILE__)
    end
    
   def self.shortcuts
      Global.read_config("wod2e", "shortcuts")
    end
  end
end