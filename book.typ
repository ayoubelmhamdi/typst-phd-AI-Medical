// #let books(
//     title: "",
//     authors: (),
//     encaders: (),
//     body
//   ) = {[as]}
//
//

#import "cover.typ": cover

// #let books(
//     title: "",
//     authors: (),
//     encaders: (),
//     body
//   ) = {
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
  set heading(numbering: "I.1.1.")
  show heading: it => pad(bottom: 0.5em, it)
  set par(justify: true)
  show raw.where(block: true): it => pad(left: 4em, it)





  body
}

// #let linkb = (..it) => underline(text(fill: blue, link(..it)))
