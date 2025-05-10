#import "../../deps.typ": cetz,
#import "../structure/components.typ": *
#import "../display/flat.typ": debug-gray

#let structure-style = debug-gray

#let ferris-rh(
  origin: (0, 0), 
  unit-size: (1, 1),
  name-prefix: "rh",
  common-tags: (),
  default-style: structure-style
) = {
  common-tags.push(name-prefix)

  let rh-side = ()

  let column-1-offset = 0.0
  let column-2-offset = 0.2
  let column-3-offset = 0.7
  let column-4-offset = 0.2
  let column-5-offset = -0.5

  let positions-array = (
    (1 + column-1-offset, 1), (2 + column-1-offset, 1), (3 + column-1-offset, 1),
    (1 + column-2-offset, 2), (2 + column-2-offset, 2), (3 + column-2-offset, 2),
    (1 + column-3-offset, 3), (2 + column-3-offset, 3), (3 + column-3-offset, 3),
    (1 + column-4-offset, 4), (2 + column-4-offset, 4), (3 + column-4-offset, 4),
    (1 + column-5-offset, 5), (2 + column-5-offset, 5), (3 + column-5-offset, 5),
  )

  let grid-names = (
        "1-low", "1-mid", "1-high", 
        "2-low", "2-mid", "2-high", 
        "3-low", "3-mid", "3-high", 
        "4-low", "4-mid", "4-high", 
        "5-low", "5-mid", "5-high", 
      ).map(it => {name-prefix + "-" + it})

  rh-side.push(
    place-on-grid(
      positions: positions-array,
      origin: origin, 
      unit-size: unit-size,
      common-tags: common-tags,
      names: grid-names,
      default-style: default-style
    )
  )

  rh-side.push(
    (
      unit-rect(
        origin: (rel: (-0.2, -1.3), to: grid-names.first() + ".south"), 
        size: (rel: unit-size), 
        name: name-prefix + "-thumb-1",
        tags: common-tags,
        default-style: default-style,
        transform: {
          cetz.draw.rotate(15deg)
        }
      ),
      unit-rect(
        origin: (rel: (-1.7, -1.2), to: grid-names.first() + ".south"), 
        size: (rel: unit-size), 
        name: name-prefix + "-thumb-2",
        tags: common-tags,
        default-style: default-style,
        transform: {
          cetz.draw.rotate(30deg)
        }
      ),
    )
  )

  return rh-side.flatten()
}

#let ferris-lh(
  origin: (0, 0), 
  unit-size: (1, 1),
  name-prefix: "lh",
  common-tags: (),
  default-style: structure-style
) = {
  let lh-side = ()

  lh-side.push(
    ferris-rh(
      origin: origin, 
      unit-size: unit-size,
      name-prefix: name-prefix,
      common-tags: common-tags,
      default-style: default-style
    )
  )

  lh-side = lh-side.flatten().map(entry => {
    entry.insert(
      "transforms",
      {
        cetz.draw.scale(x: -1)
        entry.transforms
      }
    )
    return entry
  })

  return lh-side
}

/// A cute crab mascot that someone named a keyboard after.
#let ferris(
  origin: (0, 0), 
  unit-size: (1, 1),
  space-between: 3.0,
  common-tags: (),
  default-style: structure-style
) = {
  let both-sides = ()

  // Want to avoid passing nested context everywhere, so we'll work around it best we can:
  let origin-type = cetz.coordinate.resolve-system(origin)
  let new-origin = (0, 0)
  if origin-type == "xyz" {
    let (origin-x, origin-y) = origin
    new-origin = (origin-x + (space-between / 2), origin-y)
  } else if origin-type == "anchor" {
    let (origin-x, origin-y) = (0, 0)
    new-origin = (rel: (origin-x + (space-between / 2), origin-y), to: origin)
  } else if origin-type == "relative" {
    let (origin-x, origin-y) = origin.rel
    new-origin = (rel: (origin-x + (space-between / 2), origin-y), to: origin.to)
  } else {
    panic("ferris currently doesn't support " + origin-type)
  }

  both-sides.push(
    ferris-rh(
      origin: new-origin, 
      unit-size: unit-size,
      common-tags: common-tags,
      default-style: default-style
    )
  )

  both-sides.push(
    ferris-lh(
      origin: new-origin, 
      unit-size: unit-size,
      common-tags: common-tags,
      default-style: default-style
    )
  )

  return both-sides.flatten()
}

#let glove80-rh(
  origin: (0, 0), 
  unit-size: (1, 1),
  name-prefix: "RH",
  common-tags: (),
  default-style: structure-style
) = {
common-tags.push(name-prefix)

  let rh-side = ()

  let inner-columns-offset = 0.0
  let outer-columns-offset = -0.5

  let positions-array = (
    (2 + inner-columns-offset, 1), (3 + inner-columns-offset, 1), (4 + inner-columns-offset, 1), (5 + inner-columns-offset, 1),
    (1 + inner-columns-offset, 2), (2 + inner-columns-offset, 2), (3 + inner-columns-offset, 2), (4 + inner-columns-offset, 2), (5 + inner-columns-offset, 2), (6 + inner-columns-offset, 2),
    (1 + inner-columns-offset, 3), (2 + inner-columns-offset, 3), (3 + inner-columns-offset, 3), (4 + inner-columns-offset, 3), (5 + inner-columns-offset, 3), (6 + inner-columns-offset, 3),
    (1 + inner-columns-offset, 4), (2 + inner-columns-offset, 4), (3 + inner-columns-offset, 4), (4 + inner-columns-offset, 4), (5 + inner-columns-offset, 4), (6 + inner-columns-offset, 4),
    (1 + outer-columns-offset, 5), (2 + outer-columns-offset, 5), (3 + outer-columns-offset, 5), (4 + outer-columns-offset, 5), (5 + outer-columns-offset, 5), (6 + outer-columns-offset, 5),
    (1 + outer-columns-offset, 6), (2 + outer-columns-offset, 6), (3 + outer-columns-offset, 6), (4 + outer-columns-offset, 6), (5 + outer-columns-offset, 6), (6 + outer-columns-offset, 6),
  )

  let grid-names = (
        "R5C1", "R4C1", "R3C1", "R2C1",
        "R6C2", "R5C2", "R4C2", "R3C2", "R2C2", "R1C2", 
        "R6C3", "R5C3", "R4C3", "R3C3", "R2C3", "R1C3",
        "R6C4", "R5C4", "R4C4", "R3C4", "R2C4", "R1C4",
        "R6C5", "R5C5", "R4C5", "R3C5", "R2C5", "R1C5",
        "R6C6", "R5C6", "R4C6", "R3C6", "R2C6", "R1C6",
      ).map(it => {name-prefix + it})

  rh-side.push(
    place-on-grid(
      positions: positions-array,
      origin: origin, 
      unit-size: unit-size,
      common-tags: common-tags,
      names: grid-names,
      default-style: default-style
    )
  )

  rh-side.push(
    (
      unit-rect(
        origin: (rel: (-1.8, -0.7), to: grid-names.first() + ".south"), 
        size: (rel: unit-size), 
        name: name-prefix + "T1",
        tags: common-tags,
        default-style: default-style,
        transform: {
          cetz.draw.rotate(25deg)
        }
      ),
      unit-rect(
        origin: (rel: (-3.3, -0.5), to: grid-names.first() + ".south"), 
        size: (rel: unit-size), 
        name: name-prefix + "T2",
        tags: common-tags,
        default-style: default-style,
        transform: {
          cetz.draw.rotate(30deg)
        }
      ),
      unit-rect(
        origin: (rel: (-4.8, -0.2), to: grid-names.first() + ".south"), 
        size: (rel: unit-size), 
        name: name-prefix + "T3",
        tags: common-tags,
        default-style: default-style,
        transform: {
          cetz.draw.rotate(35deg)
        }
      ),
      unit-rect(
        origin: (rel: (-1.8, -1.9), to: grid-names.first() + ".south"), 
        size: (rel: unit-size), 
        name: name-prefix + "T4",
        tags: common-tags,
        default-style: default-style,
        transform: {
          cetz.draw.rotate(25deg)
        }
      ),
      unit-rect(
        origin: (rel: (-3.3, -1.7), to: grid-names.first() + ".south"), 
        size: (rel: unit-size), 
        name: name-prefix + "T5",
        tags: common-tags,
        default-style: default-style,
        transform: {
          cetz.draw.rotate(30deg)
        }
      ),
      unit-rect(
        origin: (rel: (-4.8, -1.4), to: grid-names.first() + ".south"), 
        size: (rel: unit-size), 
        name: name-prefix + "T6",
        tags: common-tags,
        default-style: default-style,
        transform: {
          cetz.draw.rotate(35deg)
        }
      ),
    )
  )

  return rh-side.flatten()
}

#let glove80-lh(
  origin: (0, 0), 
  unit-size: (1, 1),
  name-prefix: "LH",
  common-tags: (),
  default-style: structure-style
) = {
  let lh-side = ()

  lh-side.push(
    glove80-rh(
      origin: origin, 
      unit-size: unit-size,
      name-prefix: name-prefix,
      common-tags: common-tags,
      default-style: default-style
    )
  )

  lh-side = lh-side.flatten().map(entry => {
    entry.insert(
      "transforms",
      {
        cetz.draw.scale(x: -1)
        entry.transforms
      }
    )
    return entry
  })

  return lh-side
}

// An all-time favorite among ortho-split ergonomic keyboards.
#let glove80(
  origin: (0, 0), 
  unit-size: (1, 1),
  space-between: 9.0,
  common-tags: (),
  default-style: structure-style
) = {
  let both-sides = ()

  // Want to avoid passing nested context everywhere, so we'll work around it best we can:
  let origin-type = cetz.coordinate.resolve-system(origin)
  let new-origin = (0, 0)
  if origin-type == "xyz" {
    let (origin-x, origin-y) = origin
    new-origin = (origin-x + (space-between / 2), origin-y)
  } else if origin-type == "anchor" {
    let (origin-x, origin-y) = (0, 0)
    new-origin = (rel: (origin-x + (space-between / 2), origin-y), to: origin)
  } else if origin-type == "relative" {
    let (origin-x, origin-y) = origin.rel
    new-origin = (rel: (origin-x + (space-between / 2), origin-y), to: origin.to)
  } else {
    panic("glove80 currently doesn't support " + origin-type)
  }

  both-sides.push(
    glove80-rh(
      origin: new-origin, 
      unit-size: unit-size,
      common-tags: common-tags,
      default-style: default-style
    )
  )

  both-sides.push(
    glove80-lh(
      origin: new-origin, 
      unit-size: unit-size,
      common-tags: common-tags,
      default-style: default-style
    )
  )

  return both-sides.flatten()
}