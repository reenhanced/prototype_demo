$ ->
  $('.live-sort').sortable(
    axis: 'y',
    handle: '.handle',
    update: ->
      path = $(this).attr('data-update-path')
      $.post(path, $(this).sortable('serialize'))
  )
