# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $(window).scroll ->
    if $(@).scrollTop()
      $('.toTop').fadeIn()
    else
      $('.toTop').fadeOut()

  $('.toTop').click ->
    $('.toTop').hide()
    $('body').scrollTop(0)

  showMoreLink = $('.show-more-tariffs')
  showMoreLink.click ->
    $('.toTop').hide()
    $('.other-tariffs').toggle()

    if showMoreLink.attr('data-status') == 'collapsed'
      $('.other-tariffs').append showMoreLink
      showMoreLink.text '▴ свернуть'
      showMoreLink.attr('data-status','expanded')
    else
      $('.other-tariffs').before showMoreLink
      showMoreLink.text '▾ показать все'
      showMoreLink.attr('data-status','collapsed')

