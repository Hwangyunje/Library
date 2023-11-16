let maxLength = 50;

let role = $('#role').data('role')
console.log("role : "+role);

let text = $('#board_title').html()

if (text.length > maxLength) {
  text = text.substring(0, maxLength) + "...";
  $('#board_title').html(text);
}
