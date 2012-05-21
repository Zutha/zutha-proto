
$(function(){
// Events

	// Vote Up
	$(document).on('ajax:beforeSend', '.vote.up', function(event, xhr, settings) {
		parent = $(this).parents('.item');
		ubObj = $('#balance');
		ub = parseFloat(ubObj.html());
		if(ub >= 5){
			amount = 1;
		} else {
			amount = 0.1;
		}
		if(ub >= 0.1){
			ubNew = roundTo(ub - amount,2);
			urObj = parent.find('.user-rating');
			urNew = roundTo(parseFloat(urObj.html()) + amount,2);
			iwObj = parent.find('.item-worth');
			iwNew = roundTo(parseFloat(iwObj.html()) + amount,2);
			params = "&amount="+amount+
					"&new_item_worth="+ iwNew+
					"&new_user_rating="+ urNew+
					"&new_user_balance="+ ubNew;
			settings.data = settings.data + params;
			iwObj.html( iwNew );	
			ubObj.html( ubNew );
			urObj.html( urNew );
		}
	});

	// Vote Down
	$(document).on('ajax:beforeSend', '.vote.down', function(event, xhr, settings) {
		parent = $(this).parents('.item');
		urObj = parent.find('.user-rating');
		ur = parseFloat(urObj.html());
		if(ur >= 1){
			amount = 1;
		} else {
			amount = ur;
		}
		if(ur > 0){		
			urNew = roundTo( ur - amount, 2 );
			iwObj = parent.find('.item-worth');
			iwNew = roundTo( parseFloat(iwObj.html()) - amount, 2 );
			ubObj = $('#balance');
			ubNew = roundTo( parseFloat(ubObj.html()) + amount, 2 )
			params = "&amount="+ amount+
					"&new_item_worth="+ iwNew+
					"&new_user_rating="+ urNew+
					"&new_user_balance="+ ubNew;
			settings.data = settings.data + params;
			iwObj.html( iwNew );	
			ubObj.html( ubNew );
			urObj.html( urNew );
		}
	});

	$(document).on('ajax:success', '.vote', function(event, data){
		var parent = $(this).parents('.item');
		
		item_worth = data.item_worth;
		user_rating = data.user_rating;
		user_balance = data.user_balance;

		if(item_worth) parent.find('.item-worth').html(data.item_worth);
		if(user_rating) parent.find('.user-rating').html(user_rating);
		if(user_balance) $('#balance').html(user_balance);
	});

	$(document).on('ajax:error', '.vote', function(event, xhr, status){
		data = jQuery.parseJSON(xhr.responseText);
		msg = data[status];;
		$('#flash').html("<div class='"+status+"'>" + msg + "</div>")
		$('#flash').delay(5000).fadeOut(2000)
	});

});

// Helpers
function roundTo(num, dec) {
	var result = Math.round(parseFloat(num)*Math.pow(10,dec))/Math.pow(10,dec);
	return result;
}
