var weather_success = function(data){

	var degrees_farenheit = data.query.results.channel.item.condition.temp; 

	var degrees_celcius = ((degrees_farenheit-32)*5)/9
	var location = data.query.results.channel.location.city; 
	$(".weather__location").html(location);
	$(".weather__degrees").html(Math.ceil(degrees_celcius)); 



}

var url = 'https://query.yahooapis.com/v1/public/yql?q='; 
	var query = 'select * from weather.forecast where woeid in (SELECT woeid FROM geo.places WHERE text="(22.1354,-100.9855)")'; 
	var format = '&format=json';
	var appid = '&appid=dj0yJmk9RHRQU01NZUFlQWdNJmQ9WVdrOWVYWXlVWGxQTXpBbWNHbzlNQS0tJnM9Y29uc3VtZXJzZWNyZXQmeD0zOA--'; 
	var request = url + query + format + appid; 
	$.getJSON(request, weather_success); 