#let heading_center(title) = {
  align(
      center,
      text(
        fill: rgb("#1e045b"),
        weight: "bold", 1.80em,
        title
    )
  )
  v(5em)
}


#let heading_without_numbering(title) = {
  heading(numbering:none,title)
}
