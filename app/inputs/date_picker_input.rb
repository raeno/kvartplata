class DatePickerInput < SimpleForm::Inputs::StringInput
  def input
    value = object.send(attribute_name) if object.respond_to? attribute_name
    format = options[:format] || :day_month_year
    input_html_options[:value] ||= I18n.localize(value, :format => format) if value.present?
    input_html_options[:type] = 'text'
    input_html_classes << 'datepicker'

    super
  end
end