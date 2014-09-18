init = ->
  new Tooltip!watchElements!
  container = d3.select window.ig.containers.base
  window.ig.drawSouhrn container
  window.ig.drawMapka container
  window.ig.drawDhondt container

if d3?
  init!
else
  $ window .bind \load ->
    if d3?
      init!
