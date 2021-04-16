jQuery(function() {

  function enableDatepicker() {
    $('.bootstrap-datepicker').datepicker({
      format: 'yyyy-mm-dd'
    });
    if($("#yeild_start_date").length){
    	$(".bootstrap-datepicker-start").datepicker('setDate', $("#yeild_start_date").val())	
    }
  }

  enableDatepicker()

  $(document).ajaxSuccess(function() {
    enableDatepicker()
  });
});
