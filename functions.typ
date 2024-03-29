#let heading_center(title) = {
  v(0.5em)
  align(
      center,
      text(
        fill: rgb("#1e045b"),
        weight: "bold",
        size:22pt,
        title
    )
  )
  v(3em)
}

#let linkb(the_link,text) = {
  show link: underline
  link(the_link)[#text]
}

#let counter_image = counter(figure.where(kind: image))

#let images(filename:"", caption:[], width:100%,  height: none, ref:none) = {
  height =  if height !=  none { height } else{ auto }
  figure(
    image(filename, width: width, height:height),
    caption: caption,
  )
}


#let italic(it) = [
    #set text(style: "italic")
    #it
]

#let dots = [
  #box(width: 1fr,repeat[.])
  #linebreak()
]
