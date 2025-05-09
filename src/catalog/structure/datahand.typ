#import "../../deps.typ": cetz,
#import "../structure/components.typ": *
#import "../display/flat.typ": debug-gray

#let structure-style = debug-gray

#let svalboard-rh(
  origin: (0, 0), 
  unit-size: (1, 1),
  name-prefix: "rh",
  common-tags: (),
  default-style: structure-style
) = {
  common-tags.push(name-prefix)
  let (thumb-tags, index-tags, middle-tags, ring-tags, pinky-tags) = ((common-tags,) * 5)
    .flatten().zip(("thumb", "index", "middle", "ring", "pinky"))

  let (origin-x, origin-y) = origin
  let (unit-size-x, unit-size-y) = unit-size

  let rh-side = ()

  let cluster-offset-x = 0.0
  let cluster-offset-y = 0.0

  let positions-array(offset-x: 0.0, offset-y: 0.0) = (
    (1 + offset-y, 2 + offset-x), 
    (2 + offset-y, 1 + offset-x), (2 + offset-y, 2 + offset-x), (2 + offset-y, 3 + offset-x),
    (3 + offset-y, 2 + offset-x), 
  )

  let grid-names(finger: "fingy") = (
        "south", "west", "center", "east", "north"
      ).map(it => {name-prefix + "-" + finger + "-" + it})

  rh-side.push(
    (
      place-on-grid(
        positions: positions-array(offset-x: 0.0, offset-y: 0.0),
        origin: origin, 
        unit-size: unit-size,
        common-tags: index-tags,
        names: grid-names(finger: "index"),
        default-style: default-style
      ),
      place-on-grid(
        positions: positions-array(offset-x: 2.5, offset-y: 1.5),
        origin: origin, 
        unit-size: unit-size,
        common-tags: middle-tags,
        names: grid-names(finger: "middle"),
        default-style: default-style
      ),
      place-on-grid(
        positions: positions-array(offset-x: 6.0, offset-y: 1.5),
        origin: origin, 
        unit-size: unit-size,
        common-tags: ring-tags,
        names: grid-names(finger: "ring"),
        default-style: default-style
      ),
      place-on-grid(
        positions: positions-array(offset-x: 8.5, offset-y: 0.0),
        origin: origin, 
        unit-size: unit-size,
        common-tags: pinky-tags,
        names: grid-names(finger: "pinky"),
        default-style: default-style
      ),
    )
  )

  rh-side.push(
    (
      unit-rect(
        origin: (rel: (-0.5 * unit-size-x, -1.5 * unit-size-y), to: origin), 
        size: (rel: (unit-size-x * 1.5, unit-size-y)), 
        name: name-prefix + "-thumb-nail",
        tags: thumb-tags,
        default-style: default-style,
      ),
      unit-rect(
        origin: (rel: (0.0, 0.0), to: name-prefix + "-thumb-nail.south-east"), 
        size: (rel: (unit-size-x, unit-size-y)), 
        name: name-prefix + "-thumb-down-click",
        tags: thumb-tags,
        default-style: default-style,
      ),
      unit-rect(
        origin: (rel: (0.0, 0.0), to: name-prefix + "-thumb-down-click.south-east"), 
        size: (rel: (unit-size-x * 1.5, unit-size-y)), 
        name: name-prefix + "-thumb-pad",
        tags: thumb-tags,
        default-style: default-style,
      ),
      unit-rect(
        origin: (rel: (0.0 * unit-size-x, -1.0 * unit-size-y), to: name-prefix + "-thumb-nail.south-west"), 
        size: (rel: (unit-size-x * 1.5, unit-size-y)), 
        name: name-prefix + "-thumb-knuckle",
        tags: thumb-tags,
        default-style: default-style,
      ),
      unit-rect(
        origin: (rel: (0.0, 0.0), to: name-prefix + "-thumb-knuckle.south-east"), 
        size: (rel: (unit-size-x, unit-size-y)), 
        name: name-prefix + "-thumb-down",
        tags: thumb-tags,
        default-style: default-style,
      ),
      unit-rect(
        origin: (rel: (0.0, 0.0), to: name-prefix + "-thumb-down.south-east"), 
        size: (rel: (unit-size-x * 2.0, unit-size-y)), 
        name: name-prefix + "-thumb-up",
        tags: thumb-tags,
        default-style: default-style,
      ),
    )
  )

  return rh-side.flatten()
}

#let svalboard-lh(
  origin: (0, 0), 
  unit-size: (1, 1),
  name-prefix: "lh",
  common-tags: (),
  default-style: structure-style
) = {
  let lh-side = ()

  lh-side.push(
    svalboard-rh(
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

// A datahand-type keyboard intended for RSI-free typing.
#let svalboard(
  origin: (0, 0), 
  unit-size: (1, 1),
  space-between: 2.0,
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
    svalboard-rh(
      origin: new-origin, 
      unit-size: unit-size,
      common-tags: common-tags,
      default-style: default-style
    )
  )

  both-sides.push(
    svalboard-lh(
      origin: new-origin, 
      unit-size: unit-size,
      common-tags: common-tags,
      default-style: default-style
    )
  )

  return both-sides.flatten()
}