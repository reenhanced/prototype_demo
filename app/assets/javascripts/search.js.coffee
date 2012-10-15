$ ->
  spin_options = { length: 20, radius: 20, shadow: true }

  $('#card-search-form').ajaxForm
    beforeSubmit: -> $('#results').empty().spin(spin_options)
    dataType: 'html'
    success: (result_html) -> $('#results').spin(false).html(result_html)

  $('#card-search-form').submit()

  performSearch = null
  $('#card-search-form input').keyup ->
    clearTimeout(performSearch) if performSearch
    performSearch = setTimeout (-> $('#card-search-form').submit()), 500
