# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require_tree .
#= require rails.validations
#= require rails.validations.simple_form
$ ->

  $('.login-form .btn').click ->
    $('.actions').hide()
    $('.login-form .loading').show()

  $('.login-form').bind 'ajax:success',(e,data, status, xhr) ->
    if data.status == 'redirect'
      window.location.href = data.status.to
    else if data.status == 'error'
      $('.login-form .error-message').html('<p>' + data.errors + '</p>')
      $('.actions').show()
      $('.login-form .loading').hide()

