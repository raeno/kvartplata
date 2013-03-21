# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('.icon-columns').hide()
  $('.carousel').on 'slid', ->
    $('.report-type-switcher .icon-table').toggle()
    $('.report-type-switcher .icon-columns').toggle()


  $('.report-type-switcher').click ->
    $('.carousel').carousel('next').carousel('pause')