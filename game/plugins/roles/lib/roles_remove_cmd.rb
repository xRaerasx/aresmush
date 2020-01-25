module AresMUSH
  module Roles
    class RoleRemoveCmd
      include AresMUSH::Plugin
      
      attr_accessor :name
      attr_accessor :role
      
      def initialize
        self.class.must_be_logged_in
        self.class.argument_must_be_present "name", "role"
        self.class.argument_must_be_present "role", "role"
        self.class.must_have_role Roles.can_assign_roles
      end

      def want_command?(client, cmd)
        cmd.root_is?("role") && cmd.switch_is?("remove")
      end

      def crack!
        cmd.crack!(/(?<name>[^\=]+)\=(?<role>.+)/)
        self.name = trim_input(cmd.args.name)
        self.role = trim_input(cmd.args.role)
      end
      
      def handle        
        ClassTargetFinder.with_a_character(self.name, client) do |char|

          if (!char.has_role?(self.role))
            client.emit_failure(t('roles.role_not_assigned'))
            return  
          end
        
          char.roles.delete(self.role.downcase)
          char.save!
          client.emit_success t('roles.role_removed', :name => self.name, :role => self.role)
        end
      end
    end
  end
end
