module AresMUSH
  module Places
    class PlaceEmitCmd
      include CommandHandler
      
      attr_accessor :name, :emit

      def parse_args
        args = cmd.parse_args(ArgParser.arg1_equals_arg2)
        self.name = titlecase_arg(args.arg1)
        self.emit = args.arg2
      end
      
      def required_args
        {
          args: [ self.name, self.emit ],
          help: 'places'
        }
      end
      
      def handle
        place = enactor_room.places.find(name: self.name).first
        
        if (!place)
          client.emit_failure t('places.place_doesnt_exit')
          return
        end
        
        
        Pose::Api.emit(enactor, self.emit, self.name)
      end
    end
  end
end
