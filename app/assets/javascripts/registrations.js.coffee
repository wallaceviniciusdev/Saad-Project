jQuery ->
    $('#_campu_id').parent().hide()
    $('#_center_id').parent().hide()
    $('#user_course_id').parent().hide()

    campus = $('#_campu_id').html()
    centers = $('#_center_id').html()
    courses = $('#user_course_id').html()


    $('#user_institution_id option:first').attr("selected", "selected");
    $('#_campu_id').prepend("<option value=''></option>")
    $('#_campu_id option:first').attr("selected", "selected");
    $('#_center_id').prepend("<option value=''></option>")
    $('#_center_id option:first').attr("selected", "selected");
    $('#user_course_id').prepend("<option value=''></option>")
    $('#user_course_id option:first').attr("selected", "selected");


    $('#user_institution_id').on "change", ->
        institution = $('#user_institution_id option:selected').text()
        options = $(campus).filter("optgroup[label='#{institution}']").html()
        if options
            $('#_campu_id').html(options)
            $('#_campu_id').prepend("<option value=''></option>")
            $('#_campu_id option:first').attr("selected", "selected");
            $('#_campu_id').parent().show()
        else
            $('#_campu_id').empty()
            $('#_center_id').empty()
            $('#user_course_id').empty()


    $('#_campu_id').on "change", ->
        campu = $('#_campu_id option:selected').text()
        options = $(centers).filter("optgroup[label='#{campu}']").html()
        if options
            $('#_center_id').html(options)
            $('#_center_id').prepend("<option value=''></option>")
            $('#_center_id option:first').attr("selected", "selected");
            $('#_center_id').parent().show()
        else
            $('#_center_id').empty()
            $('#user_course_id').empty()

    $('#_center_id').on "change", ->
        center = $('#_center_id option:selected').text()
        options = $(courses).filter("optgroup[label='#{center}']").html()
        if options
            $('#user_course_id').html(options)
            $('#user_course_id').prepend("<option value=''></option>")
            $('#user_course_id option:first').attr("selected", "selected");
            $('#user_course_id').parent().show()
        else
            $('#user_course_id').empty()