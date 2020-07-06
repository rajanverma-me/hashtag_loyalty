$(document).ready(function(){
	$(".dashboard select").on("change", function(){
		duration = $(this).val()
		console.log("adasd")
		$.ajax({
			url: "/transactions",
			method: "get",
			data: {
				duration: duration
			},
			success: function(res){
				
			}

		})
	})

});