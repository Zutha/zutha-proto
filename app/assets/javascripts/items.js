
$(function(){
// Events

	// OnBlur Submit
	$(document).on('keypress', '.submittable', function(e) {
		if(e.which == 13) { //on Enter key
			$(this).blur();
			e.preventDefault();
		}
	});

	$(document).on('change', '.submittable', function() {
		$(this).parents('form:first').submit();
	});

	// Invest: Set


	// Invest: Buy
	$(document).on('ajax:beforeSend', '.invest.buy', function(event, xhr, settings) {
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
			urObj = parent.find('input.user-rating');
			urNew = roundTo(parseFloat(urObj.val()) + amount,2);
			iwObj = parent.find('.item-worth');
			iwNew = roundTo(parseFloat(iwObj.html()) + amount,2);
			params = "&amount="+amount+
					"&new_item_worth="+ iwNew+
					"&new_user_rating="+ urNew+
					"&new_user_balance="+ ubNew;
			settings.data = settings.data + params;
			iwObj.html( iwNew );	
			ubObj.html( ubNew );
			urObj.val( urNew );
		}
	});

	// Invest: Sell
	$(document).on('ajax:beforeSend', '.invest.sell', function(event, xhr, settings) {
		parent = $(this).parents('.item');
		urObj = parent.find('input.user-rating');
		ur = parseFloat(urObj.val());
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
			urObj.val( urNew );
		}
	});

	$(document).on('ajax:success', '.invest', function(event, data){
		var parent = $(this).parents('.item');
		
		item_worth = data.item_worth;
		user_rating = data.user_rating;
		user_balance = data.user_balance;

		if(null!=item_worth) parent.find('.item-worth').html(item_worth);
		if(null!=user_rating) parent.find('input.user-rating').val(user_rating);
		if(null!=user_balance) $('#balance').html(user_balance);
	});

	$(document).on('ajax:error', '.invest', function(event, xhr, status){
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
