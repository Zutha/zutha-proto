$ ->
	$('#sign_in').click (e) =>
		e.preventDefault()
		$('#loginCurtain').show()
		$('#loginLayer').show()
	$('.loginClose').click =>
		$('#loginCurtain').hide()
		$('#loginLayer').hide()