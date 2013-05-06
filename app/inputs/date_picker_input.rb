class DatePickerInput < SimpleForm::Inputs::StringInput
  def input
    value = object.send(attribute_name) if object.respond_to? attribute_name
    input_html_options[:value] ||= I18n.localize(value, :format => :day_month_year) if value.present?
    input_html_options[:type] = 'text'
    input_html_classes << 'datepicker'

    super
  end
end