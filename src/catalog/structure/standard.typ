#import "../../deps.typ": cetz,
#import "../../mash.typ": mash-entry
#import "../structure/components.typ": *
#import "../display/flat.typ": debug-gray

#let structure-style = debug-gray

/// The "60%" of a standard keyboard, the primary block of alphanumeric characters and modifiers.
#let sixty-percent(
  /// Available standards are ANSI, ANSI-ALT, ISO, JIS, KS, and ABNT.
  standard: "ANSI",
  origin: (0, 0), 
  unit-size: (1, 1),
  common-tags: (),
  default-style: structure-style
) = {
  let (unit-size-x, unit-size-y) = unit-size

  common-tags.push("sixty-percent")

  let sixty-board = (
    (
      sixty-percent-row-a(
        standard: standard,
        origin: origin, 
        unit-size: unit-size,
        common-tags: common-tags,
        default-style: structure-style
      )
    ),
    (
      sixty-percent-row-b(
        standard: standard,
        origin: "key-a1.north-west", 
        unit-size: unit-size,
        common-tags: common-tags,
        default-style: structure-style
      )
    ),
    (
      sixty-percent-row-c(
        standard: standard,
        origin: "key-b1.north-west", 
        unit-size: unit-size,
        common-tags: common-tags,
        default-style: structure-style
      )
    ),
    (
      sixty-percent-row-d(
        standard: standard,
        origin: "key-c1.north-west", 
        unit-size: unit-size,
        common-tags: common-tags,
        default-style: structure-style
      )
    ),
    (
      sixty-percent-row-e(
        standard: standard,
        origin: "key-d1.north-west", 
        unit-size: unit-size,
        common-tags: common-tags,
        default-style: structure-style
      )
    ),
  )

  // And now for the "standard" keyboard's three different return keys,
  // with their corresponding straight skeletons.
  let return-name = "return"
  let return-entry = mash-entry

  if standard == "ANSI" {

    // Wow, a rectangular button. What a concept.
    sixty-board.push(
      unit-rect(
        origin: "key-c12.south-east",
        size: (rel: (unit-size-x * 2.25, unit-size-y)), 
        name: return-name,
        tags: ("button", "row-c", "edit", "sixty-percent"), // technically a character key but w/e
        default-style: structure-style
      )
    )
  } else if standard == "ISO" or standard == "JIS" or standard == "ABNT" {

    // The unique ISO return key.
    return-entry.named = return-name
    return-entry.tags = ("button", "edit", "sixty-percent", "polygon")
    return-entry.style-structure = {
      import cetz.draw: set-style
      set-style(..structure-style)
    }
    return-entry.cetz-structure = {
      import cetz.draw: line

      let row-b-end-key = if standard == "ABNT" {"key-b14"} else {"key-b13"}
      let row-e-end-key = if standard == "JIS" {"key-e15"} else {"key-e14"}

      // Primary unit boundaries.
      line(
        row-b-end-key + ".north-east", "key-c13.south-east", "key-c13.north-east", 
        "key-d13.south-east", "key-d13.north-east", row-e-end-key + ".south-east",
        close: true,
        name: return-name
      )

      // Construct straight skeleton for offset helper anchors.
      // These lengths determine what edges collapse first for any L-shaped orthogonal polygon without holes.
      let south-end-length = unit-size-x * 1.25
      let west-end-length = unit-size-y
      let north-face-length = unit-size-x * 1.5
      let east-face-length = unit-size-y * 2

      // Core skeleton vertices.
      let begin-point = ()
      let inner-corner-point = ()
      let remaining-point = ()
      let end-point = ()

      // The smaller of the end edges collapses first, and the inside corner vertex joins this collapsed edge.
      // The end edges being equal is a special case (all edges collapse simultaneously), but cetz's line()
      // doesn't mind duplicate vertices, so we use the same algorithm for it too.
      if west-end-length <= south-end-length {
        begin-point = (rel: (west-end-length / 2, west-end-length / 2), to: "key-d13.south-east")
        inner-corner-point = (rel: (west-end-length / 2, west-end-length / 2), to: "key-c13.north-east")

        // Find second collapse, build skeleton.
        if east-face-length <= south-end-length {
          end-point = (rel: (-east-face-length / 2, east-face-length / 2), to: row-b-end-key + ".north-east")
          remaining-point = (rel: (east-face-length / 2, east-face-length / 2), to: "key-c13.south-east")

          line(begin-point, inner-corner-point, remaining-point, end-point, name: return-name + "-skelecore")

          line(begin-point, "key-d13.south-east", name: return-name + "-skele-1")
          line(begin-point, "key-d13.north-east", name: return-name + "-skele-2")
          line(end-point, row-e-end-key + ".south-east", name: return-name + "-skele-3")
          line(end-point, row-b-end-key + ".north-east", name: return-name + "-skele-4")
          line(remaining-point, "key-c13.south-east", name: return-name + "-skele-5")
          line(inner-corner-point, "key-c13.north-east", name: return-name + "-skele-6")
        } else {
          end-point = (rel: (south-end-length / 2, south-end-length / 2), to: "key-c13.south-east")
          remaining-point = (rel: (-south-end-length / 2, -south-end-length / 2), to: row-e-end-key + ".south-east")

          line(begin-point, inner-corner-point, remaining-point, end-point, name: return-name + "-skelecore")

          line(begin-point, "key-d13.south-east", name: return-name + "-skele-1")
          line(begin-point, "key-d13.north-east", name: return-name + "-skele-2")
          line(remaining-point, row-e-end-key + ".south-east", name: return-name + "-skele-3")
          line(end-point, row-b-end-key + ".north-east", name: return-name + "-skele-4")
          line(end-point, "key-c13.south-east", name: return-name + "-skele-5")
          line(inner-corner-point, "key-c13.north-east", name: return-name + "-skele-6")
        }

      } else {
        begin-point = (rel: (south-end-length / 2, south-end-length / 2), to: "key-c13.south-east")
        inner-corner-point = (rel: (south-end-length / 2, south-end-length / 2), to: "key-c13.north-east")

        if north-face-length <= west-end-length {
          end-point = (rel: (north-face-length / 2, -north-face-length / 2), to: "key-d13.north-east")
          remaining-point = (rel: (north-face-length / 2, north-face-length / 2), to: "key-d13.south-east")

          line(begin-point, inner-corner-point, remaining-point, end-point, name: return-name + "-skelecore")

          line(begin-point, row-b-end-key + ".north-east", name: return-name + "-skele-1")
          line(begin-point, "key-c13.south-east", name: return-name + "-skele-2")
          line(inner-corner-point, "key-c13.north-east", name: return-name + "-skele-3")
          line(remaining-point, "key-d13.south-east", name: return-name + "-skele-4")
          line(end-point, "key-d13.north-east", name: return-name + "-skele-5")
          line(end-point, row-e-end-key + ".south-east", name: return-name + "-skele-6")
        } else { // Rare, but possible if unit-x is slightly smaller than unit-y.
          end-point = (rel: (west-end-length / 2, west-end-length / 2), to: "key-d13.south-east")
          remaining-point = (rel: (-south-end-length / 2, -south-end-length / 2), to: row-e-end-key + ".south-east")

          line(begin-point, inner-corner-point, remaining-point, end-point, name: return-name + "-skelecore")
          
          line(begin-point, row-b-end-key + ".north-east", name: return-name + "-skele-1")
          line(begin-point, "key-c13.south-east", name: return-name + "-skele-2")
          line(inner-corner-point, "key-c13.north-east", name: return-name + "-skele-3")
          line(end-point, "key-d13.south-east", name: return-name + "-skele-4")
          line(end-point, "key-d13.north-east", name: return-name + "-skele-5")
          line(remaining-point, row-e-end-key + ".south-east", name: return-name + "-skele-6")
        }
      }
    }

    sixty-board.push(return-entry)

  } else if standard == "ANSI-ALT" or standard == "KS" {

    // Mostly found in Asia, known in the West as "big-ass enter".
    // Same as ISO, just flipped.
    
    return-entry.named = return-name
    return-entry.tags = ("button", "edit", "sixty-percent", "polygon")
    return-entry.style-structure = {
      import cetz.draw: set-style
      set-style(..structure-style)
    }
    return-entry.cetz-structure = {
      import cetz.draw: rect, line

      // Primary unit boundaries.
      line(
        "key-b12.north-east", "key-c12.south-east", "key-c12.north-east", 
        "key-d13.south-east", "key-d13.north-east", "key-e15.south-east",
        close: true,
        name: return-name
      )

      let south-face-length = unit-size-x * 2.25
      let west-end-length = unit-size-y
      let north-end-length = unit-size-x * 1.5
      let east-face-length = unit-size-y * 2

      let begin-point = ()
      let inner-corner-point = ()
      let remaining-point = ()
      let end-point = ()

      if west-end-length <= north-end-length {
        begin-point = (rel: (west-end-length / 2, west-end-length / 2), to: "key-c12.south-east")
        inner-corner-point = (rel: (west-end-length / 2, -west-end-length / 2), to: "key-d13.south-east")

        if east-face-length <= north-end-length {
          end-point = (rel: (-east-face-length / 2, east-face-length / 2), to: "key-b12.north-east")
          remaining-point = (rel: (east-face-length / 2, -east-face-length / 2), to: "key-d13.north-east")

          line(begin-point, inner-corner-point, remaining-point, end-point, name: return-name + "-skelecore")

          line(begin-point, "key-c12.south-east", name: return-name + "-skele-1")
          line(begin-point, "key-c12.north-east", name: return-name + "-skele-2")
          line(inner-corner-point, "key-d13.south-east", name: return-name + "-skele-3")
          line(remaining-point, "key-d13.north-east", name: return-name + "-skele-4")
          line(end-point, "key-e15.south-east", name: return-name + "-skele-5")
          line(end-point, "key-b12.north-east", name: return-name + "-skele-6")
          
        } else {
          end-point = (rel: (north-end-length / 2, -north-end-length / 2), to: "key-d13.north-east")
          remaining-point = (rel: (-north-end-length / 2, north-end-length / 2), to: "key-b12.north-east")

          line(begin-point, inner-corner-point, remaining-point, end-point, name: return-name + "-skelecore")

          line(begin-point, "key-c12.south-east", name: return-name + "-skele-1")
          line(begin-point, "key-c12.north-east", name: return-name + "-skele-2")
          line(inner-corner-point, "key-d13.south-east", name: return-name + "-skele-3")
          line(end-point, "key-d13.north-east", name: return-name + "-skele-4")
          line(end-point, "key-e15.south-east", name: return-name + "-skele-5")
          line(remaining-point, "key-b12.north-east", name: return-name + "-skele-6")
        }
      } else {
        begin-point = (rel: (north-end-length / 2, -north-end-length / 2), to: "key-d13.north-east")
        inner-corner-point = (rel: (north-end-length / 2, -north-end-length / 2), to: "key-d13.south-east")

        if south-face-length <= west-end-length {
          end-point = (rel: (-south-face-length / 2, south-face-length / 2), to: "key-b12.north-east")
          remaining-point = (rel: (south-face-length / 2, -south-face-length / 2), to: "key-c12.north-east")

          line(begin-point, inner-corner-point, remaining-point, end-point, name: return-name + "-skelecore")

          line(begin-point, "key-d13.north-east", name: return-name + "-skele-1")
          line(begin-point, "key-e15.south-east", name: return-name + "-skele-2")
          line(end-point, "key-b12.north-east", name: return-name + "-skele-3")
          line(end-point, "key-c12.south-east", name: return-name + "-skele-4")
          line(remaining-point, "key-c12.north-east", name: return-name + "-skele-5")
          line(inner-corner-point, "key-d13.south-east", name: return-name + "-skele-6")
        } else {
          end-point = (rel: (west-end-length / 2, west-end-length / 2), to: "key-c12.south-east")
          remaining-point = (rel: (-west-end-length / 2, west-end-length / 2), to: "key-b12.north-east")

          line(begin-point, inner-corner-point, remaining-point, end-point, name: return-name + "-skelecore")

          line(begin-point, "key-d13.north-east", name: return-name + "-skele-1")
          line(begin-point, "key-e15.south-east", name: return-name + "-skele-2")
          line(remaining-point, "key-b12.north-east", name: return-name + "-skele-3")
          line(end-point, "key-c12.south-east", name: return-name + "-skele-4")
          line(end-point, "key-c12.north-east", name: return-name + "-skele-5")
          line(inner-corner-point, "key-d13.south-east", name: return-name + "-skele-6")
        }
      }
    }

    sixty-board.push(return-entry)

  } else {
    panic("Sixty-percent does not recognize standard " + repr(standard))
  }

  return sixty-board.flatten()
}

/// 80% of a standard keyboard, everything but the numpad.
#let eighty-percent(
  /// Available standards are ANSI, ANSI-ALT, ISO, JIS, KS, and ABNT.
  standard: "ANSI",
  origin: (0, 0), 
  unit-size: (1, 1),
  /// Horizontal and vertical spacing between the major button groups.
  spacing: (x: 0.25, y: 0.25),
  common-tags: (),
  default-style: structure-style
) = {
  let (unit-size-x, unit-size-y) = unit-size

  common-tags.push("eighty-percent")

  let eighty-board = (
    (
      sixty-percent(
        standard: standard,
        origin: origin,
        unit-size: unit-size,
        common-tags: common-tags,
        default-style: default-style
      )
    ),
    (
      func-row(
        origin: (rel: (0, spacing.y), to: "key-e1.north-west"),
        unit-size: unit-size,
        common-tags: common-tags,
        default-style: default-style
      )
    ),
    (
      sys-keys(
        origin: (rel: (spacing.x, 0), to: "f12.south-east"),
        unit-size: unit-size,
        common-tags: common-tags,
        default-style: default-style
      )
    ),
    (
      nav-keys(
        origin: (rel: (0, -spacing.y - (2 * unit-size-y)), to: "sys-print-screen.south-west"),
        unit-size: unit-size,
        common-tags: common-tags,
        default-style: default-style
      )
    ),
    (
      arrow-keys(
        origin: (rel: (0, -3 * unit-size-y), to: "nav-delete.south-west"),
        unit-size: unit-size,
        common-tags: common-tags,
        default-style: default-style
      )
    )
  )

  return eighty-board.flatten()
}

/// The entire 100% standard keyboard.
#let hundred-percent(
  /// Available standards are ANSI, ANSI-ALT, ISO, JIS, KS, and ABNT.
  standard: "ANSI",
  origin: (0, 0), 
  unit-size: (1, 1),
  /// Horizontal and vertical spacing between the major button groups.
  spacing: (x: 0.25, y: 0.25),
  common-tags: (),
  default-style: structure-style
) = {
  common-tags.push("hundred-percent")

  let hundred-board = (
    (
      eighty-percent(
        standard: standard,
        origin: origin,
        unit-size: unit-size,
        spacing: spacing,
        common-tags: common-tags,
        default-style: default-style
      )
    ),
    (
      numpad(
        origin: (rel: (spacing.x, 0), to: "right-arrow.south-east"),
        unit-size: unit-size,
        common-tags: common-tags,
        default-style: default-style
      )
    )
  )

  return hundred-board.flatten()
}