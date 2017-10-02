App.messages = App.cable.subscriptions.create('LatestNewsChannel', {  
  received: function(data) {
  	console.log("lalala");
  	console.log(data);
    $("#latest_news").removeClass('hidden')
    console.log("lalala render");
  	console.log(data);
  	jsondata = JSON.stringify(data);
  	console.log(jsondata);
  	var parsed = JSON.parse(jsondata);

  	var arr = [];

	for(var x in parsed){
		console.log(x);
		arr.push(parsed[x]);
	}

	console.log(arr);
	console.log("ARRAY L " + arr.length);
	console.log(arr[0].name);

	for(var i=0; i<= arr.length; i++){
		console.log("NAME");

		console.log(x[i]);
	}

	for(var article in arr){
		console.log("ARTICLE");
		
		console.log(article);
	}

	console.log("DATA L " + arr.length);

	for(var i=0; i<= data.length; i++){
		console.log("hrfiuerifhioerfioh");
		console.log(x[i].name);
		console.log(x[i]);
	}
  

    return $('#latest_news').append(this.renderMessage(data));
  },

  renderMessage: function(data) {
  }
});