//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require jquery/jquery.selected
//= require jquery/jquery.jplayer-all

$ -> 
	$("table #select_all").select_all()

	$(".destroy-multiple").click(
		-> $("form.search-form").submit();
	)





