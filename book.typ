
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
  set page(
            paper: "a4",
            // height :21cm ,
            // width:14cm,
            numbering: "1",
            number-align: center
          )

  set text(size: 14pt)
  // set text(font: ("Cascadia Code", "CMU Sans Serif" ,"Latin Modern Sans", "Inria Serif", "Noto Sans Arabic"), lang: "en")
  set document(author: authors, title: title)


  show heading: set text(fill: rgb("#1e045b"))
  set heading(
    numbering: "I.1.1.",
  )

  show heading: it => pad(bottom: 0.5em, it)
  show heading.where(level: 1): set text(size:22pt)
  show heading.where(level: 2): set text(size:18pt)
  show heading.where(level: 3): set text(size:14pt)

  show heading.where(level: 1): it => {
    set par(justify: true)
    pagebreak(weak:true)
    if not it.body.text in execption_chapter {
      align(
        center,
        block(
          align(
            center,
            text(
              weight: "bold",
              size:18pt,
              fill: rgb("#FF0000"),
              [Chapitre ]
              + counter(heading).display()
            ) +
            linebreak() +
            v(1em) +
            text(
              weight: "bold",
              size:20pt,
              fill: rgb("#1e045b"),
              it.body
            )
            + v(5em)
          )
        )
      )
    }
    else {
      align(
        center,
        counter(heading).update(())
        + linebreak()
        + v(-2em)
        + text(
            weight: "bold",
            size:22pt,
            fill: rgb("#1e045b"),
            it.body
          )
        + linebreak()
        + v(3em)
      )
    }
  }

  set par(justify: true)


  show raw.where(block: true): it => pad(left: 4em, it)




  body
}

// #let linkb = (..it) => underline(text(fill: blue, link(..it)))
