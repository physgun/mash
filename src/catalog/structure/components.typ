#import "../../deps.typ": cetz
#import "../structure/blocks.typ": unit-rect, place-on-grid,
#import "../display/flat.typ": debug-gray

#let structure-style = debug-gray

/// Prefab arrow keys, in the typical inverted "t" style.
#let arrow-keys(
  origin: (0, 0), 
  unit-size: (1, 1),
  common-tags: (),
  names: ("left-arrow", "down-arrow", "right-arrow", "up-arrow"),
  default-style: structure-style
) = {
  common-tags.push("arrow")
  common-tags.push("cursor")
  common-tags.push("button")
  place-on-grid(
    positions: ((1, 1), (1, 2), (1, 3), (2, 2)),
    origin: origin, 
    unit-size: unit-size,
    common-tags: common-tags,
    names: names,
    default-style: default-style
  )
}

/// Prefab standard number pad.
#let numpad(
  origin: (0, 0), 
  unit-size: (1, 1),
  common-tags: (),
  default-style: structure-style
) = {
  let (unit-x, unit-y) = unit-size

  common-tags.push("numpad")
  common-tags.push("button")
  let number-tags = common-tags
  let lock-tags = common-tags
  number-tags.push("number")
  lock-tags.push("lock")

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
      place-on-grid(
        positions: ((1, 1), (1, 2), (1, 3), (2, 1), (2, 2), (2, 3), (3, 1), (3, 2), (3, 3)),
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
      unit-rect(
        origin: "numpad-7.north-west", 
        size: (rel: (unit-x, unit-y)), 
        name: "numpad-numlock",
        tags: lock-tags,
        default-style: default-style
      )
    ),
    (
      place-on-grid(
        positions: ((1, 1), (1, 2), (1, 3)),
        origin: "numpad-numlock.south-east", 
        unit-size: unit-size,
        common-tags: common-tags,
        names: ("numpad-divide", "numpad-multiply", "numpad-minus"),
        default-style: default-style
      )
    )
  ).flatten()
}

/// The navigation key block, the one that has "Home" and "End".
#let nav-keys(
  origin: (0, 0), 
  unit-size: (1, 1),
  common-tags: (),
  names: ("nav-delete", "nav-end", "nav-page-down", "nav-insert", "nav-home", "nav-page-up"),
  default-style: structure-style
) = {
  common-tags.push("navigation")
  common-tags.push("button")

  place-on-grid(
    positions: ((1, 1), (1, 2), (1, 3), (2, 1), (2, 2), (2, 3)),
    origin: origin, 
    unit-size: unit-size,
    common-tags: common-tags,
    names: names,
    default-style: default-style
  )
}

/// These are those weird keys no-one uses, like "Scroll Lock".
#let sys-keys(
  origin: (0, 0), 
  unit-size: (1, 1),
  common-tags: (),
  names: ("sys-print-screen", "sys-scroll-lock", "sys-pause"),
  default-style: structure-style
) = {
  common-tags.push("system")
  common-tags.push("button")
  let lock-tags = common-tags
  lock-tags.push("lock")

  (
    (
      unit-rect(
        origin: origin, 
        size: (rel: unit-size), 
        name: names.at(0),
        tags: common-tags,
        default-style: default-style
      )
    ),
    (
      unit-rect(
        origin: names.at(0) + ".south-east", 
        size: (rel: unit-size), 
        name: names.at(1),
        tags: lock-tags,
        default-style: default-style
      )
    ),
    (
      unit-rect(
        origin: names.at(1) + ".south-east", 
        size: (rel: unit-size), 
        name: names.at(2),
        tags: common-tags,
        default-style: default-style
      )
    ),
  ).flatten()
}

/// The full function row, sans sys-keys, including the spaces between the blocks.
#let func-row(
  origin: (0, 0), 
  unit-size: (1, 1),
  common-tags: (),
  names: ("esc", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "f9", "f10", "f11", "f12"),
  default-style: structure-style
) = {
  common-tags.push("button")
  let func-tags = common-tags
  let esc-tags = common-tags
  func-tags.push("function")
  esc-tags.push("system")

  let (unit-size-x, unit-size-y) = unit-size

  (
    (
      unit-rect(
        origin: origin, 
        size: (rel: unit-size, to: origin), 
        name: names.at(0),
        tags: esc-tags,
        default-style: default-style
      )
    ),
    (
      place-on-grid(
        positions: ((1, 1), (1, 2), (1, 3), (1, 4)),
        origin: (rel: (unit-size-x, 0), to: names.at(0) + ".south-east"), 
        unit-size: unit-size,
        common-tags: func-tags,
        names: names.slice(1, count: 4),
        default-style: default-style
      )
    ),
    (
      place-on-grid(
        positions: ((1, 1), (1, 2), (1, 3), (1, 4)),
        origin: (rel: (unit-size-x / 2, 0), to: names.at(4) + ".south-east"), 
        unit-size: unit-size,
        common-tags: func-tags,
        names: names.slice(5, count: 4),
        default-style: default-style
      )
    ),
    (
      place-on-grid(
        positions: ((1, 1), (1, 2), (1, 3), (1, 4)),
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
  common-tags: (),
  names: ("key-a1", "key-a2", "key-a3", "key-a4", "key-a5", "key-a6", "key-a7", "key-a8", "key-a9", "key-a10"),
  default-style: structure-style
) = {
  let (unit-size-x, unit-size-y) = unit-size
  let naming-index = 0

  common-tags.push("row-a")
  common-tags.push("button")
  let mod-tags = common-tags
  let char-tags = common-tags
  mod-tags.push("modifier")
  char-tags.push("character")

  let row-a = (
    place-on-grid(
      positions: ((1, 1), (1, 2), (1, 3)),
      origin: origin, 
      unit-size: (unit-size-x * 1.25, unit-size-y), 
      common-tags: mod-tags,
      names: names.slice(0, count: 3),
      default-style: default-style
    ),
  )
  naming-index = 3

  if standard == "ANSI" or standard == "ANSI-ALT" or standard == "ISO" or standard == "ABNT" {
    row-a.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east", 
        size: (rel: (unit-size-x * 6.25, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: char-tags,
        default-style: default-style
      )
    )
    naming-index += 1
  } else if standard == "JIS" or standard == "KS" {
    row-a.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east", 
        size: (rel: (unit-size-x, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: mod-tags,
        default-style: default-style
      )
    )
    naming-index += 1

    row-a.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east", 
        size: (rel: (unit-size-x * 4.25, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: char-tags,
        default-style: default-style
      )
    )
    naming-index += 1

    row-a.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east", 
        size: (rel: (unit-size-x, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: mod-tags,
        default-style: default-style
      )
    )
    naming-index += 1
  } else {
    panic("Row-A does not recognize standard " + repr(standard))
  }
  
  row-a.push(
    place-on-grid(
      positions: ((1, 1), (1, 2), (1, 3), (1, 4)),
      origin: names.at(naming-index - 1) + ".south-east", 
      unit-size: (unit-size-x * 1.25, unit-size-y), 
      common-tags: mod-tags,
      names: names.slice(naming-index, count: 4),
      default-style: default-style
    )
  )

  return row-a.flatten()
}

/// The second from the bottom row of the sixty percent keyboard.
#let sixty-percent-row-b(
  /// Available standards are ANSI, ANSI-ALT, ISO, JIS, KS, and ABNT.
  standard: "ANSI",
  origin: (0, 0), 
  unit-size: (1, 1),
  common-tags: (),
  names: ("key-b1", "key-b2", "key-b3", "key-b4", "key-b5", "key-b6", "key-b7", "key-b8", "key-b9", "key-b10", "key-b11", "key-b12", "key-b13", "key-b14"),
  default-style: structure-style
) = {
  let (unit-size-x, unit-size-y) = unit-size
  let naming-index = 0

  common-tags.push("row-b")
  common-tags.push("button")
  let mod-tags = common-tags
  let alpha-tags = common-tags
  let symbol-tags = common-tags
  mod-tags.push("modifier")
  alpha-tags.push("character")
  alpha-tags.push("alpha")
  symbol-tags.push("character")
  symbol-tags.push("symbol")

  let row-b = ()

  if standard == "ANSI" or standard == "ANSI-ALT" or standard == "JIS" or standard == "KS" {
    row-b.push(
      unit-rect(
        origin: origin, 
        size: (rel: (unit-size-x * 2.25, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: mod-tags,
        default-style: default-style
      )
    )
    naming-index += 1
  } else if standard == "ISO" or standard == "ABNT" {
    row-b.push(
      unit-rect(
        origin: origin, 
        size: (rel: (unit-size-x * 1.25, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: mod-tags,
        default-style: default-style
      )
    )
    naming-index += 1

    row-b.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east",
        size: (rel: (unit-size-x, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: symbol-tags,
        default-style: default-style
      )
    )
    naming-index += 1
  } else {
    panic("Row-B does not recognize standard " + repr(standard))
  }

  for alpha-key in range(7) {
    row-b.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east",
        size: (rel: (unit-size-x, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: alpha-tags,
        default-style: default-style
      )
    )
    naming-index += 1
  }

  for symbol-key in range(3) {
    row-b.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east",
        size: (rel: (unit-size-x, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: symbol-tags,
        default-style: default-style
      )
    )
    naming-index += 1
  }

  if standard == "ANSI" or standard == "ANSI-ALT" or standard == "ISO" or standard == "KS" {
    row-b.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east",
        size: (rel: (unit-size-x * 2.75, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: mod-tags,
        default-style: default-style
      )
    )
    naming-index += 1
  } else if standard == "JIS" or standard == "ABNT" {
    row-b.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east",
        size: (rel: (unit-size-x, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: symbol-tags,
        default-style: default-style
      )
    )
    naming-index += 1

    row-b.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east",
        size: (rel: (unit-size-x * 1.75, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: mod-tags,
        default-style: default-style
      )
    )
    naming-index += 1
  } else {
    panic("Row-B does not recognize standard " + repr(standard))
  }

  return row-b.flatten()
}

/// The third from the bottom row of the sixty percent keyboard, sans return key.
#let sixty-percent-row-c(
  /// Available standards are ANSI, ANSI-ALT, ISO, JIS, KS, and ABNT.
  standard: "ANSI",
  origin: (0, 0), 
  unit-size: (1, 1),
  common-tags: (),
  names: ("key-c1", "key-c2", "key-c3", "key-c4", "key-c5", "key-c6", "key-c7", "key-c8", "key-c9", "key-c10", "key-c11", "key-c12", "key-c13"),
  default-style: structure-style
) = {
  let (unit-size-x, unit-size-y) = unit-size
  let naming-index = 0

  common-tags.push("row-c")
  common-tags.push("button")
  let lock-tags = common-tags
  let alpha-tags = common-tags
  let symbol-tags = common-tags
  lock-tags.push("lock")
  alpha-tags.push("character")
  alpha-tags.push("alpha")
  symbol-tags.push("character")
  symbol-tags.push("symbol")

  let row-c = (
    unit-rect(
      origin: origin, 
      size: (rel: (unit-size-x * 1.75, unit-size-y), to: ()), 
      name: names.at(naming-index),
      tags: lock-tags,
      default-style: default-style
    ),
  )
  naming-index += 1

  for alpha-key in range(9) {
    row-c.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east",
        size: (rel: (unit-size-x, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: alpha-tags,
        default-style: default-style
      )
    )
    naming-index += 1
  }

  for alpha-key in range(2) {
    row-c.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east",
        size: (rel: (unit-size-x, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: symbol-tags,
        default-style: default-style
      )
    )
    naming-index += 1
  }

  if standard == "ISO" or standard == "ABNT" or standard == "JIS" {
    row-c.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east",
        size: (rel: (unit-size-x, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: symbol-tags,
        default-style: default-style
      )
    )
    naming-index += 1
  }

  return row-c.flatten()
}

/// The fourth from the bottom row of the sixty percent keyboard, sans return key.
#let sixty-percent-row-d(
  /// Available standards are ANSI, ANSI-ALT, ISO, JIS, KS, and ABNT.
  standard: "ANSI",
  origin: (0, 0), 
  unit-size: (1, 1),
  common-tags: (),
  names: ("key-d1", "key-d2", "key-d3", "key-d4", "key-d5", "key-d6", "key-d7", "key-d8", "key-d9", "key-d10", "key-d11", "key-d12", "key-d13", "key-d14"),
  default-style: structure-style
) = {
  let (unit-size-x, unit-size-y) = unit-size
  let naming-index = 0

  common-tags.push("row-d")
  common-tags.push("button")
  let mod-tags = common-tags
  let alpha-tags = common-tags
  let symbol-tags = common-tags
  mod-tags.push("modifier")
  alpha-tags.push("character")
  alpha-tags.push("alpha")
  symbol-tags.push("character")
  symbol-tags.push("symbol")

  let row-d = (
    unit-rect(
      origin: origin, 
      size: (rel: (unit-size-x * 1.5, unit-size-y), to: ()), 
      name: names.at(naming-index),
      tags: mod-tags,
      default-style: default-style
    ),
  )
  naming-index += 1

  for alpha-key in range(10) {
    row-d.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east",
        size: (rel: (unit-size-x, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: alpha-tags,
        default-style: default-style
      )
    )
    naming-index += 1
  }

  for alpha-key in range(2) {
    row-d.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east",
        size: (rel: (unit-size-x, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: symbol-tags,
        default-style: default-style
      )
    )
    naming-index += 1
  }

  if standard == "ANSI" {
    row-d.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east",
        size: (rel: (unit-size-x * 1.5, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: symbol-tags,
        default-style: default-style
      )
    )
    naming-index += 1
  }

  return row-d.flatten()
}

/// The top of the sixty percent keyboard.
#let sixty-percent-row-e(
  /// Available standards are ANSI, ANSI-ALT, ISO, JIS, KS, and ABNT.
  standard: "ANSI",
  origin: (0, 0), 
  unit-size: (1, 1),
  common-tags: (),
  names: ("key-e1", "key-e2", "key-e3", "key-e4", "key-e5", "key-e6", "key-e7", "key-e8", "key-e9", "key-e10", "key-e11", "key-e12", "key-e13", "key-e14", "key-e15"),
  default-style: structure-style
) = {
  let (unit-size-x, unit-size-y) = unit-size
  let naming-index = 0

  common-tags.push("row-e")
  common-tags.push("button")
  let edit-tags = common-tags
  let number-tags = common-tags
  let symbol-tags = common-tags
  edit-tags.push("edit")
  number-tags.push("character")
  number-tags.push("number")
  symbol-tags.push("character")
  symbol-tags.push("symbol")

  let row-e = (
    unit-rect(
      origin: origin, 
      size: (rel: (unit-size-x, unit-size-y), to: ()), 
      name: names.at(naming-index),
      tags: symbol-tags,
      default-style: default-style
    ),
  )
  naming-index += 1

  for number-key in range(10) {
    row-e.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east",
        size: (rel: (unit-size-x, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: number-tags,
        default-style: default-style
      )
    )
    naming-index += 1
  }

  for alpha-key in range(2) {
    row-e.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east",
        size: (rel: (unit-size-x, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: symbol-tags,
        default-style: default-style
      )
    )
    naming-index += 1
  }

  if standard == "ANSI" or standard == "ISO" or standard == "ABNT" {
    row-e.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east",
        size: (rel: (unit-size-x * 2, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: edit-tags,
        default-style: default-style
      )
    )
    naming-index += 1
  } else if standard == "ANSI-ALT" or standard == "KS" or standard == "JIS" {
    row-e.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east",
        size: (rel: (unit-size-x, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: symbol-tags,
        default-style: default-style
      )
    )
    naming-index += 1

    row-e.push(
      unit-rect(
        origin: names.at(naming-index - 1) + ".south-east",
        size: (rel: (unit-size-x, unit-size-y), to: ()), 
        name: names.at(naming-index),
        tags: edit-tags,
        default-style: default-style
      )
    )
    naming-index += 1
  } else {
    panic("Row-E does not recognize standard " + repr(standard))
  }

  return row-e.flatten()
}