module AresMUSH

  class Character
    attribute :pose_nospoof, :type => DataType::Boolean
    attribute :pose_autospace, :default => "%r"
    attribute :pose_quote_color
    attribute :pose_nudge, :type => DataType::Boolean, :default => true
    attribute :pose_nudge_muted, :type => DataType::Boolean
  end
  
  class Room
    attribute :pose_order, :type => DataType::Hash, :default => {}
    
    def update_pose_order(name)
      order = pose_order
      order[name] = Time.now.to_s
      update(pose_order: order)
    end
    
    def remove_from_pose_order(name)
      order = pose_order
      order.delete name
      update(pose_order: order)
    end
    
    def sorted_pose_order
      pose_order.sort_by { |name, time| Time.parse(time) }
    end
    
  end
  
end