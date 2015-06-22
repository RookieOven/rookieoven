---
---
$ ->
	# SVG fallback
	if !Modernizr.svg
		$('img[src*="svg"]').attr('src', ->
			return $(this).attr('src').replace('.svg', '.png')
		)
		
	# Down arrow scrolling
	$('.header .down').click (e)->
		e.preventDefault()
		$('html, body').animate({
			scrollTop: $('#team').offset().top
		});