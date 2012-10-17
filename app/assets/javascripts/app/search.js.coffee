$ ->
  search_results = $('#card-search-results')
  search_form    = $('#card-search-form')
  search_button  = $('#card-search-form input[type=submit]')
  search_error   = $('#ajax-search-error')
  spin_options   = { length: 20, radius: 20, shadow: true } # from spin.js

  search_form.bind
    'ajax:beforeSend': ->
      search_error.hide()
      search_results.empty().spin(spin_options)
    'ajax:complete': ->
      search_results.spin(false)
    'ajax:success': (xhr, result_html) ->
      search_results.html(result_html)
    'ajax:error': ->
      search_error.show()

  # Automatically perform ajax searches as the user types
  search_timeout       = null
  clear_search_timeout = -> clearTimeout(search_timeout)

  search_form.find('input').keyup (e) ->
    unless e.keyCode is 13
      clear_search_timeout()
      search_timeout = setTimeout (-> search_form.submit()), 500

  search_button.click(clear_search_timeout)
