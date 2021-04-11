module AresMUSH
  module Tinker
    class TinkerCmd
      include CommandHandler
      
      def check_can_manage
        return t('dispatcher.not_allowed') if !enactor.has_permission?("tinker")
        return nil
      end
      
      def handle
       scene = Scene.all.select { |s| PlotLink.find_by_scene(s).empty? && s.shared }
       scene.edit(plot: "14")
       client.emit "Done!"
      end

    end
  end
end
