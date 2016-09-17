
$( document ).ready(function() {
  $( "#amount" ).change(function() {
    $("#target-button").data('amount', this.val()); 
  });
});