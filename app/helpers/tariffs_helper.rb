module TariffsHelper
  def current_tariff
    @current_tariff ||= Tariff.where('start_date <= ?',Date.today).order('start_date ASC').last
  end

  def previous_tariff
    @previous_tariff ||= Tariff.where('start_date < ?',current_tariff.start_date).order('start_date ASC').last
  end
end
