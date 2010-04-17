$(document).ready(function() {
   $('#bookmark_tags').autocomplete('/tags/search/', {
        width: 320,
        max: 10,
        highlight: false,
        multiple: true,
        multipleSeparator: ",",
        scroll: true,
        scrollHeight: 300
    });
});