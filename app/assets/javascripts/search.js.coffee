$ ->
  spin_options = { length: 20, radius: 20, shadow: true }

  cancelSearch = ->
    clearTimeout(performSearch) if performSearch
    return

  $('#card-search-form').ajaxForm
    beforeSubmit: ->
      $('#results').empty().spin(spin_options)
    dataType: 'html'
    success: (result_html) ->
      $('#results').spin(false).html(result_html)

  performSearch = null
  $('#card-search-form input').keyup (e) ->
    unless e.keyCode is 13
      cancelSearch()
      performSearch = setTimeout (-> $('#card-search-form').submit()), 500

  $('#card-search-form input[type=submit]').click(cancelSearch)

