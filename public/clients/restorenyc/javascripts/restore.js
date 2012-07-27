$(document).ready(function() {
  $(".hide").css('display', 'none');
  $("#sub-nav ul").css('display', 'none');
  $("#sub-about").css('display', 'inline');
  $('.content').hide();
  $('#home').show();
  $("#main-nav ul li.main ul").css('display', 'none');
  //this function shows sub navigations on hover
  $("#main-nav li").click( );
  $("#main-nav li").hover(
    function(){ 
		id = $(this).attr("id");
		$(".hov").removeClass('hov');
		$("#sub-nav ul").css('display', 'none');
		show_id = "#sub-" + id;
		$(show_id).fadeIn("fast"); 
		$(this).addClass('hov');
	      }, 
    function() { } 
  );
  //this function shows clicked content
  $('.content-link').click ( 
    function() {
      $('.content').hide();
      id = $(this).attr("alt");
      id = id.replace(/\_/, '');
      id = '#' + id;
      $(id).fadeIn("fast"); 
    }
  );
});

/* 
Code Highlighting 
Courtesy of Dean Edwards star-light 
http://dean.edwards.name/my/behaviors/#star-light.htc
    - with jQuery methods added, of course
*/

