module ActiveSupport
  class TimeWithZone
    def round_to_month
      change(:day => 1).beginning_of_day
    end
  end
end