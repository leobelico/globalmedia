var rates = function(data) {
  fx.rates = data.rates
  var rate = fx(1).from("USD").to("MXN")
  $(".exchange-rate.dollar").find(".exchange-rate__rate").html("$" + rate.toFixed(2));
  $(".exchange-rate.euro").find(".exchange-rate__rate").html("$" + fx(1).to("MXN").toFixed(2));
}

// $.getJSON("https://api.fixer.io/latest", rates); 
