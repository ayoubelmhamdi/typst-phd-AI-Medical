// #let linkb = (..it) => underline(text(fill: blue, link(..it)))
#let divider() = {
  line(length: 100%, stroke: 5pt + rgb("#C55A11"))
}
// blue2: rgb("#1E045B")
#let pfe(title: "", authors: (), encaders: (), body) = {
  set text(font: "Cascadia Code", lang: "en")
  set page(
            paper: "a4",
            // height :21cm ,
            // width:14cm,
            numbering: "1",
            number-align: center
          )
  // set text(font: ("Cascadia Code", "CMU Sans Serif" ,"Latin Modern Sans", "Inria Serif", "Noto Sans Arabic"), lang: "en")
  set document(author: authors, title: title)
  set heading(numbering: "I.1.1.")
  show heading: it => pad(bottom: 0.5em, it)
  set par(justify: true)
  show raw.where(block: true): it => pad(left: 4em, it)



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

  pagebreak(weak:true)
  outline()
  pagebreak(weak:true)


  v(2em)

  body
}
