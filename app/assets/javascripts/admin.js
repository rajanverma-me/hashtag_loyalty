$(document).ready(function(){
  $('form.upload input').change(function () {
    $('form p').text(this.files.length + " file(s) selected");
  });
});