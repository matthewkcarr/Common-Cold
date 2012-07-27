// Express Install
// Copyright(c) 2005-2006 Adobe Macromedia Software, LLC. All rights reserved.

System.security.allowDomain("fpdownload.macromedia.com");

// add a random number to the end of the request to avoid caching the SWF
var cacheBuster = Math.random();
var updateSWF = "http://fpdownload.macromedia.com/pub/flashplayer/update/current/swf/autoUpdater.swf?"+cacheBuster;
loaderClip.loadMovie(updateSWF);

var id = setInterval(checkLoaded, 10);
function checkLoaded()
{
	if ( loaderClip.startUpdate.toString() == "[type Function]")
	{
		clearInterval(id);
		loadComplete();		
	}
}

function loadComplete()
{
	loaderClip.redirectURL = _root.MMredirectURL;
	loaderClip.MMplayerType = _root.MMplayerType;
	loaderClip.MMdoctitle = _root.MMdoctitle;
	loaderClip.startUpdate();
}