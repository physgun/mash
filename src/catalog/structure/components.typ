#import "../../deps.typ": cetz
#import "../structure/blocks.typ": unit-rect, inverted-t, one-by-three, two-by-three, three-by-three, one-by-four
#import "../display/flat.typ": debug-gray

#let structure-style = debug-gray

/// Prefab arrow keys, in the typical inverted "t" style.
#let arrow-keys(
  origin: (0, 0), 
  unit-size: (1, 1),
  common-tags: ("arrow", "cursor", "button"),
  names: ("left-arrow", "down-arrow", "right-arrow", "up-arrow"),
  default-style: structure-style
) = inverted-t(
  origin: origin, 
  unit-size: unit-size,
  common-tags: common-tags,
  names: names,
  default-style: default-style
)

/// Prefab standard number pad.
#let numpad(
  origin: (0, 0), 
  unit-size: (1, 1),
  common-tags: ("numpad", "button"),
  default-style: structure-style
) = {
  let (unit-x, unit-y) = unit-size
  let number-tags = common-tags
  number-tags.push("number")
  (
    (
      unit-rect(
        origin: origin, 
        size: (rel: (2 * unit-x, unit-y)), 
        name: "numpad-0",
        tags: number-tags,
        default-style: default-style
      )
    ),
    (
      unit-rect(
        origin: "numpad-0.south-east", 
        size: (rel: (unit-x, unit-y)), 
        name: "numpad-dot",
        tags: common-tags,
        default-style: default-style
      )
    ),
    (
      unit-rect(
        origin: "numpad-dot.south-east", 
        size: (rel: (unit-x, 2 * unit-y)), 
        name: "numpad-enter",
        tags: common-tags,
        default-style: default-style
      )
    ),
    (
      three-by-three(
        origin: "numpad-0.north-west", 
        unit-size: unit-size,
        common-tags: number-tags,
        names: ("numpad-1", "numpad-2", "numpad-3", "numpad-4", "numpad-5", "numpad-6", "numpad-7", "numpad-8", "numpad-9"),
        default-style: default-style
      )
    ),
    (
      unit-rect(
        origin: "numpad-6.south-east", 
        size: (rel: (unit-x, 2 * unit-y)), 
        name: "numpad-plus",
        tags: common-tags,
        default-style: default-style
      )
    ),
    (
      one-by-four(
        origin: "numpad-7.north-west", 
        unit-size: unit-size,
        common-tags: common-tags,
        names: ("numpad-numlock", "numpad-divide", "numpad-multiply", "numpad-minus"),
        default-style: default-style
      )
    )
  ).flatten()
}

/// The navigation key block, the one that has "Home" and "End".
#let nav-keys(
  origin: (0, 0), 
  unit-size: (1, 1),
  common-tags: ("navigation", "button"),
  names: ("nav-delete", "nav-end", "nav-page-down", "nav-insert", "nav-home", "nav-page-up"),
  default-style: structure-style
) = two-by-three(
  origin: origin, 
  unit-size: unit-size,
  common-tags: common-tags,
  names: names,
  default-style: default-style
)

/// These are those weird keys no-one uses, like "Scroll Lock".
#let sys-keys(
  origin: (0, 0), 
  unit-size: (1, 1),
  common-tags: ("system", "button"),
  names: ("sys-print-screen", "sys-scroll-lock", "sys-pause"),
  default-style: structure-style
) = one-by-three(
  origin: origin, 
  unit-size: unit-size,
  common-tags: common-tags,
  names: names,
  default-style: default-style
)

/// The full function row, sans sys-keys, including the spaces between the blocks.
#let func-row(
  origin: (0, 0), 
  unit-size: (1, 1),
  common-tags: ("button",),
  names: ("esc", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "f9", "f10", "f11", "f12"),
  default-style: structure-style
) = {
  let func-tags = common-tags
  let esc-tags = common-tags
  func-tags.push("function")
  esc-tags.push("system")

  let (unit-size-x, unit-size-y) = unit-size

  (
    (
      unit-rect(
        origin: origin, 
        size: unit-size, 
        name: names.at(0),
        tags: esc-tags,
        default-style: default-style
      )
    ),
    (
      one-by-four(
        origin: (rel: (unit-size-x, 0), to: names.at(0) + ".south-east"), 
        unit-size: unit-size,
        common-tags: func-tags,
        names: names.slice(1, count: 4),
        default-style: default-style
      )
    ),
    (
      one-by-four(
        origin: (rel: (unit-size-x / 2, 0), to: names.at(4) + ".south-east"), 
        unit-size: unit-size,
        common-tags: func-tags,
        names: names.slice(5, count: 4),
        default-style: default-style
      )
    ),
    (
      one-by-four(
        origin: (rel: (unit-size-x / 2, 0), to: names.at(8) + ".south-east"), 
        unit-size: unit-size,
        common-tags: func-tags,
        names: names.slice(9, count: 4),
        default-style: default-style
      )
    ),
  ).flatten()
}

/// The first, bottom row of the sixty percent keyboard.
#let sixty-percent-row-a(
  /// Available standards are ANSI, ANSI-ALT, ISO, JIS, KS, and ABNT.
  standard: "ANSI",
  origin: (0, 0), 
  unit-size: (1, 1),
  common-tags: ("button",),
  names: ("key-a1", "key-a2", "key-a3", "key-a4", "key-a5", "key-a6", "key-a7", "key-a8", "key-a9", "key-a10"),
  default-style: structure-style
) = {
  let (unit-size-x, unit-size-y) = unit-size
  let naming-index = 0

  let mod-tags = common-tags
  let char-tags = common-tags
  mod-tags.push("modifier")
  char-tags.push("character")

  let row-a = (
    one-by-three(
      origin: origin, 
      unit-size: (unit-size-x * 1.25, unit-size-y), 
      common-tags: mod-tags,
      names: names.slice(0, count: 3),
      default-style: default-style
    ),
  )
  naming-index = 3

  if standard == "ANSI" or "ANSI-ALT" or "ISO" or "ABNT" {

  } else if standard == "JIS" or "KS" {

  } else {
    panic("Row-A does not recognize standard " + repr(standard))
  }


  return row-a.flatten()
}