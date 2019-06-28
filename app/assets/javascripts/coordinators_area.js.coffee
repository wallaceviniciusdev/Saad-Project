# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
    $('.note_div').hide()
    $('#_users_id').parent().hide()
    classrooms = $('#_classroom_id').html()
    users = $('#_users_id').html()
    $('#_classroom_id').prepend("<option value='todos'>Todas</option>")
    $('#_classroom_id option:first').attr("selected", "selected");
    $('#_users_id').prepend("<option value='todos'>Todos</option>")
    $('#_users_id option:first').attr("selected", "selected");

    $('#_classroom_id').on "change", ->
        classroom = $('#_classroom_id option:selected').text()
        options = $(users).filter("optgroup[label='#{classroom}']").html()
        if options
            $('#_users_id').html(options)
            $('#_users_id').prepend("<option value='todos'>Todos</option>")
            $('#_users_id option:first').attr("selected", "selected");
            $('#_users_id').parent().show()
        else
            $('#_users_id').empty()
            $('#_users_id').parent().hide()
