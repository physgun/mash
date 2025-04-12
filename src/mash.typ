#import "deps.typ": cetz

/// Main thing
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

        // Only the mashworks call gets scaled and configured in this scope, the remaining cetz args are dumped outside.
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