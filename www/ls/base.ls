init = ->
  container = d3.select window.ig.containers.base
  window.ig.drawSouhrn container
  window.ig.drawMapka container

if d3?
  init!
else
  $ window .bind \load ->
    if d3?
      init!
