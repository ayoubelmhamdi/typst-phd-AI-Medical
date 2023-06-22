#import "../functions.typ": heading_center, images, italic,linkb
#let finchapiter = text(size: 24pt, fill:rgb("#1E045B"),[■])

/*
 *
 * ARTICLE 04
 *
 */
= DETECTING LUNG CANCER NODULES.
== Introduction and Related Work

Magnetic resonance images (MRI) represent a non-invasive technology for the representation of human tissue but also for also three-dimensional visualization of human body.

MRI is currently considered to obtain human body images in several modalities for instance, T1 and T2-weighted [26].

With this instrument is possible to better diagnose the different diseases such as cancers.

Clearly, MRI exhibits the capability to provide the brain functional activity [3].

Image segmentation is nowadays one of the most important tasks in medical image analysis and is often the first and the most critical step in many clinical applications [24].

In brain analysis, image segmentation is commonly used for measuring and visualizing the structures of the brain, for analyzing brain changes, for delineating pathological regions, and for surgical planning and image-guided interventions [37, 5].

Automatic brain tumor segmentation directly from MRI represent a challenging task involving a plethora disciplines covering pathology and radiology [38].

In fact, there are many issues associated with brain tumor, segmentation Brain tumors may be of any size, may have a variety of shapes, may appear at any location, and may appear in different image intensities[6].

Some tumors also deform other structures and appear together with edema that changes intensity properties of the nearby region [25].

For many human experts, manual segmentation is a difficult and time consuming task, this is the reason why there is an effort in the automated brain tumor segmentation method [46].

There are many possible applications of an automated method, it can be used for surgical planning, treatment planning, and vascular analysis.

It has been shown that blood vessels in the brain exhibit certain characteristics within pathological regions [7].

The challenges associated with automatic brain tumor segmentation have given rise to many different approaches.

For instance, automated segmentation approaches exploiting artificial intelligence techniques were proposed in [10, 18].

These methods do not rely on intensity enhancements provided by the use of contrast agents.

Moreover, these approaches require a training phase prior to segment a set of MRIs.

Other methods are based on statistical pattern recognition techniques, for instance the approach designed by researchers in [30], validated against meningiomas and low-grade gliomas.

Authors in [21] proposed a method detecting deviations from normal brains using a multilayer Markov random field framework.

The information layers include voxel intensities, structural coherence, spatial locations, and user input.

Moreover, authors in [11] designed high-dimensional warping to study deformation of brain tissue due to tumor growth.

Moreover, there is also research interest in the adoption of deep and machine learning fro brain cancer detection, for instance a machine learning model is considered in [48] to discriminate between low and high grade brain cancer MRIs.

Authors exploit the Support Vector Machine algorithm for the model generation.

Researchers in [16] design a framework to detect malignant brain cancer MRIs and benign one.

They exploit features based on discrete wavelet transform.

Once gathered the features, they apply the principal component analysis to reduce the dimensionality of the feature vector, and then they feed a forward back-propagation neural network for MRI classification.

Authors in [28] consider a multi-layer feedforward neural network with automated Bayesian regularization to classify brain tumour MRIs and non brain tumour MRIs.

Their method is evaluated using a data-set of nine pediatric patients.

Features based on discrete wavelet transformations are considered in [15] to build two classifiers: the first one based on feed forward backpropagation artificial neural network, while the second one based on knearest neighbor.

The aim of the models is to classify MRIs as benign or brain cancer affected.

Authors in [23] propose a comparison between several machine learning classifiers with the aim to choose the best one to discriminate between benign and malignant brain cancer MRIs.

They take into account Support Vector Machine, Neural Network, Naive Bayes and k-nearest neighbors classification algorithms.

From their results it emerges that the Support Vector Machine is the best model to detect whether an MRI is related to a brain cancer.

Researchers in [40] consider 60 features: 22 belonging to the shape category, 5 from the intensity and 33 from texture one.

After selected the best features exploiting a principal component analysis algorithm, the model built with the Support Vector Machine obtains an accuracy equal to 0.98 in malignant brain cancer MRI detection.

A probabilistic neural network is proposed by authors in [20] considering 36 textural features.

The aim of the authors is to respectively distinguish metastatic from primary tumors and gliomas from meningiomas.

Authors in [42] focused on the detection on brain cancers to distinguish the MRIs under analysis in I, II, III and IV grade.

Their approach is based on a convolutional neural network, in detail a VGG-19 CNN architecture is considered for brain tumor grades classification, by reaching an accuracy equal to 0.90 .

Genetic algorithm and Support Vector Machine are considered in [31] in combination with 44 discrete wavelet based features.

From the principal component analysis emerges that the best features are the following: mean of contrast, mean of homogeneity, mean of sum average, mean of sum variance and range of autocorrelation.

Meningioma brain tumor classification is investigated in [13] by considering as features obtain two matrices, in which one contains the whole cell's boundary, and the other contains the boundary of some cells.

These features are the input for a Support Vector Machine based model.

Researchers in [39] consider first and second order texture feature extraction for benign and malign brain cancer detection by building a Support Vector Machine model.

Authors in [12] exploit machine learning techniques to detect high grade and low grade brain cancers.

They obtain a prediction accuracy equal to 0.92 evaluating MRIs belonging to 50 patients.

Badran et al. [2] consider the Neural Network algorithm to label an MRI into benign or malignant tumor.

The canny edge detection algorithm used produces the inaccuracy of $15-16 \%$.

Neural Networks are exploited in the method proposed in [27] to classify brain MRIs: they achieve an accuracy equal to $96.33 \%$.

A deep learning-based method is proposed in [36], where authors consider the Fuzzy C-means to segment the MRIs and then they extract a set of features using discrete wavelet transform.

The deep neural network designed is composed by 7 hidden layers.

They obtain a precision and a recall equal to 0.97 in classifying normal brain MRIs and malignant ones.

Researchers in [1] discussed a method to detect brain cancer grades exploiting convolutional neural networks composed by 7 hidden layers, obtaining an accuracy equal to 0.86 in brain cancer grade detection.

Zia and colleagues investigate the same problem in [50] by using discrete wavelet transform for feature extraction, principal component analysis for feature selection and support vector machine for the classification task.

In this paper a method for brain segmentation is proposed.

Our method relies on brain magnetic resonance images and it considers a variation of the U-net deep learning network largely applied from biomedical image segmentation $[17,14,32,45]$.

Preliminary experiments on high grade cancer patients provided by the BraTS 2018 data-set confirm the effectiveness of the proposed approach in brain cancer segmentation.

The paper proceeds as follows: next section describes the proposed method, Section 3 presents the experimental evaluation and, finally, conclusion and future research lines are drawn in the last section.
