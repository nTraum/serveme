module Reservations
  class MapIsNotMvmValidator < ActiveModel::Validator

    def validate(record)
      if record.first_map && record.first_map.match(/mvm_.*/)
        record.errors.add(:first_map, "you can't play MvM on our servers")
      end
    end

  end
end