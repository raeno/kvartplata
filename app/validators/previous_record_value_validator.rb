class PreviousRecordValueValidator < ActiveModel::EachValidator
  def validate_each(record, attr, value)
    unless record.previous_record.nil?
      unless value >= record.previous_record.send(attr)
        record.errors.add(attr, "must be greater than #{record.previous_record.send(attr)}")
      end
    end

  end
end

module ActiveModel::Validations::HelperMethods
  def validates_that_greater_than_a_previous_value(*attr_names)
    validates_with PreviousRecordValueValidator, _merge_attributes(attr_names)
  end
end