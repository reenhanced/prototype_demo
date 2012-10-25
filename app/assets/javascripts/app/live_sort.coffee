$ ->
  $('.live-sort').sortable(
    axis: 'y',
    cursor: 'move',
    handle: '.handle',
    update: ->
      path = $(this).attr('data-update-path')
      $.post(path, $(this).sortable('serialize'))
  )
