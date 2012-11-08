// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.effects.highlight
//= require twitter/bootstrap
//= require_tree .


$(function() {

  $('abbr.timeago').timeago()


  // Gist

  function rmBlob() {
    // TODO: implment "undo"
    $(this).parents('.control-group:first').
      find('*[name]').
        attr('disabled', 'disabled').
        end().
      hide()

  }

  function addBlob() {
    // TODO: implment "undo"
    var t = $('form .empty')
    var template = t.html()
    var blob = $(template).insertBefore(t)
    $(blob).
      effect('highlight', {}, 3000)
  }

  $('form span[rel=rmBlob]').click(rmBlob)
  $('form span[rel=addBlob]').click(addBlob)

})
