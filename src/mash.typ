#import "deps.typ": cetz

/// Central template for the dictionary format this package will use.
#let mash-entry = (
  /// Does not need to be unique.
  named: "unnamed",
  /// This is how entries will be grouped and filtered for modification.
  tags: ("empty",),
  /// Style parameters for the underlying diagram structure.
  style-structure: {},
  /// Array of cetz elements describing the diagram structure.
  cetz-structure: {},
)


/// "Renders" the final dictionary. 
/// 
/// This will flatten out all of the cetz entries into scoped, styled sections and return it to your canvas.
#let mash-render(
  finished-dict: (:),
  ) = {
  let final-cetz = ()
  let scoped-section = ()

  for entry in finished-dict {
    for (key, value) in entry {

      // "style-" type keys start a new section, unless the section is empty.
      if key.contains(regex("^style-")) {
        if scoped-section.len() != 0 {
          final-cetz.push({scope(scoped-section)})
          scoped-section = ().push(value)
        } else {
          scoped-section.push(value)
        }
      }

      if key.contains(regex("^cetz-")) {
        scoped-section.push(value)
      }
    }

    // Entry complete. push remaining if there is any.
    if scoped-section.len() != 0 {
      final-cetz.push(scoped-section)
      scoped-section = ()
    }
  }

  // here u go
  final-cetz.flatten()
}

/// The quick and easy way!
#let mash(
  body,
  auto-scale-all: (
    diagram: true,
    content: false,
    extra-cetz: false
  ),
  /// These values are passed directly into the cetz canvas.
  canvas: (
    background: none,
    debug: false,
    length: 1cm,
    padding: none
  ),
  extra-cetz: none
  ) = {
  layout(parent-container-size => {
    cetz.canvas(
      background: canvas.background,
      debug: canvas.debug,
      length: canvas.length,
      padding: canvas.padding,
      {
        import cetz.draw: *

        get-ctx(ctx => { 
          import cetz.process: aabb.size, many
          let (diagram-width, diagram-height, diagram-depth) = size( many(ctx, body).bounds ) 
          let parent-cetz-width = parent-container-size.width.to-absolute() / canvas.length.to-absolute()
          let parent-cetz-height = parent-container-size.height.to-absolute() / canvas.length.to-absolute()

          // If parent is the page, and the page dimension is set to 'auto', we'll get float.inf for that dimension.
          if parent-cetz-width == float.inf { parent-cetz-width = 1.0 }
          if parent-cetz-height == float.inf { parent-cetz-height = 1.0 }

          let width-ratio = diagram-width / parent-cetz-width
          let height-ratio = diagram-height / parent-cetz-height

          let (scale-x, scale-y) = (1, 1)

          if width-ratio >= height-ratio {
            scale-x = 1 / width-ratio
            scale-y = scale-x
          } else {
            scale-y = 1 / height-ratio
            scale-x = scale-y
          }

          //set-viewport((0, 0), (parent-cetz-width, parent-cetz-height), bounds: inner-bounds)
          scope({
            scale(x: scale-x, y: scale-y)
            body
            if auto-scale-all.extra-cetz { extra-cetz }
            rect((0, 0), (2.5, 2.5))
          circle((4, 4))
          })

          set-style(stroke: (paint: black))
          if not auto-scale-all.extra-cetz { extra-cetz }
          rect((0, 0), (2.5, 2.5))
          circle((4, 4))

        })
      }
    )
  })
}