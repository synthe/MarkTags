$(document).ready(function() {
   $('#bookmark_tags').autocomplete('/tags/search/1/', {
        width: 320,
        max: 10,
        highlight: false,
        multiple: true,
        multipleSeparator: ",",
        scroll: true,
        scrollHeight: 300
    });
});