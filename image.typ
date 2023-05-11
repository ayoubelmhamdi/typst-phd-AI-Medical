#let counter_image = counter(figure.where(kind: image))

#let end-to-end() = {
  counter_image.update(n => n - 1)
  figure(
    image("images/end-to-end.png", width: 10%),
    caption: [
      A step in the molecular testing
      pipeline of our lab.
    ],
  )
}


#let end-to-end2() = {
  figure(
    image("images/end-to-end.png", width: 10%),
    caption: [
      A step in the molecular testing
      pipeline of our lab.
    ],
  )
}
