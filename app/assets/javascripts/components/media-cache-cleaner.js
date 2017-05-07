function clear_media() {
	  if(document.getElementById('audio')) {
	    document.getElementById('audio').remove();
	  }
	  if(document.getElementById('stream')) {
	    document.getElementById('stream').remove();
	    delete player; 
	  }
}