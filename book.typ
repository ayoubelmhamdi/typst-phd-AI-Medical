
#let execption_chapter=(
  "RÉSUMÉ.",
  "INTRODUCTION GÉNÉRALE.",
  "RÉFÉRENCES BIBLIOGRAPHIQUES.",
  "CONCLUSION",
  "CONCLUSION GÉNÉRALE."
)

#let execption_outline=(
  "REMERCIEMENTS",
  "TABLE DES MATIÈRES",
)

#let book( dict, body) = {
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
    pagebreak()
    // pagebreak(weak:true)
    // v(0.5em)
    if it.body.text in execption_outline {
      // like REMERCIEMENTS
      counter(heading).update(())
      // set heading(outlined: false) -- not work
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
        // + linebreak()
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

    v(3em)
  }

  // ===========================================
  //                 Outline
  // ===========================================
  show outline: it => locate(loc => {
      set text(weight: "bold", fill: rgb("#1e045b"))
      let depth=3
      let indent= false
      let elements = query(heading, after: loc)

      for el in elements {
        if el.outlined == false { continue }
        if depth != none and el.level > depth { continue }

        let maybe_number = if el.numbering != none {
          numbering(el.numbering, ..counter(heading).at(el.location()))
          " "
        }
        let line = {
          // if indent {
          //   h(1em * (el.level - 1 ))
          // }

          if el.level == 1 {
      // ++++++++++++++++++++++++++++++++++
            if el.body.text in execption_chapter {
            // like RÉFÉRENCES BIBLIOGRAPHIQUES.
              text(
                weight: "bold",
                size:14pt,
                fill: rgb("#1e045b"),
                el.body
              )
            }
            else  {
              // any other I.
              block(
                text(
                  weight: "bold",
                  size:16pt,
                  fill: rgb("#FF0000"),
                  [Chapitre ] +
                  maybe_number
                ) +
                text(
                  weight: "bold",
                  size:16pt,
                  fill: rgb("#1e045b"),
                  el.body
                ) +
                v(-1.5em)
              )
            }
      // ++++++++++++++++++++++++++++++++++
          } else if el.level == 3 {
            text(
              h(22pt) +
              str(counter(heading).at(el.location()).at(-1)) +
              // [--] + maybe_number +
              ". "
            )
            el.body

          } else {
            maybe_number
            el.body
          }

          box(width: 1fr)
          text(fill:black, str(counter(page).at(el.location()).first()))

          linebreak()
        }

        link(el.location(), line)
      }
    })
  // ===========================================
  // ===========================================
  show raw: it => {
    // set text(font: songti, 12pt)

   set align(left)
    set block(inset: 5pt, fill: luma(240))
    pad(0.5em, it)
    // it
  }

  //---------------
  show outline: set block(spacing: 1.25em)
  set par(justify: true)

  body
}
