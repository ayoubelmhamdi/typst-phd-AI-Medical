#let divider() = {
  line(length: 100%, stroke: 5pt + rgb("#C55A11"))
}

#let cover(book_info) = {
  let title=book_info.title
  let authors=book_info.authors
  let encaders=book_info.encaders
// #let cover(title: "", authors: (), encaders: ()) = {
  v(-2.25em)
  align(center,
    // box(
    //   stroke:0pt,
      figure(
        image("images/fsm02.jpg", width: 40%, height:15%,fit: "contain"),
      )
    // )
  )
  divider()
  align(center,
    block(
      text(
        weight: "bold",
        size: 22pt,
        v(0.5em) +
        [Filière : Sciences de la Matière Physique] +
        v(0.25em) +
        [MÉMOIRE DE PROJET TUTORÉ]
      )
    )
  )
  v(1.5em)

  align(
    center,
    text(
      size:18pt,
        [Présenté] +
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
    text(
      weight: "bold",
      size:18pt,
      table(
        columns: (1fr),
        align: center,
        stroke: none,
        row-gutter: 0.5em,
        inset: 3pt,
        ..authors
      )
    )
// fin autor
  divider()
  // v(1.0em)
  block(
    align(
      center,
      text(
        fill: rgb("#1E045B"),
        weight: "bold",
        size:20pt,
        h(40pt) + title
      )
    )
  )
  // v(1.0em)
  divider()

  v(1.5em)

  align(
    center,
    block(
      text(
        weight: "bold",
        size:16pt,
        [Soutenu le 17/07/2020 devant la Commission d’Examen : ]
      )
    )
  )
  pad(
    top: 0.5em,
    bottom: 2em,
    x: 2em,
    text(
      weight: "bold",
      size:16pt,
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

