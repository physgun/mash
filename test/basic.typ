#import "../src/lib.typ": mash, mash-render
#import "../src/deps.typ": cetz

#set page(width: 14cm, height: auto, margin: 0.5em)

#lorem(100)

#mash(
  //debug: true
  {
    import cetz.draw: *
    import "../src/catalog/common.typ": unit-rect, physical-palette, one-by-three, inverted-t, cross, two-by-three, three-by-three, one-by-four
    circle((5, 12), radius: 1)
    mash-render(finished-dict: one-by-four(origin: (1, 3), size: (1, 1)))

  }
)

#lorem(100)