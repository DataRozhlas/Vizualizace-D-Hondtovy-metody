getBounds = (features) ->
  north = -Infinity
  west  = +Infinity
  south = +Infinity
  east  = -Infinity
  features.forEach (feature) ->
    [[w,s],[e,n]] = d3.geo.bounds feature
    if n > north => north := n
    if w < west  => west  := w
    if s < south => south := s
    if e > east  => east  := e

  [[west, south], [east, north]]

window.ig.getProjection = (features, width) ->
  [[west, south], [east, north]] = getBounds features
  displayedPercent = (Math.abs west - east) / 360
  d3.geo.mercator!
    ..scale width / (Math.PI * 2 * displayedPercent)
    ..center [west, north]
    ..translate [0 0]
