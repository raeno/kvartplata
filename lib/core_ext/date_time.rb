class DateTime
  def round_to_month
    change(:day => 1).beginning_of_day
  end
end