#import "../src/lib.typ": mash, mash-render
#import "../src/deps.typ": cetz

#set page(width: 14cm, height: auto, margin: 0.5em)

#lorem(100)

#align(center + horizon, 
  box(
    height: 5cm,
    width: 10cm,
    fill: blue.lighten(80%),
    mash({
      import "../src/catalog/structure/standard.typ": sixty-percent
      mash-render(finished-dict: sixty-percent(standard: "ANSI-ALT", origin: (0, 0), unit-size: (1, 1)))
    })
  )
)

#lorem(100)