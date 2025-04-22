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
      import "../src/catalog/structure/components.typ": numpad, nav-keys, func-row, sixty-percent-row-a
      mash-render(finished-dict: sixty-percent-row-a(standard: "ANSI", origin: (0, 0), unit-size: (1, 1)))
    })
  )
)

#lorem(100)