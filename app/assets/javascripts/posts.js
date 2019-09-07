$(document).on('turbolinks:load', function() {
  $('.unpublish_post').click(function() {
    var current_post = $(this).parents('.post')[0];
    $.ajax({
      url: '/posts/' + $(current_post).attr('id').split('_')[1] + '/publish_status',
      type: 'POST',
      data: { _method: 'PUT' },
      success: function(result) {
        $(current_post).remove();
        console.log(result);
      }
    });
  })

  $('.delete_post').click(function() {
    var current_post = $(this).parents('.post')[0];
    if(confirm('Are you sure? It can be dangerous 💀')) {
      $.ajax({
        url: '/posts/' + $(current_post).attr('id').split('_')[1],
        type: 'POST',
        data: { _method: 'DELETE' },
        success: function(result) {
          $(current_post).remove();
          console.log(result);
        }
      });
    }
  });
});
