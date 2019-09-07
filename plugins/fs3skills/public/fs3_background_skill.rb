module AresMUSH
  class FS3BackgroundSkill < Ohm::Model
    include ObjectModel
    include LearnableAbility
    
    reference :character, "AresMUSH::Character"
    attribute :name
    attribute :rating, :type => DataType::Integer, :default => 0
    
    index :name
    
    def print_rating
      case rating
      when 0
        return ""
      when 1
        return "%xg@%xn"
      end
    end
    
    def rating_name
      case rating
      when 0
        return t('fs3skills.unskilled_rating')
      when 1
        return t('fs3skills.everyman_rating')
      end
    end
  end
end