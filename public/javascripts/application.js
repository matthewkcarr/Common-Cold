// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


var images = new Array();
var is_video = false;
var is_downloads = false;
var videos = new Array();
var v_prep = new Hash();
function construct_set( type, client, link, size) {
  images = new Array();
  videos = new Array();
  num = parseInt(size);
  for ( var i = 1; i< num + 1; i++ ) {
    images[i] = '/images/' + type + '/' + client + '/' + i + '.jpg';
    if( is_video ) { 
      videos[i - 1] = v_prep[client][i - 1];
    }
  }
  nlink = '&nbsp;';
  if( link != '') {
    nlink = link;
  }
  new_link = '<a href="http://' + link + '">' + nlink + '</a>';
  $('content-menu').empty();
  $('content-link').update(new_link);
  $('content-link').show();
}

function show_pic(num) {
  $('content').setStyle({
    backgroundImage: 'url(' + images[num] + ')',
    visibility: 'visible'
  });
  links = "";
  for( var i = 1; i < images.size(); i++) {
    if( i == num) 
    {
      links = links + '<span class="menu">' + i + '</span>';
    } 
    else
    {
      links = links + '<a href="#" class="menu" onclick="show_pic(' + i + ')">' + i + '</a>';
    }
  }
  if( (images.size() -1) == 1 ) {
    links = '';
  }

  $('content-menu').empty();
  $('content-menu').update(links);
  $('content-menu').show();
  if(is_downloads) {
    $('downloads-links').show();
  }
  else {
    $('downloads-links').hide();
  }
  if(is_video) {
    $('content-video').empty();
    $('content-video').update(videos[num - 1]);
    $('content-video').setStyle({
      visibility: 'visible'
    });
  }
  else {
  $('content-video').setStyle({
      visibility: 'hidden'
    });
  }
}

function show_content(type, client, link, size) {
  $('content').show();
  construct_set( type, client, link, size);
  show_pic(1);
}

function commoncold_DoFSCommand(command, args) {
 strings =  args.split(',');
 if( strings[0] == 'downloads') {
   is_downloads = true;
 }
 else {
   is_downloads = false;
 }
 if( strings[0] == 'video') {
   is_video = true;
 }
 else {
   is_video = false;
 }
 if (command == "show_content") {
   show_content(strings[0], strings[1], strings[2], strings[3]);
 }
}

v_prep['GO'] = new Array();
v_prep['GO'][0] = '<script type="text/javascript"> var so = new SWFObject("/images/video/GO/1.swf", "1", "470", "380", "8", "#ffffff"); so.write("content-video"); </script>';
v_prep['S4S'] = new Array(); 
v_prep['S4S'][0] = '<script type="text/javascript"> var so = new SWFObject("/images/video/S4S/1.swf", "1", "470", "380", "8", "#ffffff"); so.write("content-video"); </script>';
v_prep['S4S'][1] = '<script type="text/javascript"> var so = new SWFObject("/images/video/S4S/2.swf", "2", "470", "380", "8", "#ffffff"); so.write("content-video"); </script>';
v_prep['S4S'][2] = '<script type="text/javascript"> var so = new SWFObject("/images/video/S4S/3.swf", "3", "470", "380", "8", "#ffffff"); so.write("content-video"); </script>';

v_prep['DISPLACE_ME'] = new Array();
v_prep['DISPLACE_ME'][0] = '<script type="text/javascript"> var so = new SWFObject("/images/video/DISPLACE_ME/1.swf", "1", "470", "380", "8", "#ffffff"); so.write("content-video"); </script>';

v_prep['INVISIBLE_CHILDREN'] = new Array();
v_prep['INVISIBLE_CHILDREN'][0] = '<script type="text/javascript"> var so = new SWFObject("/images/video/INVISIBLE_CHILDREN/1.swf", "1", "470", "380", "8", "#ffffff"); so.write("content-video"); </script>';
v_prep['INVISIBLE_CHILDREN'][1] = '<script type="text/javascript"> var so = new SWFObject("/images/video/INVISIBLE_CHILDREN/2.swf", "2", "470", "380", "8", "#ffffff"); so.write("content-video"); </script>';
