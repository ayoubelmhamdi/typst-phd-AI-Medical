
#let execption_chapter=(
  "RÉSUMÉ.",
  "INTRODUCTION GÉNÉRALE.",
  "RÉFÉRENCES BIBLIOGRAPHIQUES.",
  "CONCLUSION",
)

#let execption_outline=(
  "REMERCIEMENTS",
  "TABLE DES MATIÈRES",
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
  set document(author: authors, title: title)


  show heading: set text(fill: rgb("#1e045b"))
  set heading(
    numbering: "I.1.1.",
  )

  show heading: it => pad(bottom: 0.5em, it)
  show heading.where(level: 1): set text(size:22pt)
  show heading.where(level: 2): set text(size:18pt)
  show heading.where(level: 3): set text(size:14pt)

  // ===========================================
  // ===========================================
  show heading.where(level: 1): it => {
    set par(justify: true)
    pagebreak(weak:true)
    v(3.5em)
    if it.body.text in execption_outline {
      // like REMERCIEMENTS
      align(
          center,
          text(
            fill: rgb("#1e045b"),
            weight: "bold",
            size:22pt,
            it.body
        )
      )
    }
    else if it.body.text in execption_chapter {
    // like RÉFÉRENCES BIBLIOGRAPHIQUES.
      align(
        center,
        counter(heading).update(())
        + linebreak()
        // + v(-4em)
        + text(
            weight: "bold",
            size:22pt,
            fill: rgb("#1e045b"),
            it.body
          )
        + linebreak()
        // + v(3em)
      )
    }
    else  {
      // any other I.
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
          )
        )
      )
    }

    v(13em)
  }

  // ===========================================
  // ===========================================

  set par(justify: true)


  show raw.where(block: true): it => pad(left: 4em, it)




  body
}

// #let linkb = (..it) => underline(text(fill: blue, link(..it)))
