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

    // here u go
    final-cetz.flatten()

  }
}

/// The quick and easy way!x
#let mash(
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
  extra-cetz
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
          if auto-scale-all.content { set-style(content: (style: (auto-scale: true))) } // TODO: fix
          scale( if auto-scale-all.diagram { scale-factor } else { 1.0 } )

          rect((0, 0), (1, 1), name: "fill-box")
          content("fill-box", [#scale-factor, #{float.inf > 100}])

          if auto-scale-all.extra-cetz { extra-cetz }
        })

        if not auto-scale-all.extra-cetz { extra-cetz }

      }
    )
  })
}