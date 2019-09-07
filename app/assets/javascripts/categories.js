$(document).on('turbolinks:load', function() {
  let cat_sound = document.addEventListener('trix-attachment-remove', function(event) {
    var updateSoundPosition;
    console.log()
    // attachment = event.attachment;
    // return deleteFile(attachment);
  });

  updateSoundPosition = function(n) {
    return $.ajax({
      type: 'PUT',
      url: `/categories/${id}/edit/categories/${csId}/update_position/` + n,
      cache: false,
      contentType: false,
      processData: false
    });
  };
});
