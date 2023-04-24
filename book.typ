
#let execption_chapter=(
  "RÉSUMÉ.",
  "INTRODUCTION GÉNÉRALE.",
  "RÉFÉRENCES BIBLIOGRAPHIQUES.",
  "CONCLUSION",
)
#let book(
    dict,
    body
  ) = {
  let title=dict.title;
  let authors=dict.authors
  let encaders=dict.encaders
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


  show heading: set text(fill: rgb("#1e045b"))
  set heading(
    numbering: "I.1.1.",
  )

  show heading: it => pad(bottom: 0.5em, it)
  show heading.where(level: 1): set text(22pt)
  show heading.where(level: 2): set text(12pt)

  show heading.where(level: 1): it => {
    set par(justify: true)
    if not it.body.text in execption_chapter {
      pagebreak()
      block(
      align(
        center,
        text(
          weight: "bold",
          1em,
          fill: rgb("#FF0000"),
          [Chapitre ]
          + counter(heading).display()
        )

        + linebreak()
        + v(1em)
        + text(
          weight: "bold",
          1.5em,
          fill: rgb("#1e045b"),
          it.body
        )
        + v(5em)
      )
      )
    }
    else {
      counter(heading).update(())
      linebreak()
      text(fill: rgb("#1e045b"),it.body)
      linebreak()
    }
  }

  set par(justify: true)
  show raw.where(block: true): it => pad(left: 4em, it)



  body
}

// #let linkb = (..it) => underline(text(fill: blue, link(..it)))
