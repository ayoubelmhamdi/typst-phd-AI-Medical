#let counter_image = counter(figure.where(kind: image))

#let images = (
  "path":"images/end-to-end.png",
  caption: [the caption]
)

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


#let cImage(path) = {
  figure(
    image(path, width: 10%),
    caption: images.get(path),
  )
}
