
$(function(){
// Events

	// Vote Up
	$(document).on('ajax:beforeSend', '.vote.up', function(event, xhr, settings) {
		parent = $(this).parent('.voting');
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
		parent = $(this).parent('.voting');
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
		var parent = $(this).parent('.voting');
		parent.find('.item-worth').html(data.item_worth);
		
		ur = data.user_rating;
		urObj = parent.find('.user-rating');
		urObj.html(ur);
		if(ur == 0){
			urObj.parent().hide();
		} else {
			urObj.parent().show();
		}
		
		$('#balance').html(data.user_balance);
	});

});

// Helpers
function roundTo(num, dec) {
	var result = Math.round(parseFloat(num)*Math.pow(10,dec))/Math.pow(10,dec);
	return result;
}
