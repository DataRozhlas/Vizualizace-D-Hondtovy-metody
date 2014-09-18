init = ->
  new Tooltip!watchElements!
  for element in document.querySelectorAll '.ig.clearFix'
    element.parentNode.className = "embed clearfix"
  container = d3.select window.ig.containers.base
  window.ig.drawSouhrn do
    d3.select window.ig.containers.souhrn
    true
  window.ig.drawDhondt do
    d3.select window.ig.containers.dhondCela
    [0]
  window.ig.drawDhondt do
    d3.select window.ig.containers.dhondObvody
    [1 to 7]
  window.ig.drawSouhrn container
  window.ig.drawMapka container
  window.ig.drawDhondt container

if d3?
  init!
else
  $ window .bind \load ->
    if d3?
      init!
