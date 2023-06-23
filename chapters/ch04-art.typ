#import "../functions.typ": heading_center, images, italic,linkb
#let finchapiter = text(size: 24pt, fill:rgb("#1E045B"),[■])

/*
 *
 * ARTICLE 04
 *
 */
= DETECTING LUNG CANCER NODULES.
== Introduction and Related Work

CT Scan ...
Automatic brain tumor segmentation directly from CT scan represent a challenging task involving a plethora disciplines covering pathology and radiology [38].

In fact, there are many issues associated with nodule pulmonary cancer, segmentation may be of any size, may have a variety of shapes, may appear at any location, and may appear in different image intensities[6].

Some tumors also deform other structures and appear together with edema that changes intensity properties of the nearby region [25].

For many human experts, manual segmentation is a difficult and time consuming task, this is the reason why there is an effort in the automated this process [46].

There are many possible applications of an automated method, it can be used for surgical planning, treatment planning, and vascular analysis.

(...other metodes...)
  Other methods are based on statistical pattern recognition techniques, for instance the approach designed by researchers in [30], validated against meningiomas and low-grade gliomas.

(... some introduction to wat i we do in next chapters ...)


The aim of this models is to classify CT scan image as benign or affected by lung cancer.

= Method.



== Discussion.
Neural Networks are exploited in the method proposed in [27] to classify brain CTs: they achieve an accuracy equal to 96.33 %.

A deep learning-based method is proposed in [36], where .... we segment the MRIs and then they extract a set of features using ... .

The deep neural network designed is composed by 7 hidden layers.

... convolutional neural networks composed by 7 hidden layers, obtaining an accuracy equal to 0.86 in brain cancer grade detection.


Preliminary experiments on high-grade cancer patients provided by the LUNA16 dataset confirm the effectiveness of the proposed approach in   nodules lung cancer segmentation.
