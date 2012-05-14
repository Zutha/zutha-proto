$ ->
	$('#sign_in').click (e) =>
		e.preventDefault()
		$('#login_curtain').show()
		$('#login_layer').show()
	$('.login_close').click =>
		$('#login_curtain').hide()
		$('#login_layer').hide()