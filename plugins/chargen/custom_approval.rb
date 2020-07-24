module AresMUSH
  module Chargen
    def self.custom_approval(char)
            
def self.custom_approval(char)
  faction = char.group("Venue")
  role = Role.find_one_by_name(venue)
  if (role)
    char.roles.add role
  end
end
      
    end
  end
end
