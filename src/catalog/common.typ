#import "../deps.typ": cetz

/// Draw style for the physical base shapes.
#let physical-palette = (stroke: (paint: black, thickness: 1pt, dash: "dotted"))

/// Prefab for a rectangular section.
#let unit-rect(
  origin: (0, 0), 
  target: (1, 1),
  name: "unnamed"
) = {
  (
    unnamed: (
      tags: (
        "rectangle"
      ),
      palettes: {
        physical-palette
      },
      cetz: {
        import cetz.draw: rect, line, set-style

        // Base palette.
        set-style(..physical-palette)

        // Primary unit boundaries.
        rect(
          origin,
          target,
          name: name
        )

        // Construct straight skeleton for offset helper anchors.
        let ((x0, y0), (x1, y1)) = (origin, target)
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
      }
    )
  )
}