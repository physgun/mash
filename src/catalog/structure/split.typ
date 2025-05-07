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
        origin: (rel: (-0.2, -1.4), to: grid-names.first() + ".south"), 
        size: (rel: unit-size), 
        name: name-prefix + "-thumb-1",
        tags: common-tags,
        default-style: default-style,
        transform: {
          cetz.draw.rotate(15deg)
        }
      ),
      unit-rect(
        origin: (rel: (-1.7, -1.3), to: grid-names.first() + ".south"), 
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
      "cetz-structure",
      {
        cetz.draw.scope({
          cetz.draw.scale(x: -1)
          entry.cetz-structure
        })
      }
    )
    return entry
  })

  return lh-side
}

#let ferris(
  origin: (0, 0), 
  unit-size: (1, 1),
  common-tags: (),
  default-style: structure-style
) = {
  let both-sides = ()
  let space-between = 3.0

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
    panic("place-on-grid currently doesn't support " + origin-type)
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

) = {

}

#let glove80-lh(

) = {

}

#let glove80(

) = {

}