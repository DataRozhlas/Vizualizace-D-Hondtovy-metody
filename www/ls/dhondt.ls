window.ig.drawDhondt = (container) ->
  container = container.append \div
    ..attr \class \dhondt
  strany =
    * "TOP 09" \#B560F3 [1043008 188835 147063 150179 136452 145062 134152 141265]
    * "ODS"    \#1C76F0 [796218  108441 107260 124834 116069 117338 106291 115985]
    * "ČSSD"   \#FEA201 [615209  86448  72569  103211 98184  88136  85438  81223 ]
    * "KSČM"   \#F40000 [235004  35706  24870  40955  36694  29816  33949  33014 ]
    * "VV"     \#66E2D8 [195158  25632  33607  36255  25288  23702  22822  27852 ]
    * "SZ"     \#0FB103 [203363  33867  26552  32782  31235  35228  26185  17514 ]
  mandaty = [63 9 9 9 9 9 9 9]
  lines = for i in [0 til 63] => i
  container.append \div .attr \class \mandatLine
    ..append \div
      ..attr \class \pica
    ..append \div
      ..attr \class \picara
    ..append \span
      ..html 'Získali mandát'
    ..append \span
      ..html 'Nezískali mandát'
  castiElements = for castInUse in [0 to 7]
    castContainer = container.append \div .attr \class \cast
    votes = for strana in strany => strana[2][castInUse]
    mandates = for strana in strany => 0
    linesToDraw = if castInUse then 16 else 63
    lines = for mandatesAwarded in [1 to linesToDraw]
      winningIndex = getRoundWinner votes, mandates
      mandates[winningIndex]++
      results = for strana, index in strany
        if winningIndex == index
          strana[1]
        else
          void
          # if mandatesAwarded <= mandaty[castInUse] then '#eee' else '#f9f9f9'

    castContainer
      ..selectAll \div.line .data lines .enter!append \div
        ..attr \class \line
        ..classed \isOver (d, i) -> mandaty[castInUse] - i <= 0
        ..style \opacity (d, i) ->
          remaining = mandaty[castInUse] - i
          if remaining > 0
            1
          else
            1 - 0.3 + remaining / 10
        ..style \margin-top (d, i) ->
          if mandaty[castInUse] - i == 0
            "2px"
          else
            void

        ..selectAll \div.mandat .data (-> it) .enter!append \div
          ..attr \class \mandat
          ..style \background-color -> it
          ..classed \isEmpty -> it is void

  window.ig.dhondtTransition = (dir) ->
    if dir == 0
      castiElements[0].classed \inactive false
      castiElements[1 to 7].forEach (.classed \inactive true)
    else
      castiElements[0].classed \inactive true
      castiElements[1 to 7].forEach (.classed \inactive false)


getRoundWinner = (votes, mandates, options = {base: 1}) ->
  highestIndex = -1
  highestScore = -Infinity
  for voteCount, index in votes
    mandateCount = mandates[index]
    divider = if mandateCount then that + 1 else options.base
    score = voteCount / divider
    if score > highestScore
      highestScore = score
      highestIndex = index
  highestIndex

