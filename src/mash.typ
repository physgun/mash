#import "deps.typ": cetz

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
  /// field comment
  canvas: (
    background: none,
    debug: false,
    length: 1cm,
    padding: none
  ),
  extra-cetz: none
  ) = {

  layout(parent-container-size => {
    // Scale normalized coordinates by the smallest dimension.
    let scale-factor = if parent-container-size.width >= parent-container-size.height { parent-container-size.height / canvas.length } 
    else { parent-container-size.width / canvas.length }

    if scale-factor == float.inf { scale-factor = 1.0 }

    cetz.canvas(
      background: canvas.background,
      debug: canvas.debug,
      length: canvas.length,
      padding: canvas.padding,
      {
        import cetz.draw: *

        scope({

          get-ctx(ctx => { 
            import cetz.process: aabb.size, many
            let raw-size = size( many(ctx, body).bounds ) 
            let normalized-dimension = calc.max(raw-size.at(0), raw-size.at(1))

            if auto-scale-all.content { set-style(content: (style: (auto-scale: true))) } // TODO: fix
            scale( if auto-scale-all.diagram { scale-factor } else { 1.0 } )

            rect((0, 0), (1, 1), name: "fill-box")
            content(style: (fill: white), (rel: (0, -0.1), to: "fill-box.north"), [#scale-factor])
            content("fill-box", [#raw-size])

            scope({
              set-viewport((0, 0), (canvas.length, canvas.length), bounds: (normalized-dimension, normalized-dimension))
              body
            })

            
          })


          if auto-scale-all.extra-cetz { extra-cetz }
          
        })

        if not auto-scale-all.extra-cetz { extra-cetz }

      }
    )
  })
}