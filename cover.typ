#let divider() = {
  line(length: 100%, stroke: 5pt + rgb("#C55A11"))
}

#let cover(book_info) = {
  let title=book_info.title
  let authors=book_info.authors
  let encaders=book_info.encaders
// #let cover(title: "", authors: (), encaders: ()) = {
  align(center,
    box(
      stroke:0pt,
      figure(
        image("images/fsm01.jpg", width: 40%, height:15%,fit: "cover"),
      )
    )
  )
  divider()
  align(center,
    block(
      text(
        weight: "bold", 2.0em,
        v(1.0em) +
        [Filière : Sciences de la Matière Physique] +
        v(0.25em) +
        [MÉMOIRE DE PROJET TUTORÉ]
      )
    )
  )
  v(2.5em)

  align(
    center,
    text(1.5em,
        [Presenter] +
        v(0.25em) +
        [ Par:]
      )
  )
  // pad(
  //   top: 0.5em,
  //   bottom: 2em,
  //   x: 2em,
  //   grid(
  //     columns: (1fr,) * calc.min(3, authors.len()),
  //     gutter: 1em,
  //     ..authors.map(author => align(center)[
  //       #author \
  //     ]),
  //   ),
  // )
// befin autors
 pad(
    top: 0.5em,
    bottom: 2em,
    x: 2em,
    text(weight: "bold",1.5em,
      table(
        columns: (1fr),
        align: center,
        stroke: none,
        row-gutter: 0.5em,
        inset: 3pt,
        ..authors
      )
    )
  )
// fin autor
  divider()
  v(1.0em)
  block(
    align(
      center,
      text(
        fill: rgb("#1E045B"),
        weight: "bold", 1.75em, h(40pt) + title
      )
    )
  )
  v(1.0em)
  divider()

  v(1.5em)

  align(
    center,
    block(
      text(
        weight: "bold", 1.5em,
        [Soutenu le 17/07/2020 devant la Commission d’Examen : ]
      )
    )
  )
  pad(
    top: 0.5em,
    bottom: 2em,
    x: 2em,
    text(weight: "bold",1.5em,
      table(
        columns: (2fr,1fr),
        align: left,
        stroke: none,
        row-gutter: 0.5em,
        inset: 3pt,
        ..encaders
      )
    )
  )
}

