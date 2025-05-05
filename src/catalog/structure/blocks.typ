#import "../../deps.typ": cetz
#import "../../mash.typ": mash-entry
#import "../display/flat.typ": debug-gray

#let structure-style = debug-gray

/// Prefab for a rectangular section.
#let unit-rect(
  origin: (0, 0), 
  size: (1, 1),
  name: "unnamed-rect",
  tags: (),
  default-style: structure-style
) = {
  tags.push("rectangle")

  let entry = mash-entry
  entry.named = name
  entry.tags = tags
  entry.style-structure = {
    import cetz.draw: set-style
    set-style(..default-style)
  }
  entry.cetz-structure = {
    import cetz.draw: rect, line

    // Primary unit boundaries.
    rect(
      origin,
      size,
      name: name
    )

    // Construct straight skeleton for offset helper anchors.
    cetz.draw.get-ctx(ctx => {
      let (ctx, (x0, y0, z0), (x1, y1, z1)) = cetz.coordinate.resolve(ctx, origin, size)
      let (width, height) = ((calc.abs(x1 - x0)), calc.abs(y1 - y0))

      if width >= height {
        line((rel: (-height / 2, 0), to: name + ".east"), name + ".north-east", name: name + "-skele-1")
        line((rel: (-height / 2, 0), to: name + ".east"), name + ".south-east", name: name + "-skele-2")
        line((rel: (height / 2, 0), to: name + ".west"), name + ".south-west", name: name + "-skele-3")
        line((rel: (height / 2, 0), to: name + ".west"), name + ".north-west", name: name + "-skele-4")
        if width != height { line(name + "-skele-4.start", name + "-skele-1.start", name: name + "-skelecore") }
      } else {
        line((rel: (0, -width / 2), to: name + ".north"), name + ".north-east", name: name + "-skele-1")
        line((rel: (0, -width / 2), to: name + ".north"), name + ".north-west", name: name + "-skele-2")
        line((rel: (0, width / 2), to: name + ".south"), name + ".south-east", name: name + "-skele-3")
        line((rel: (0, width / 2), to: name + ".south"), name + ".south-west", name: name + "-skele-4")
        line(name + "-skele-2.start", name + "-skele-3.start", name: name + "-skelecore") 
      }
    })
  }

  return entry
}

/// Places unit-rect() with a grid pattern.
/// Supply an array of (row, column) coordinates to the 'position' argument.
/// 
/// Origin is at bottom-left.
/// Names are applied left to right in ascending rows.
/// Name array will be auto-filled with "r[row]c[column]" if not enough names are supplied.
/// ```text
///  __ __ __
/// |__|__|__|
/// |__|__|__|
/// |__|__|__|
///
///  (3, 1)--(3, 2)--(3, 3)
///  (2, 1)--(2, 2)--(2, 3)
///  (1, 1)--(1, 2)--(1, 3)
/// ```
#let place-on-grid(
  positions: ((1, 1), (1, 2), (1, 3), (2, 1), (2, 3), (3, 1), (3, 2), (3, 3)),
  origin: (0, 0), 
  unit-size: (1, 1),
  common-tags: (),
  names: ("r1c1", "r1c2", "r1c3", "r2c1", "r2c2", "r2c3", "r3c1", "r3c2", "r3c3"),
  default-style: structure-style
) = {
  // Fill names array if too short:
  let names-diff = positions.len() - names.len()
  if names-diff > 0 {
    for index in range(names.len(), positions.len()) {
      names.push("r" + str(positions.at(index).first()) + "c" + str(positions.at(index).last()))
    }
  }

  let new-origin = (0, 0)
  let (unit-x, unit-y) = unit-size
  let collection = ()

  for (index, (row, column)) in positions.enumerate() {

    // Want to avoid passing nested context everywhere, so we'll work around it best we can:
    let origin-type = cetz.coordinate.resolve-system(origin)
    if origin-type == "xyz" {
      let (origin-x, origin-y) = origin
      new-origin = (origin-x + (unit-x * (column - 1)), origin-y + (unit-y * (row - 1)))
    } else if origin-type == "anchor" {
      let (origin-x, origin-y) = (0, 0)
      new-origin = (rel: (origin-x + (unit-x * (column - 1)), origin-y + (unit-y * (row - 1))), to: origin)
    } else if origin-type == "relative" {
      let (origin-x, origin-y) = origin.rel
      new-origin = (rel: (origin-x + (unit-x * (column - 1)), origin-y + (unit-y * (row - 1))), to: origin.to)
    } else {
      panic("place-on-grid currently doesn't support " + origin-type)
    }

    collection.push(
      unit-rect(
        origin: new-origin, 
        size: (rel: unit-size), 
        name: names.at(index),
        tags: common-tags,
        default-style: default-style
      )
    )
  }

  return collection.flatten()
}