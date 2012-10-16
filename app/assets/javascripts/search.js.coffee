$ ->
  search_results = $('#results')
  search_form    = $('#card-search-form')
  search_button  = $('#card-search-form input[type=submit]')
  search_error   = $('#ajax-search-error')
  spin_options   = { length: 20, radius: 20, shadow: true } # from spin.js

  search_form.bind
    'ajax:beforeSend': ->
      active_mode()
    'ajax:success': (xhr, result_html) ->
      inactive_mode()
      search_results.html(result_html)
    'ajax:error': ->
      inactive_mode()
      search_error.fadeIn()

  active_mode = ->
    search_error.hide()
    search_results.empty().spin(spin_options)
    search_button.button('loading')

  inactive_mode = ->
    search_button.button('reset')
    search_results.spin(false)

  # Automatically perform ajax searches as the user types
  search_timeout       = null
  clear_search_timeout = -> clearTimeout(search_timeout)

  search_form.find('input').keyup (e) ->
    unless e.keyCode is 13
      clear_search_timeout()
      search_timeout = setTimeout (-> search_form.submit()), 500

  search_button.click(clear_search_timeout)
