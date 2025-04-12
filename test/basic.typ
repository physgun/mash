#import "../src/lib.typ": mash
#import "../src/deps.typ": cetz

#set page(width: 14cm, height: auto, margin: 0.5em)

#lorem(100)

#mash(
  //debug: true
  {
    import cetz.draw: *
    import "../src/catalog/common.typ": unit-rect
    circle((5, 2), radius: 1)
    unit-rect(origin: (1, 1), target: (3, 2), name: "test-box").unnamed.cetz

  }
)

#lorem(100)