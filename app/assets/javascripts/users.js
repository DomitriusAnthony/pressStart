$(document).ready(function(){
$.ajax({
		type:"GET",
		url:"https://api.twitch.tv/kraken/streams/juicetrades",
		headers:{
			"Client-ID": "nf35s3wvwtxyum14ny3b272q7jid2c"
		},
		success: function(data1){
		if(data1.stream === null){
			$("#stream-status").html("OFFLINE")
		}
		else{
			$("#stream-status").html("ONLINE")
		}
		}
	})
		
})