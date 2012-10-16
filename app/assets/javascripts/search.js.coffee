$ ->
  search_results = $('#results')
  search_form    = $('#card-search-form')
  search_button  = $('#card-search-form input[type=submit]')
  spin_options   = { length: 20, radius: 20, shadow: true } # from spin.js
  search_timeout = null

  clear_search_timeout = -> clearTimeout(search_timeout)

  search_form.ajaxForm
    beforeSubmit: ->
      search_results.empty().spin(spin_options)
      search_button.button('loading')
    dataType: 'html'
    success: (result_html) ->
      search_button.button('reset')
      search_results.spin(false).html(result_html)

  search_form.find('input').keyup (e) ->
    unless e.keyCode is 13
      clear_search_timeout()
      search_timeout = setTimeout (-> search_form.submit()), 500

  search_button.click(clear_search_timeout)
