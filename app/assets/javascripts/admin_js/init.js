$(function() {
    $('.help').tooltip({
        delay: 0,
        track: true,
        showURL: false,
        showBody: " # "
    });
});

$(function() {
    $('.mceEditor').tinymce({
        language: "pl",
        theme: "advanced",
        theme_advanced_toolbar_location: "top",
        paste_auto_cleanup_on_paste: true,
        plugins: "paste",
        cleanup: true,
        theme_advanced_buttons3_add: 'pastetext,pasteword,selectall'
    });
});