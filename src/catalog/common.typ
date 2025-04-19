#import "../deps.typ": cetz

/// Draw style for the physical base shapes.
#let physical-palette = (stroke: (paint: black, thickness: 1pt, dash: "dotted"))

/// Prefab for a rectangular section.
#let unit-rect(
  origin: (0, 0), 
  size: (1, 1),
  name: "unnamed",
  tags: (),
  default-style: physical-palette
) = {
  (
    named: name,
    tags: tags.push("rectangle"),
    style-physical: {
      import cetz.draw: set-style
      set-style(..default-style)
    },
    cetz-physical: {
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
          line((rel: (-height / 2, 0), to: name + ".east"), name + ".north-east", name: name + "-skel-north-east")
          line((rel: (-height / 2, 0), to: name + ".east"), name + ".south-east", name: name + "-skel-south-east")
          line((rel: (height / 2, 0), to: name + ".west"), name + ".south-west", name: name + "-skel-south-west")
          line((rel: (height / 2, 0), to: name + ".west"), name + ".north-west", name: name + "-skel-north-west")
          if width != height { line(name + "-skel-north-west.start", name + "-skel-north-east.start", name: name + "-skel") }
        } else {
          line((rel: (0, -width / 2), to: name + ".north"), name + ".north-east", name: name + "-skel-north-east")
          line((rel: (0, -width / 2), to: name + ".north"), name + ".north-west", name: name + "-skel-north-west")
          line((rel: (0, width / 2), to: name + ".south"), name + ".south-east", name: name + "-skel-south-east")
          line((rel: (0, width / 2), to: name + ".south"), name + ".south-west", name: name + "-skel-south-west")
          line(name + "-skel-north-west.start", name + "-skel-south-east.start", name: name + "-skel") 
        }
      })
    }
  )
}

/// AKA the arrow keys:
/// ```text
///     __
///  __|__|__
/// |__|__|__|
///
///     4
///     |
///  1--2--3
/// ```
#let inverted-t(
  origin: (0, 0), 
  size: (1, 1),
  common-tags: (),
  names: ("left", "down", "right", "up"),
  default-style: physical-palette
) = {
  (
    (
      unit-rect(
        origin: origin, 
        size: (rel: size), 
        name: names.at(0),
        tags: common-tags,
        default-style: default-style
      )
    ),
    (
      unit-rect(
        origin: names.at(0) + ".south-east", 
        size: (rel: size), 
        name: names.at(1),
        tags: common-tags,
        default-style: default-style
      )
    ),
    (
      unit-rect(
        origin: names.at(1) + ".south-east", 
        size: (rel: size), 
        name: names.at(2),
        tags: common-tags,
        default-style: default-style
      )
    ),
    (
      unit-rect(
        origin: names.at(1) + ".north-west", 
        size: (rel: size), 
        name: names.at(3),
        tags: common-tags,
        default-style: default-style
      )
    ),
  )
}

/// Uncommon alternative to the arrow keys, with no center button:
/// ```text
///     __
///  __|__|__
/// |__|__|__|
///    |__|
/// 
///     4
///     |
///  1-- --3
///     |
///     2
/// ```
#let cross(
  origin: (0, 0), 
  size: (1, 1),
  common-tags: (),
  names: ("left", "down", "right", "up"),
  default-style: physical-palette
) = {
  let (size-x, size-y) = size

  (
    (
      unit-rect(
        origin: origin, 
        size: (rel: size), 
        name: names.at(0),
        tags: common-tags,
        default-style: default-style
      )
    ),
    (
      unit-rect(
        origin: names.at(0) + ".south-east", 
        size: (rel: (size-x, -size-y)), 
        name: names.at(1),
        tags: common-tags,
        default-style: default-style
      )
    ),
    (
      unit-rect(
        origin: names.at(1) + ".north-east", 
        size: (rel: size), 
        name: names.at(2),
        tags: common-tags,
        default-style: default-style
      )
    ),
    (
      unit-rect(
        origin: names.at(0) + ".north-east", 
        size: (rel: size), 
        name: names.at(3),
        tags: common-tags,
        default-style: default-style
      )
    ),
  )
}

/// One row of three buttons:
/// ```text
///  __ __ __
/// |__|__|__|
/// 
///  1--2--3
/// ```
#let one-by-three(
  origin: (0, 0), 
  size: (1, 1),
  common-tags: (),
  names: ("unnamed1", "unnamed2", "unnamed3"),
  default-style: physical-palette
) = {
  (
    (
      unit-rect(
        origin: origin, 
        size: (rel: size), 
        name: names.at(0),
        tags: common-tags,
        default-style: default-style
      )
    ),
    (
      unit-rect(
        origin: names.at(0) + ".south-east", 
        size: (rel: size), 
        name: names.at(1),
        tags: common-tags,
        default-style: default-style
      )
    ),
    (
      unit-rect(
        origin: names.at(1) + ".south-east", 
        size: (rel: size), 
        name: names.at(2),
        tags: common-tags,
        default-style: default-style
      )
    ),
  )
}

/// Two rows of three buttons:
/// ```text
///  __ __ __
/// |__|__|__|
/// |__|__|__|
/// 
///  1--2--3
///  4--5--6
/// ```
#let two-by-three(
  origin: (0, 0), 
  size: (1, 1),
  common-tags: (),
  names: ("unnamed1", "unnamed2", "unnamed3", "unnamed4", "unnamed5", "unnamed6"),
  default-style: physical-palette
) = {

  let (size-x, size-y) = size

  (
    (
      one-by-three(
        origin: origin, 
        size: size, 
        names: names.slice(0, count: 3),
        common-tags: common-tags,
        default-style: default-style
      )
    ),
    (
      one-by-three(
        origin: (rel: (0, -size-y), to: names.at(0) + ".south-west"), 
        size: size, 
        names: names.slice(3, count: 3),
        common-tags: common-tags,
        default-style: default-style
      )
    ),
  ).flatten()
}

/// Three rows of three buttons:
/// ```text
///  __ __ __
/// |__|__|__|
/// |__|__|__|
/// |__|__|__|
/// 
///  1--2--3
///  4--5--6
///  7--8--9
/// ```
#let three-by-three(
  origin: (0, 0), 
  size: (1, 1),
  common-tags: (),
  names: ("unnamed1", "unnamed2", "unnamed3", "unnamed4", "unnamed5", "unnamed6", "unnamed7", "unnamed8", "unnamed9"),
  default-style: physical-palette
) = {

  let (size-x, size-y) = size

  (
    (
      one-by-three(
        origin: origin, 
        size: size, 
        names: names.slice(0, count: 3),
        common-tags: common-tags,
        default-style: default-style
      )
    ),
    (
      one-by-three(
        origin: (rel: (0, -size-y), to: names.at(0) + ".south-west"), 
        size: size, 
        names: names.slice(3, count: 3),
        common-tags: common-tags,
        default-style: default-style
      )
    ),
    (
      one-by-three(
        origin: (rel: (0, -size-y), to: names.at(3) + ".south-west"), 
        size: size, 
        names: names.slice(6, count: 3),
        common-tags: common-tags,
        default-style: default-style
      )
    ),
  ).flatten()
}

/// One row of four buttons:
/// ```text
///  __ __ __ __
/// |__|__|__|__|
/// 
///  1--2--3--4
/// ```
#let one-by-four(
  origin: (0, 0), 
  size: (1, 1),
  common-tags: (),
  names: ("unnamed1", "unnamed2", "unnamed3", "unnamed4"),
  default-style: physical-palette
) = {
  (
    (
      unit-rect(
        origin: origin, 
        size: (rel: size), 
        name: names.at(0),
        tags: common-tags,
        default-style: default-style
      )
    ),
    (
      unit-rect(
        origin: names.at(0) + ".south-east", 
        size: (rel: size), 
        name: names.at(1),
        tags: common-tags,
        default-style: default-style
      )
    ),
    (
      unit-rect(
        origin: names.at(1) + ".south-east", 
        size: (rel: size), 
        name: names.at(2),
        tags: common-tags,
        default-style: default-style
      )
    ),
    (
      unit-rect(
        origin: names.at(2) + ".south-east", 
        size: (rel: size), 
        name: names.at(3),
        tags: common-tags,
        default-style: default-style
      )
    ),
  )
}