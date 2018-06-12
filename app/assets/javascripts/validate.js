$(document).ready(function () {
    $("#article_title").on("keyup", function () {
        if ($(this).val() !== "" && $(this).val().length >= 3 && $("#article_description").val() !== "" && $("#article_description").val().length >= 10) {
            $("#form_submit").removeAttr("disabled");
        } else {
            $("#form_submit").prop("disabled", true);
        }
    });

    $("#article_description").on("keyup", function () {
        if ($(this).val() !== "" && $(this).val().length >= 10 && $("#article_title").val() !== "" && $("#article_title").val().length >= 3) {
            $("#form_submit").removeAttr("disabled");
        } else {
            $("#form_submit").prop("disabled", true);
        }
    });

});
