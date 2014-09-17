window.ig.drawSouhrn = (container) ->
  strany =
    * "TOP 09" \#B560F3  26 22
    * "ODS"    \#1C76F0  20 16
    * "ČSSD"   \#FEA201  14 13
    * "KSČM"   \#F40000  3  4
    * "VV"     \#66E2D8  0  4
    * "SZ"     \#0FB103  0  4
  container = container.append \div
    ..attr \class \souhrn

  mandaty_assoc = {okrsky: [], cela: []}
  for [name, color, okrsky, cela] in strany
    for i in [0 til okrsky]
      mandaty_assoc.okrsky.push {name, color}
    for i in [0 til cela]
      mandaty_assoc.cela.push {name, color}
  containers =
    "okrsky" : container.append \div .attr \class "okrsky container active"
    "cela" : container.append \div .attr \class "cela container active"
  containers.okrsky.on \mouseover ->
    containers.okrsky.classed \active yes
    containers.cela.classed \active no
    window.ig.mapkaTransition 0

  containers.cela.on \mouseover ->
    containers.cela.classed \active yes
    containers.okrsky.classed \active no
    window.ig.mapkaTransition 1


  containers['okrsky'].append \div
    ..attr \class "popisky okrsky"
    ..selectAll \span .data (strany.filter (.2)) .enter!append \span
      ..attr \class \popisek
      ..style \width ->"#{it.2 * 9}px"
      ..style \color (.1)
      ..html -> "#{it.0}<br />#{it.2}"

  for typ, mandaty of mandaty_assoc
    containers[typ].append \div
      ..attr \class "mandaty #{typ}"
      ..selectAll \div .data mandaty .enter!append \div
        ..attr \class \mandat
        ..style \background-color (.color)

  containers['cela'].append \div
    ..attr \class "popisky cela"
    ..selectAll \span .data (strany.filter (.3)) .enter!append \span
      ..attr \class \popisek
      ..style \width ->"#{it.3 * 9}px"
      ..style \color (.1)
      ..html -> "#{it.3}<br />#{it.0}"

