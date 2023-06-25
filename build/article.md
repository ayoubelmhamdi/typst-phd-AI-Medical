# Multi-Scale Gradual Integration CNN for False Positive Reduction in Pulmonary Nodule Detection

# abstract
Lung cancer is a global and dangerous disease, and its early detection is
crucial to reducing the risks of mortality. In this regard, it has been of
great interest in developing a computer-aided system for pulmonary nodules
detection as early as possible on thoracic CT scans.  In general, a nodule
detection system involves two steps: (i) candidate nodule detection at a high
sensitivity, which captures many false positives and (ii) false positive
reduction from candidates.  However, due to the high variation of nodule
morphological characteristics and the possibility of mistaking them for
neighboring organs, candidate nodule detection remains a challenge. In this
study, we propose a novel Multi-scale Gradual Integration Convolutional Neural
Network (MGI-CNN), designed with three main strategies: (1) to use multi-scale
inputs with different levels of contextual information, (2) to use abstract
information inherent in different input scales with gradual integration, and
(3) to learn multi-stream feature integration in an end-to-end manner. To
verify the efficacy of the proposed network, we conducted exhaustive
experiments on the LUNA16 challenge datasets by comparing the performance of
the proposed method with state-of-the-art methods in the literature. On two
candidate subsets of the LUNA16 dataset, , V1 and V2, our method achieved an
average CPM of 0.908 (V1) and 0.942 (V2), outperforming comparable methods by a
large margin.



# Introduction

Lung cancer is reported as the leading cause of death worldwide . However, when
detected at an early stage through thoracic screening with low-dose CT images
and treated properly, the survival rate can be increased by 20% . Clinically,
pulmonary nodules are characterized as having round shape with a diameter of
$3mm\sim30mm$ in thoracic CT scans . With this pathological knowledge, there
have been efforts of applying machine-learning techniques for early and
automatic detection of cancerous lesions, , nodules. To our knowledge, a
computerized lung cancer screening system consists of two-steps: candidate
nodule detection and False Positives (FPs) reduction. In the candidate nodule
detection step, the system uses high sensitivity without concern for
specificity to extract as many candidates as possible. Roughly, more than 99%
of the candidates are non-nodules, , FPs , which should be identified and
reduced in the second step correctly.

Pathologically, there are many types of nodules (, solids, non-solids,
part-solids, calcified, . ) and their morphological characteristics such as
size, shape, and strength are highly variable. In addition, there are many
other structure in the thorax (, blood vessels, airways, lymph nodes) with
morphological features similar to nodules


shows an example of a nodule and a non-nodule.  In these regards, it is very
challenging to reduce FPs or to distinguish nodules from non-nodules, leading
many researchers to devote their efforts on the step of false positive
reduction .



In earlier work, researchers had mostly focused on extracting discriminative
morphological features with the help of pathological knowledge about nodule
types and applied relatively simple linear classifiers such as logistic
regression or support vector machine
.
Recently, with the surge of popularity and success in Deep Neural Networks
(DNNs), which can learn hierarchical feature representations and class
discrimination in a single framework, a myriad of DNNs has been proposed for
medical image analysis .  Of the various deep models, Convolutional Neural
Networks (CNNs) have been applied most successfully for pulmonary nodule
detection and classification in CT images .  Moreover, in order to attain the
network performance of computer vision applications, there were trials to
identify nodules with a deep model fine-tuned with pulmonary nodule data in the
way of transfer learning .

From previous studies of nodule detection or classification in CT scans, we
have two notable findings. The first is that it is helpful to exploit
volume-level information, rather than 2D slice-level information .  For
example, Roth   proposed a 2.5D CNN by taking three orthogonal 2D patches as
input for volume-level feature representation. Setio   proposed a multi-view
CNN, which extracts hierarchical features from nine 2D slices with different
angles of view, and groups the high-level features for classification. However,
their method achieved limited performance in low-FP scans. Ding   proposed a 3D
CNN with a 3D volumetric patch as input, and presented promising results in FP
reduction.

The second is that performance can be enhanced by using multi-scale inputs with
different levels of contextual information .  Shen   proposed a multi-scale CNN
and successfully applied nodule classification by combining contextual
information at different image scales with the abstract-level feature
representations. Dou   also designed a 3D CNN to encode multi-level contextual
information to tackle the challenges of large variation in pulmonary nodules.
The performance of pulmonary nodule classification using the 3D CNN is
generally better than that of the 2D CNN . However, the 3D CNN is more
difficult to train than the 2D CNN due to the large number of network
parameters.  Medical image data is relatively limited, so a 3D CNN may easily
become over-fitted. It is also noteworthy that the multi-scale methods have
proved their efficacy in computer vision tasks .

Inspired by the above-mentioned findings, in this study we propose a novel
[Multi-scale Gradual Integration CNN (MGI-CNN) for FP reduction in pulmonary
nodule detection. In designing our network, we apply three main strategies.
Strategy 1: We use 3D multi-scale inputs, each containing different levels of
contextual information. Strategy 2: We design a network for Gradual Feature
Extraction (GFE) from multi-scale inputs at different layers, instead of
radical integration at the same layer .  Strategy 3: For better use of
complementary information, we consider Multi-Stream Feature Integration (MSFI)
to integrate abstract-level feature representations. Our main contributions can
be summarized as follows:

1.  We propose a novel CNN architecture that learns feature
    representations of multi-scale inputs with a gradual feature
    extraction strategy.

2.  With multi-stream feature representations and abstract-level feature
    integration, our network reduces many false positives.

3.  Our method outperformed state-of-the-art methods in the literature
    by a large margin on the LUNA16 challenge datasets.

While the proposed network architecture extension is straightforward, to our
best knowledge, this is the first work of designing a network architecture that
integrates 3D contextual information of multi-scale patches in a gradual and
multi-stream manner. Concretely, our work empirically proved the validity of
integrating multi-scale contextual information in a gradual manner, which can
be comparable to many existing work that mostly considered radical integration
of such information. Besides, our method also presents the effectiveness of
learning feature representations from different orders of multi-scale 3D
patches and combining the extracted features from different streams to further
enhance the performance.

# Related Work

## Volumetric Contextual Information

Automatic lung cancer screening systems classify nodules using specific
algorithms to extract nodule morphological characteristics. Okumura , 
distinguished solid nodules by using a Quoit filter that could detect only
isolated nodules. In the case of isolated nodules, the graph of the pixel
values becomes 'sharp,' and the nodule is detected when the annular filter
passes through the graph.  However, filters that use only one characteristic of
nodules have difficulty in distinguishing diverse nodule types. Li   proposed
point, line, and surface shape filters for finding nodule, blood vessel, and
airway in a thoracic CT. This is a detection method that considers various
types of nodules, effectively reducing the FP response of the automatic lung
cancer screening system.  However, hand-crafted features still do not detect
complex types of nodules (, part-solid or calcified nodules). Hence, to detect
the more elusive types of nodule, researchers attempted to use volumetric
information about the nodule and its surrounding area. Jacobs   extracted
volumetric information from various types of bounding boxes that defined the
region around a nodule to classify part-solid nodules. That volumetric
information includes 107 phenotype features and 21 context features of the
nodule and various nodule area with diverse sizes of a bounding box.  For the
classification, the GentleBoost classifier learned a total of 128 features and
obtained 80% of sensitivity at 1.0 FP/scan. However, the method was inefficient
in distinguishing the various types of nodule because it must be reconfigured
to filter each nodule type.

Recently, DNNs have been successfully used to substitute the conventional
pattern-recognition approaches that first extract features and then train a
classifier separately, thanks to their ability of discovering data-driven
feature representations and training a classifier in a unified framework. Among
various DNNs, CNN-based methods reported promising performance in classifying
nodules correctly. Roth   proposed 2.5D CNN that used three anatomical planes
(sagittal, coronal, and axial) to extract 3D nodule area volumetric
information. Their 2.5D CNN also classified organs similar to nodules, such as
lymph nodes. This study inspired some researchers in the field of pulmonary
nodule detection. Setio   proposed a multi-view CNN that extracted volumetric
information with an increased number of input patches.  Furthermore, to better
consider contextual information, they used groupings of high-level features
from each 2D CNN in a 9-view (three times more than 2.5D CNN's anatomical
plane) by achieving promising performance, compared with the methods using
hand-crafted features.  However, this effort could not fully utilize all the 3D
volumetric information that could be useful to further enhance the performance.
Ding   tried to build a unified framework by applying a deep CNN for both
candidate nodule detection and nodule identification. Specifically, they
designed a deconvolutional CNN structure for candidate detection on axial
slices and a three-dimensional deep CNN for the subsequent FP reduction. In the
FP reduction step, they used a dropout method by achieving a sensitivity of
0.913 in average FP/scan on the LUNA16 dataset. Although they claimed to use 3D
volumetric information, they did not consider the information between the small
patches that were extracted in a large patch.

## Multi-scale Contextual Information

From an information quantity perspective, it may be reasonable to use
morphological and structural features in different scales and thus effectively
integrating multi-scale contextual information. Shen   proposed Multi-scale CNN
(MCNN) as a method for extraction of high-level features from a single network
by converting images of various scales to the same size. The high-level
features are jointly used to train a classifier, such as support vector machine
or random forest, for nodule classification. Dou   used three different
architectures of 3D CNN, each one of which was trained with the respective
receptive field of an input patch empirically optimized for the LUNA16
challenge dataset. To make a final decision, they integrated label prediction
values from patches of three different scales by a weighted sum at the top
layers. However, the weights for each scale were determined manually, rather
than learning from training samples.

Multi-crop Convolutional Neural Network (MC-CNN) to automatically extract
nodule salient information by employing a novel multi-crop pooling strategy
which crops different regions from convolutional feature maps and then applies
max-pooling different times.

Shen   proposed a Multi-Crop CNN to automatically extract nodule salient
information by employing a novel multi-crop pooling strategy. In particular,
they cropped different regions from convolutional feature maps and then applied
a max-pooling operation different times. To give more attention on the center
of the patches, they cropped out the neighboring or surrounding information
during multi-crop pooling, which could be more informative to differentiate
nodules from non-nodules, , other organs.

In this paper, unlike the methods of , we exploit 3D patches to best utilize
the volumetric information and thus enhancing the performance in FP reduction.
Further, to utilize contextual information from different scales, we exploit a
multi-scale approach similar to .  However, instead of radical integration of
multi-scale contextual information at a certain layer , we propose to gradually
integrate such information in a hierarchical fashion. It is also noteworthy
that we still consider the surrounding regions of a candidate nodule to
differentiate from other organs, which can be comparable to.


# Multi-scale Gradual Integration Convolutional Neural Network (MGI-CNN) {#sec:proposed_method}

In this section, we describe our novel method of Multi-scale Gradual
Integration Convolutional Neural Network (MGI-CNN)  for pulmonary nodule
identification, which consists of two main components: Gradual Feature
Extraction (GFE) and Multi-Stream Feature Integration (MSFI). [For each
candidate nodule, we extract 3D patches at three different scales
$40\times40\times26$, $30\times30\times10$, and $20\times20\times6$ by
following Dou 's work . We then resize three patches to $20\times20\times6$, ,
denoted as $S1$, $S2$, and $S3$, respectively, as input to the proposed network
Note that patches of $S1$, $S2$, and $S3$ have the same center coordinates but
pixels in the patches are different in resolution.

## Gradual Feature Extraction

Inspired by the human visual system, which retrieves meaningful contextual
information from a scene by changing the field of view, , by considering
contextual information at multiple scales , we first propose a scale-ordered
GFE network presented in Fig. [4]. In integrating morphological or structural
features from patches at different scales, the existing methods combined
features from multiple patches all at once. Unlike their methods, in this
paper, we extract features by gradually integrating contextual information from
different scales in a hierarchical manner. For gradual feature representation
from multi-scale patches, , $S1$, $S2$, and $S3$, there are two possible
scenarios, , $S1-S2-S3$ ('*zoom-in*') or $S3-S2-S1$ ('*zoom-out*').

For the zoom-in scenario of $S1-S2-S3$, a patch at one scale $S1$ is first
filtered by the corresponding local convolutional kernels and the resulting
feature maps $F1$ are concatenated ($\Vert$) with the patch at the next scale
$S2$, , $F1 \Vert S2$. In our convolution layer, $F1$ is the result of two
repeated computations of a spatial convolution and a non-linear transformation
by a Rectifier Linear Unit (ReLU) . Our convolution kernel uses zero padding to
keep the size of the output feature maps equal to the size of an input patch
and thus valid to concatenate the resulting feature maps and another input
patch $S2$ in different scale. The $F1 \Vert S2$ tensor is then convolved with
kernels of the following convolution layers, producing feature maps $F12$,
which now represent the integrated contextual information from $S1$ and $S2$.
The feature maps $F12$ are then concatenated with the patch at the next scale
$S3$ and the tensor of $F12 \Vert S3$ is processed by the related kernels,
resulting in feature maps $F123$. The feature maps $F123$ represent the final
integration of various types of contextual information in patches $S1$, $S2$,
and $S3$. The number of feature maps in our network increases as additional
inputs are connected so that the additional information can be extracted from
the information of the preceding inputs and the contextual information of the
sequential inputs. For the zoom-out scenario of $S3-S2-S1$, the same operations
are performed but with input patches in the opposite order.

In the zoom-in scenario, the network is provided with patches at an increasing
scale. So, the field of view in a zoom-in network is gradually reduced, meaning
that the network gradually focuses on a nodule region. Meanwhile, the zoom-out
network has a gradually enlarging field of view, and thus the network finds
morphological features combined with the neighboring contextual information by
gradually focusing on the surrounding region. In our network architecture, the
feature maps extracted from the previous scale are concatenated to the patch of
the next scale with zero padding, and then fed into the following convolution
layer. By means of our GFE method, our network sequentially integrates
contextual features according to the order of the scales. It is noteworthy that
the abstract feature representations from two different scenarios, , zoom-in
and zoom-out, carry different forms of information.

## Multi-Stream Feature Integration (MSFI)

Rather than considering a single stream of information flow, either $S1-S2-S3$
or $S3-S2-S1$, it will be useful to consider multiple streams jointly and to
learn features accordingly. With two possible scenarios of 'zoom-in' and
'zoom-out', we define the information flow of $S1-S2-S3$ as '*zoom-in stream*'
and the information flow of $S3-S2-S1$ as '*zoom-out stream*'.

As the zoom-in and zoom-out streams focus on different scales of morphological
and contextual information around the candidate nodule in a different order,
the learned feature representations from different streams can be complementary
to each other for FP reduction. Hence, it is desirable to combine such
complementary features in a single network and to optimize the feature
integration from the two streams in an end-to-end manner. To this end, we
design our network to integrate contextual information from the two streams as
presented in Fig.  and call it as MSFI. The proposed MSFI is then followed by
additional convolutional layers and fully-connected layers to fully define our
MGI-CNN, as shown in Fig.


# Experimental Settings and Results

## Experimental Settings

We performed the experiments on the LUng Nodule Analysis 2016 (LUNA16)
challenge  datasets by excluding patients whose slice thickness exceeded 2.5
$mm$. LUNA16 includes samples from 888 patients in the LIDC-IDRI open database
, which contains annotations of the Ground Truth (GT) collected from the
two-step annotation process by four experienced radiologists. After each
radiologist annotated all the candidates on the CT scans, each candidate nodule
with the agreement of at least three radiologists was approved as GT. There are
1,186 GT nodules in total. For the FP reduction challenge, LUNA16 provides the
center coordinates of candidate nodules, the respective patient's ID, and the
label information, obtained by commercially available systems. Specifically,
there are two versions (V1 and V2) of datasets: The V1 dataset provides 551,065
candidate nodules obtained with , of which 1,351 and 549,714 candidates are,
respectively, labeled as nodules and non-nodules. In comparison with the four
radiologists' decisions, 1,120 nodules out of the 1,351 are matched with GTs;
The V2 dataset includes 754,975 candidate nodules detected with five different
nodule detection systems .  Among the 1,557 nodule-labeled candidates, 1,166
are matched with the GTs, , four radiologists' decisions. Table summarizes the
statistics of the candidate nodules of two datasets for FP reduction in LUNA16.


By using the 3D center coordinates of the candidates provided in the dataset,
we extracted a set of 3D patches from thoracic CT scans at scales of
$40\times40\times26$, $30\times30\times10$, and $20\times20\times6$, which
covered, respectively, 99%, 85%, and 58% of the nodules in the dataset, by
following Dou 's work . The extracted 3D patches were then resized to
$20\times20\times6$ by nearest-neighbor interpolation. For faster convergence,
we applied a min-max normalization to patches in the range of [-1000, 400]
Hounsfield units (HU) .

Regarding the network training, we initialized network parameters with Xavier's
method . We also used a learning rate of 0.003 by decreasing with a weight
decay of 2.5% in every epoch and the number of epochs of 40. For non-linear
transformation in convolution and fully-connected layers, we used a ReLU
function. To make our network robust, we also applied a dropout technique to
fully connected layers with a rate of 0.5. For optimization, we used a
stochastic gradient descent with a mini-batch size of 128 and a momentum rate
of 0.9.

For performance evaluation, we used a Competitive Performance Metric (CPM)
score, a criterion used in the FP reduction track of the LUNA16 challenge for
ranking competitors.  Concretely, a CPM is calculated with 95% confidence by
using bootstrapping  and averaging sensitivity at seven predefined FP/scan
indices, , 0.125, 0.25, 0.5, 1, 2, 4, and 8. For fair comparison with other
methods, the performance of our methods reported in this paper were obtained by
submitting the probabilities of being nodule for candidate nodules to the
website of the LUNA16 challenge. To better justify the validity of the proposed
method, we also counted the number nodules and non-nodules correctly classified
and thus to present the effect of reducing FPs.

We evaluated the proposed method with 5-fold cross-validation. To avoid a
potential bias problem due to the high imbalance in the number of samples
between nodules and non-nodules, we augmented the nodule samples by $90^\circ,
180^\circ$, and $270^\circ$ rotation on a transverse plane and 1-pixel shifting
along the x, y, and z axes. Consequently, the ratio between the number of
nodules to non-nodules was approximately $1:6$.  The detailed numbers of
nodules and non-nodules are presented in Table .

## Performance Comparison

To verify the validity of the proposed method, , MGI-CNN, we compared with the
existing methods

in the literature that achieved state-of-the-art performance on V1 and/or V2
datasets of the LUNA16 challenge. Concisely, Setio 's method uses 9-view 2D
patches, Ding 's method takes 3D patches as input, and Dou 's method uses
multi-level 3D patches. Sakamoto 's 2D CNN  eliminates the predicted
nonconformity in the training data by raising the threshold in every training
iteration. Table  summarizes the CPM scores over seven different FP/scan values
on the V2 and V1 datasets, respectively.

First, on the large-sized V2 dataset, the proposed MGI-CNN was superior to all
other competing methods by a large margin in the average CPM.

Notably, when comparing with Dou 's method , which also uses a 3D CNN with the
same multi-scale patches as ours, our method increased the average CPM by 0.034
($\sim$3% improvement). It is also noteworthy that while the sensitivity of our
method at 1, 2, 4, and 8 FP/scan was lower than , our method still achieved the
best performance at the 0.125, 0.25, and 0.5 FP/scan. That is, for a low FP
rate, which is the main goal of the challenge, our method outperformed those
methods.

Over the V1 dataset, our method obtained the highest CPMs under all conditions
of the FP/scan as presented in Table .  Again, when compared with Dou 's and
Setio's work, our method made promising achievements by increasing the average
CPM by 0.081 and by 0.070 . In comparison with Sakamoto 's method  that
reported the highest CPM among the competing methods, our MGI-CNN increased by
0.062 ($\sim$}7.3% improvement).




## Effects of the Proposed Strategies

To show the effects of our strategies in constructing a multi-scale CNN, , GFE
in Fig. and MSFI in Fig. we also conducted experiments with the following
Multi-scale CNNs (MCNNs):

-   MCNN with Radical integration of Input patches (MCNN-RI): taking
    multi-scale 3D patches concatenated at the input-level, ,
    $S1 \Vert S2 \Vert S3$, as presented in Fig.
    .

-   MCNN with radical integration of Low-level feature Representations
    (MCNN-LR): integrating multi-scale information with feature maps of
    the first convolution layer as presented in Fig.

-   MCNN with zoom-in gradual feature integration (MCNN-ZI): integrating
    multi-scale patches gradually in the order of $S1-S2-S3$, , the
    upper network pathway of the proposed network in Fig.
    .

-   MCNN with zoom-out gradual feature integration (MCNN-ZO):
    integrating multi-scale patches gradually in the order of
    $S3-S2-S1$, , the lower network pathway of the proposed network in
    Fig. .

To make these networks have similar capacity, we designed network architectures
to have a similar number of tunable parameters: MCNN-RI (9,463,320), MCNN-LR
(9,466,880), MCNN-ZI (9,464,320), MCNN-ZO (9,464,320), MGI-CNN (9,472,000),
where the number of tunable parameters are in parentheses. We conducted this
experiment on the V2 dataset only, because the V1 dataset is a subset of the V2
dataset and reported the results in Table.

First, regarding the strategy of gradual feature extraction, the methods of
MCNN-ZI and MCNN-ZO obtained 0.937 and 0.939 of the average CPM, respectively.
While the methods with radical integration of contextual information either in
the input layer (MCNN-RI) or in the first convolution layer (MCNN-LR) achieved
0.939 and 0.929 of the average CPM.  Thus, MCNN-ZI and MCNN-ZO showed slightly
higher average CPM scores than MCNN-RI and MCNN-LR. However, in terms of FPs
reduction, the power of the gradual feature extraction became notable. That is,
while MCNN-RI and MCNN-LR misidentified 383 and 309 non-nodules as nodules,
MCNN-ZI and MCNN-ZO failed to remove 279 and 267 non-nodule candidates.

Second, as for the effect of multi-stream feature integration, the proposed
MGI-CNN overwhelmed all the competing methods by achieving the average CPM of
0.942. Further, in FP reduction, MGI-CNN reported only 232 mistakes in
filtering out non-nodule candidates. In comparison with MCNN-ZI and MCNN-ZO,
the proposed MGI-CNN made 47 and 35 less mistakes, respectively, and thus
achieving the best performance in FPs reduction.

It is also worth mentioning that the networks of MCNN-RI, MCNN-LR, MCNN-ZI,
MCNN-ZO achieved better performance than the competing methods of

in average CPM. From this comparison, it is believed that the network
architectures with the number of tunable parameters of approximately 9.4M had
better power of learning feature representations than those of

for FP reduction in pulmonary nodule detection.


Furthermore, the complementary features from the two different streams of GFE
should be integrated properly without lowering the performance of FP reduction.
To fully utilize the morphological and contextual information while reducing
the chance of information loss, we integrate such information with the
abstract-level feature representations through MSFI. With an effective
integration method, it is possible to compensate for the loss of information
that may occur through the feed-forward propagation of the network, especially
the max-pooling layer. To combine the feature maps of two streams, we consider
three different methods: concatenation, element-wise summation, and $1\times1$
convolution (Table). In our experiments, there was no significant difference in
the CPM score between element-wise summation and $1\times1$ convolution, but
the element-wise summation method achieved the lowest number of FPs, which is
the ultimate goal of our work.


# Discussions

The major advantages of the proposed method can be summarized by two points.
First, as shown in Fig.  {reference-type="ref" reference="fig:FeatureMap"}, our
MGI-CNN could successfully discover morphological and contextual features at
different input scales. In Fig.  , we observe that the feature maps in the
zoom-in network (, each column in the figure) gradually integrate contextual
information in the nodule region. Each sample feature map was extracted from
the middle of the sagittal plane in the 3D feature map before concatenation
with the next scale input. A similar but reversed pattern in integrating the
contextual information can be observed in the zoom-out network (each column in
Fig.  . These different ways of integrating contextual information and
extracting features from multi-scale patches could provide complementary
information, and thus could enhance performance in the end. Second, our
proposed abstract feature integration is useful in terms of information
utilization. It is possible to maximize the FP reduction by integrating
features at the abstract-level.

With regard to complementary features integration at the abstract-level, we
considered three different strategies, , concatenation, element-wise summation,
$1\times1$ convolution , commonly used in the literature. The resulting
performances are presented in Table . Although there is no significant
difference among the four methods in average CPM, from a FP reduction
perspective, the element-wise summation reported 232 number of FPs, reducing by
31 (vs. concatenation), 103 (vs.  skip-connection), and 31 (vs. $1\times1$
convolution). In this regard, we used element-wise summation in our MGI-CNN.

The 3D patches fed into our network were resized to fit the input receptive
field size, , $20\times20\times6$. Such image resizing may cause information
loss or corruption in the original-sized patches.  However, as we can see in
Fig.  , the 3D patches of size $20\times20\times6$, in which the nodule still
occupies most of the patch, was not affected by the resizing operation. This
means that even if the surrounding region information is lost by resizing, the
information of the nodule itself could be preserved.


We visually inspected the misclassified candidate nodules. In particular, we
first clustered the 232 FPs by our MGI-CNN into three groups based on the their
probabilities as nodule: Low Confidence (LC; $0.5\leq p <0.7$), Moderate
Confidence (MC; $0.7\leq p<0.9$), and High Confidence (HC; $p>0.9$). The number
of FP patches for each group was 33 (LC), 47 (MC), and 152 (HC), respectively.
Fig.  presents the representative FP 3D patches for three groups. One
noticeable thing from the LC and HC groups is that the extracted 3D patches
mostly seem to be a subpart of a large tissue or organ, and thus our network
failed to find configural patterns necessary to differentiate from non-nodules.
For the MC group, patches show relatively low contrasts, which is possibly due
to our normalization during preprocessing (Section . These observations
motivate us to extend our network to accommodate an increased number of patches
with larger scales and patches normalized in different ways. This would be an
interesting direction to further improve the performance.

From a system's perspective, instead of developing a full pulmonary nodule
detection system, which usually consists of a candidate detection part and a FP
reduction part, this study mainly focused on improving the FP reduction
component. As the proposed approach is independent of candidate screening
methods, our network can be combined with any candidate detector. If the
proposed network is combined with more high-performance candidate detection
methods, we presume to obtain better results.

# Conclusion

In this paper, we proposed a novel multi-scale gradual integration CNN for FP
reduction in pulmonary nodule detection on thoracic CT scans. In our network
architecture, we exploited three major strategies: (1) use of multi-scale
inputs with different levels of contextual information, (2) gradual integration
of the information inherent in different input scales, and (3) multi-stream
feature integration by learning in an end-to-end manner. With the first two
strategies, we successfully extracted morphological features by gradually
integrating contextual information in multi-scale patches. Owing to the third
strategy, we could further reduce the number of FPs. In our experiments on the
LUNA16 challenge datasets, our network achieved the highest performance with an
average CPM of 0.908 on the V1 dataset and an average CPM of 0.942 on the V2
dataset, outperforming state-of-the-art methods by a large margin. In
particular, our method obtained promising performances in low FP/scan
conditions.

Our current work mostly focused on FP reduction given coordinates of many
candidate nodules. We believe that our network can be converted to accomplish
positive nodule detection on the low-dose CT scans directly with minor
modifications, such as replacing the fully-connected layers with $1\times1$
convolution layers. For clinical practice, it is also important to classify
nodules into various subtypes of solid, non-solid, part-solid, perifissural,
calcified, spiculated , for which different treatments can be used. Thus, it
will be our forthcoming research direction.
