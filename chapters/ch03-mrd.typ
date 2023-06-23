#import "../functions.typ": heading_center, images, italic,linkb

#let finchapiter = text(size: 24pt, fill:rgb("#1E045B"),[■])

/*
 *
 *  Methode Result Dissusion 03
 *
 */

= DETECTING LUNG CANCER NODULES.
// = MÉTHODES, RÉSULTATS ET DISCUSSION
== Introduction.


Radiotherapy is a common treatment for brain tumors [Khan 2014]. It uses ionizing radiation to kill or stop the division of cancer cells by damaging their DNA. External beam radiotherapy is the most common type, where the radiation comes from outside the patient's body.

Automatic segmentation is a particularly important application for radiotherapy planning. The goal of radiotherapy planning is to calculate optimal radiation doses, i.e. to deliver radiation that kills tumor cells while sparing healthy tissues.

Identifying malignant tumors is difficult even for professional specialists. It typically takes several hours per patient for an experienced clinician. This results in considerable cost and potential delay in therapy.

Automating this process will help to deal with difficult scenarios where problem-solving is challenging. Deep learning can automate the process, but it will be more demanding and require a structured approach to succeed.

Detecting lung cancer early is essential for increasing the patient's survival rate, but it's tough to do manually, especially on a large scale. The problem space of lung tumor detection is important because it is an active research area with promising results.

The objective of this report is to propose a method for lung cancer detection, based on the *LUNA dataset* #link("https://luna16.grand-challenge.org/Description")[luna16.grand-challenge.org]. This dataset contains CT scans of patients with lung nodules, which are small growths in the lungs that may indicate cancer. The dataset is part of a Grand Challenge, which is a competition among researchers to develop and test methods for nodule detection and classification. The dataset is open and publicly available.

Nodule segmentation poses many challenges, as nodules may vary in size, shape, location, and image intensity[6].

#images(
  filename:"images/frameworkv1.png",
  caption:[The framework of DeepLung. first employs 3D Faster R-CNN to
generate candidate nodules. Then extract deep features from the detected and cropped nodules. Lastly, detected nodule size, and raw pixels is employed for classification.],
  width: 100%
  // ref:
)
The aim of this model is to classify CT scan images as benign or malignant.

== Related Work


Nodule detection is a challenging task that requires identifying small and diverse nodules in large volumes of CT scans. Traditional methods rely on manually designed features or descriptors @lopez2015large that often fail to handle the nodule variability. To overcome this limitation, deep learning methods have been proposed that automatically learn features from data and outperform hand-crafted features. Some approaches use multi-view ConvNets @setio2016pulmonarymultiview or 3D ConvNets @dou2017automated to reduce false positives. Others use Faster R-CNN @ding2017accurate,liao2017evaluate to generate candidates and 3D ConvNets to refine them. We present a novel method that.

Nodule classification is another important task that predicts the nodule malignancy from their appearance and characteristics. Traditional methods segment the nodules @el20113d and design manual features @aerts2014decoding, such as contour, shape and texture @way2006computer. These features, however, may miss the subtle differences between benign and malignant nodules. Deep learning methods have improved nodule classification by using artificial neural networks @suzuki2005computer, multi-scale ConvNets @shen2015multi, deep transfer learning and multi-instance learning @zhu2017deep, and 3D ConvNets @yan2016classification.

== Method
=== Datasets

LUNA16 is a subset of LIDC-IDRI, the largest public dataset for pulmonary nodules @armato2011lung@setio2016pulmonary. Unlike LIDC-IDRI, LUNA16 only includes detection annotations and excludes CTs with slice thickness greater than 3mm, inconsistent slice spacing or missing slices. It also provides a patient-level 10-fold cross validation split of the data. LUNA16 contains **1,186 lung nodules** in **888 CT scans**. It does not include nodules smaller than 3mm.

We classify nodules based on different doctors' diagnoses. We remove nodules with an average score of 3 (uncertain malignancy) and label nodules with a score above 3 as positive (malignant) and below 3 as negative (benign). Since anonymous doctors annotated the CT slides, we cannot match their identities across scans. We call them 'simulated' doctors.

The LUNA dataset has two tracks: nodule detection and false positive reduction.

=== Data preprocessing

The first step is to load and process the raw data files into 3D arrays: CT scan data and annotation data from LUNA with nodule coordinates and malignancy flags. The dataset includes all lumps that resemble nodules, regardless of their nature. This ensures a representative range of nodule sizes in the training and validation data.

The second step is to convert the raw data into PyTorch *Tensors*. This reduces the data size from 32 million voxels to a relevant crop of the CT scan.

The third step is to segment the image for potential tumors. We use thresholding, a simple and common method that selects a pixel value (the threshold) to separate the foreground (the region of interest) from the background. For example, to segment the bone from a CT scan, we choose a threshold that matches the intensity of bone pixels and ignore the rest.

The fourth step is to group voxels into candidates. The candidate center data is in millimeters, not voxels. We convert our coordinates from $(X, Y, Z)$ in millimeters to $(I, R, C)$ in voxels. The patient coordinate system defines positive $X$ as patient left, positive $Y$ as patient behind, and positive $Z$ as patient head.

The fifth step is to classify the nodules with a classification model.

=== Data Augmentation

Data augmentation prevents overfitting by modifying individual samples with synthetic alterations. This creates a new dataset with more effective samples. We use five data augmentation techniques: mirroring, shifting, scaling, rotating and adding noise.

=== Model Architecture

We use convolutional and downsampling layers to reduce resolution. The project requires a GPU with at least *8 GB* of RAM or *220 GB* of free disk space for raw training data, cached data and trained models.

The model is based on convolutional neural networks (CNNs) for image recognition. It has three components: a tail for preprocessing, a backbone with convolutional blocks and a head for output. It takes a crop of a CT scan with a candidate nodule from the LUNA dataset as input and outputs a binary classification of benign or malignant nodules.

Radiologists annotated 888 CT scans in the LUNA dataset for nodule localization and malignancy classification. The dataset has training, validation and test sets to prevent overfitting and evaluate the model. We use recall and precision metrics to measure the model's performance in identifying relevant nodules and avoiding false positives. We graph the results for easy interpretation and analysis.


