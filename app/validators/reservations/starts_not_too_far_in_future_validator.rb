module Reservations
  class StartsNotTooFarInFutureValidator < ActiveModel::Validator

    def validate(record)
      if record.starts_at && record.starts_at > 3.hours.from_now
        record.errors.add(:starts_at, "can't be more than 3 hours in the future for non-donators")
      end
    end

  end
end