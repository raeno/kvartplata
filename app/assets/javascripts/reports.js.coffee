$ ->
  $('.icon-columns').hide()

  $('.carousel').on 'slid', ->
    $('.report-type-switcher .icon-table').toggle()
    $('.report-type-switcher .icon-columns').toggle()


  $('.report-type-switcher').click ->
    $('.carousel').carousel('next').carousel('pause')

  $('.print-report').click ->
    $('table.item').show()
    window.print()
    $('table.item').css('display','')
