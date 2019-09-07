$(document).on('turbolinks:load', function() {
  $('.delete_sound').click(function() {
    var current_sound = $(this).parents('.divTableRow')[0];
    // alert($(current_sound).attr('id'));
    if(confirm('Are you sure?')) {
      $.ajax({
        url: '/sounds/' + $(current_sound).attr('id').split('_')[1] + '/deleted_status',
        type: 'POST',
        data: { _method: 'PUT' },
        success: function(result) {
          $(current_sound).remove();
          console.log(result);
        }
      });
    }
  });

  $('.hard_sound_delete').click(function() {
    var current_sound = $(this).parents('.divTableRow')[0];
    if(confirm('Are you sure? It can be dangerous 💀')) {
      $.ajax({
        url: '/sounds/' + $(current_sound).attr('id').split('_')[1],
        type: 'POST',
        data: { _method: 'DELETE' },
        success: function(result) {
          $(current_sound).remove();
          console.log(result);
        }
      });
    }
  });
});
