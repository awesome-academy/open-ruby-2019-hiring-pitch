
$(document).on('turbolinks:load', function(){
  $(".my-rating-9").starRating({
    initialRating: 0,
    disableAfterRate: false,
    starSize: 50,
    useFullStars: true,
    callback: function(currentRating, $el){
      pitch_id = $('#pitch_id').val()
      $.ajax({
        url: "/ratings",
        type: "POST",
        data: {star : currentRating,
               pitch_id: pitch_id}
    });
   }
  });
});
