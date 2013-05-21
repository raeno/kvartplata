class PreviousMonthValueValidator < ActiveModel::EachValidator
  def validate_each(record, attr, value)
    unless record.previous_month.nil?
      unless value >= record.previous_month.send(attr)
        record.errors.add(attr, "must be greater than #{record.previous_month.send(attr)}")
      end
    end

  end
end

module ActiveModel::Validations::HelperMethods
  def validates_that_greater_than_a_previous_value(*attr_names)
    validates_with PreviousMonthValueValidator, _merge_attributes(attr_names)
  end
end