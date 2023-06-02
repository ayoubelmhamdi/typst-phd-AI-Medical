#let counter_image = counter(figure.where(kind: image))

#let images(filename:"", caption:[], width:100%, ref:none) = {
  figure(
    image(filename, width: width),
    caption: caption,
  )
}

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

#let representation_data() = {
  figure(
    image("images/representation-data.svg", width: 100%),
    caption: [
      A step in the molecular testing
      pipeline of our lab.
    ],
  )
}
