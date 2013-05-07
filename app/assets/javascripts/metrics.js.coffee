# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
##
$ ->
  window.ClientSideValidations.validators.remote['previous_record_value'] = (element) ->
    if ($.ajax
          url: '/validators/previous_record',
          data:
            metric:  element.val()
            attr: element.attr('name').match(/\w*[(\w+)]/g)[1]
          async: false).status == 404
      return '\u25B4 не должно быть меньше прошлого месяца'

  $('#monthsDatepicker').datepicker(
    'language': 'ru',
    'viewMode': 'months',
    'minViewMode': 'months',
    'format': 'mm/yyyy',
    'markedDates': $('#metrics_with_data').attr('data-metrics'),
    'autoclose': true
  )