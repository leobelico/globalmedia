console.log("holllaaa");
App.messages = App.cable.subscriptions.create('LatestNewsChannel', {  
	connected: function() {
		console.log("connected");
	},
  received: function(data) {
  	console.log("received");
    return $('#latest_news').append(this.renderMessage(data));
  },

  renderMessage: function(data) {
  	console.log("diehfi");
    console.log(data);
  	console.log("rendering");
  	update_info(data.article_name, data.section)
    // return '<p class="article__title">' + data.article_name.substring(0,55) + '<br><span>' + data.section + '</span></p>';
  }
});