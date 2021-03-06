module AresMUSH
  class FS3MeritSkill < Ohm::Model
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
      when 2
        return "%xg@@%xn"
      when 3
        return "%xg@@%xy@%xn"
      when 4
        return "%xg@@%xy@@%xn"
      when 5
        return "%xg@@%xy@@%xr@%xn"
      end
    end
    
    def rating_name
      case rating
      when 0
        return t('fs3skills.unskilled_rating')
      when 1
        return t('fs3skills.everyman_rating')
      when 2
        return t('fs3skills.competent_rating')
      when 3
        return t('fs3skills.good_rating')
      when 4
        return t('fs3skills.great_rating')
      when 5
        return t('fs3skills.exceptional_rating')
      end
    end
  end
end