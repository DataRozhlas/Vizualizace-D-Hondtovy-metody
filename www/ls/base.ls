init = ->
  container = d3.select window.ig.containers.base

  width = 610px

  svg = container.append \svg
    ..attr \width width
    ..attr \height 470px

  width = 520
  svg = svg.append \g
    ..attr \transform "translate(#{(610 - width) / 2}, #{(610 - width) / 2})"
  okrsky = ig.data.geo

  projection = window.ig.getProjection okrsky, width
  okrsky.forEach (.centroid = projection d3.geo.centroid it)

  len = okrsky.length
  okrskyCentroid = okrsky.reduce do
    (prev, curr) ->
      prev.0 += curr.centroid.0 / len
      prev.1 += curr.centroid.1 / len
      prev
    [0, 0]


  okrskyCentroid[0] -= 30
  okrskyCentroid[1] += 10

  okrsky[0].centroid[0] -= 10
  okrsky[0].centroid[1] += 0

  okrsky[1].centroid[0] -= 0
  okrsky[1].centroid[1] -= 10

  okrsky[2].centroid[0] -= 20
  okrsky[2].centroid[1] += 6

  okrsky[3].centroid[0] -= 10
  okrsky[3].centroid[1] += 10

  okrsky[4].centroid[0] += 5
  okrsky[4].centroid[1] += 20

  okrsky[5].centroid[0] -= 30
  okrsky[5].centroid[1] -= 10

  okrsky[6].centroid[0] -= 10
  okrsky[6].centroid[1] += 10

  okrsky.forEach ->
    it.expansion =
      it.centroid.0 - okrskyCentroid.0
      it.centroid.1 - okrskyCentroid.1


  path = d3.geo.path!
    ..projection projection
  romans = <[0 I II III IV V VI VII]>
  okrskySvg = svg.selectAll \g.okrsek .data okrsky .enter!
    ..append \path
      ..attr \class \okrsek
      ..attr \d path
    ..append \text
      ..attr \x (.centroid.0)
      ..attr \y (.centroid.1)
      ..text -> romans[it.properties.obvod_i]

  amount = 0
  transition = ->
    amount := if amount == 0 then 0.3 else 0
    svg.selectAll 'path,text' .transition!
      ..duration 400
      ..attr \transform -> "translate(#{it.expansion.0 * amount},#{it.expansion.1 * amount})"

  container.on \click transition

if d3?
  init!
else
  $ window .bind \load ->
    if d3?
      init!
