@overlaps = do ->
  getPositions = (elem) ->
    pos = undefined
    width = undefined
    height = undefined
    pos = $(elem).position()
    width = $(elem).width()
    height = $(elem).height()
    [
      [
        pos.left
        pos.left + width
      ]
      [
        pos.top
        pos.top + height
      ]
    ]

  comparePositions = (p1, p2) ->
    r1 = undefined
    r2 = undefined
    r1 = if p1[0] < p2[0] then p1 else p2
    r2 = if p1[0] < p2[0] then p2 else p1
    r1[1] > r2[0] or r1[0] == r2[0]

  (a, b) ->
    pos1 = getPositions(a)
    pos2 = getPositions(b)
    comparePositions(pos1[0], pos2[0]) and comparePositions(pos1[1], pos2[1])
