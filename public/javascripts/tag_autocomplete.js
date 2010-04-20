$(document).ready(function() {
   $('#bookmark_tags').autocomplete('/tags/search/', {
        width: 320,
        max: 20,
        highlight: false,
        multiple: true,
        multipleSeparator: ",",
        scroll: true,
        scrollHeight: 300
    });
});