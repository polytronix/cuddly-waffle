jQuery(function() {
  $("[data-toggle='popover']").popover({
    html: true,
    sanitize: false,
  });
  $("[data-toggle='tooltip']").tooltip();
});
