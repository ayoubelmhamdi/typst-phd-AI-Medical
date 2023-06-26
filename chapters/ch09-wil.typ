#import "../functions.typ": heading_center, images, italic,linkb

#let finchapiter = text(size: 24pt, fill:rgb("#1E045B"),[■])
#let S1 = "S1"
#let S2 = "S2"
#let S3 = "S3"

= DETECTING LUNG CANCER NODULES.
== Introduction

Worldwide, lung cancer stands as the predominant cause of cancer-related deaths @Siegel2017Cancer2017. Timely discovery through screening chest scans can markedly increase the chances of survival @Nationallungscreening. Potentially, lung nodules - round or oval-shaped lumps detectable in chest scans - can indicate lung cancer @Gould2007EvaluationEdition. The efficiency of healthcare could benefit significantly from a computerized system capable of automatically identifying these nodules, conserving both time and resources for healthcare providers and patients.

Two-part processes generally make up nodule-detection algorithms @Setio2016PulmonaryNetworks:
- The initial stage seeks out a vast variety of possible nodules with high sensitivity; however, it generates numerous false positives.
- The subsequent stage mitigates these false positives using enhanced features and classifiers - a difficult task due to the variables encompassing nodule shapes, sizes, types, and their potential resemblance to other chest components like blood vessels or lymph nodes @Gould2007EvaluationEdition@Roth2016ImprovingAggregation.

In our research, we adopt the multi-scale gradual integration convolutional neural network (mgi-cnn) as a method to decrease false positives. This method presents three notable features:
1. It uses different-sized patches from the chest scan inputs; each size contributes varying information about the nodule and its surrounding area.
2. This method combines patches gradually across different network layers instead of simultaneous integration, leading to comprehensive feature learning from different scales.
3. Responsible for combining the patches, are two strategies: one ranges from small-to-large (zoom-in), and the other from large-to-small (zoom-out); providing varied perspective-information @Karpathy2014Large-ScaleNetworks@Shen2015@Shen2017Multi-cropClassification@Dou2016Multi-levelDetection.

We examined this method through the public LUNA16 dataset, comprised of chest scans from 888 patients reviewed by four medical experts @Setio2016PulmonaryNetworks.

Ultimately, the method displayed superior performance in curtailing false positives, chiefly at lower rates. This implies it can accurately identify more cancerous nodules and fewer non-cancerous ones @Lin2016FeatureDetection@Kamnitsas2017EfficientSegmentation.

== Related Work
=== Volumetric Contextual Information
In early attempts to automate lung cancer screenings, researchers relied on algorithms to extract unique characteristics of lung nodules. Emphasis was placed on the nodules' volumetric data and proximal areas, but these methods often struggled to differentiate the array of nodule variations correctly, requiring customization for each distinct nodules type@Jacobs2014AutomaticImages@Okumura1998AutomaticFilter@Li2003SelectiveScans. Researchers have, however, gradually refined these techniques, thanks greatly to advancements in deep-neural networks. These recent innovations, especially convolutional neural network (CNN) based methods, have shown promise in improving nodule classification@Roth2016ImprovingAggregation@Setio2016PulmonaryNetworks@Ding2017AccurateNetworks.

=== Multi-scale Contextual Information

A significant shift in the lung nodule detection paradigm has been the incorporation of multi-scale contextual information, particularly with the Luna16 dataset. This approach capitalizes on deep learning methodologies to evaluate a vast array of morphological and structural features across diverse scales@Shen2015@Dou2016Multi-levelDetection. Several techniques have proven useful, including:

- *The Multi-scale CNN (MCNN)* approach which leverages feature extraction from images across different scales to inform classifier training for nodule differentiation@Shen2015.
- *The Multi-Crop CNN* technique that applies a combination of cropping and pooling approaches to extract noteworthy data from varying regions of convolutional feature map, fine-tuning detection accuracy@Shen2017Multi-cropClassification.

Researchers have also suggested several promising strategies for lung anomaly detection, such as the use of 3D patches for enhanced accuracy with volumetric data and reduced false positives@Setio2016PulmonaryNetworks@Roth2016ImprovingAggregation. Gradual feature extraction, a sequential method involving merging context information from various scales, offers an alternative to the conventional practice of radical integration@Shen2015@Shen2017Multi-cropClassification.

The holistic combination of these approaches has resulted in models that are more reliable and robust for lung nodule detection. The regions surrounding the potential lung nodules have been carefully examined and compared with other organs or tissues to enhance nodule differentiation@Shen2017Multi-cropClassification. Future improvements could include incorporating contextual data from adjacent areas to the nodules, thereby potentially enhancing the models' performance and accuracy significantly@Dou2016Multi-levelDetection@Shen2017Multi-cropClassification.

== Introduction to the Method

The Multi-Scale Gradual Integration Convolutional Neural Network, or MGI-CNN, applies to the identification of pulmonary nodules. It incorporates two principle components: Gradual Feature Extraction (GFE) and Multi-Stream Feature Integration (MSFI) @Dou2016Multi-levelDetection@Nair2010RectifiedMachines.

=== Process of Gradual Feature Extraction

With GFE, the network merges contextual details from patches at varying scales step by step. It operates in two scenarios: Zoom-In and Zoom-Out @Zhang2014ScaleAnalysis@Shen2015@Shen2017Multi-cropClassification.

Under the Zoom-In scenario, patches at rising scales endure filtration using local convolutional kernels. The network concatenates feature maps obtained from each scale with the ensuing patch and inputs them into convolution layers. This process continues until the network integrates all contextual details from all scales. On the other hand, Zoom-Out scenario follows the same procedure but reverses the order of the patches.

This approach allows the network to amalgamate contextual features progressively, capturing both local and global information. As such, the network can target specific nodule areas or surrounding regions, thus effectively distinguishing nodules from other structures within the lung.

=== The Role of Multi-Stream Feature Integration

MSFI, the network's other component, uses a combination of 'zoom-in' and 'zoom-out' information streams that reflect different scales of nodule form and context @Nair2010RectifiedMachines. These varying and complementary features enhance the detection of nodules.

Part of MGI-CNN, MSFI combines features from different scales and perspectives. This application aims to enhance false positive reduction in lung nodule detection, employing the Luna16 dataset.

To illustrate, consider a 3D patch of a lung image featuring a nodule. The aim is detecting the nodule and minimizing false positives. To achieve this, MSFI merges features from different scales and perspectives.

The network uses two streams of input patches from the original patch: a 'zoom-in' stream, focusing on the nodule region, and a 'zoom-out' stream, covering a larger surrounding context. Separate scales, $S1$, $S2$, and $S3$, can be implemented for each stream.

Next, the CNN extracts features from these patches and generates a feature map that encapsulates the patch characteristics. The final output from MSFI is a combined feature map containing information from both streams.

Lastly, the network classifies the patch as a nodule or non-nodule using this combined feature map. It uses a classifier like a softmax layer, which assigns a probability to each class. The higher the probability, the more secure the prediction.

In this way, MSFI enhances lung nodule detection performance by harnessing features from different scales and perspectives. These features capture both the morphological and contextual properties of the nodule, consequently reducing false positives.

== Experimental Procedure and Outcomes
=== The Luna16 Dataset

In the exploration of Deep-Learning for lung nodule detection, the LUNA16 challenge datasets became a crucial factor. This data, which includes 888 patients with lung nodules reviewed by four expert radiologists, formed the groundwork for our evaluation@Setio2017validation. We omitted patients with a slice thickness surpassing 2.5mm. When three radiologists agreed on a nodule, we classified it as Ground Truth (GT). This process resulted in a total of 1186 GT-confirmed nodules.

Within the LUNA16 dataset, for the task of reducing False Positives (FPs), we received coordinates of the potential nodule, patient IDs, and respective labels.

To process the information from the CT scans, we employed the extraction of 3D patches @Dou2016Multi-levelDetection. This involved three scale types: 40x40x26, 30x30x10, and 20x20x6, which ensured comprehensive nodule coverage. Later resizing to 20x20x6 was done by nearest-neighbor interpolation, and normalization between the range of [-1000, 400] HU @Hounsfield1980ComputedImaging.

Training the network was facilitated by Xavier's initialization@glorot2010understanding and a learning rate of 0.003, encompassing 40 epochs. ReLU activation and a dropout rate of 0.5 were selected for fully-connected layers, and the use of stochastic gradient descent allowed for a batch size of 128.

We measured the DNN's performance on the test data using the Competitive Performance Metric (CPM) @Niemeijer2011OnSystems.

==== The Calculation of CPM.

Illustratively, let's use an example. Assume a dataset of 100 CT scans yielding the following model results:

- Total lung nodules: 200
- True positives (TP): 150
- FPs: 800
- False negatives (FN): 50

FPPs calculated as FP divided by the total number of scans, in this case giving us 8 FPs per scan level, which meets our target. We then compute sensitivity by the formula TP / (TP + FN), yielding 75%. This implies the model accurately identifies 75% of lung nodules, permitting 8 FPs per scan.

==== Ratio of Nodules to Non-nodules.

The data suggest a nodule-to-non-nodule ratio of approximately 1:6. Practically, this means for each nodule in the dataset, there are approximately six non-nodule samples. Importantly, balancing the representation of nodules versus non-nodules aids the machine learning model in learning from a diverse dataset.

We achieved this 1:6 ratio through augmentation. Originally, at a 1:5 ratio, we created new nodule samples by shifting and rotating them along various axes. This provided a balanced dataset, improving model performance in detecting nodules.

=== CPM Result

Evaluation of the model's performance used the CPM score as an average sensitivity across seven FP/scan levels (namely 0.125, 0.25, 0.5, 1, 2, 4, and 8) @Niemeijer2011OnSystems. Employing a 5-fold cross-validation, we achieved balance through the augmentation of nodule samples.

=== Evaluating the Model

To determine the model's effectiveness, we compared it with existing state-of-the-art methods @Setio2016PulmonaryNetworks@Dou2016Multi-levelDetection. Our method surpassed others, boasting superior CPM scores across seven different FP/scan values.

=== The Benefit of the Chosen Techniques

Examining the benefit of our unique method, we experimented with various multi-scale CNNs. Our method clearly outshone others, culminating in the best CPM and FP reduction average. This underlines the efficacy of the GFE and MSFI strategies we incorporated into our method.

== Discussions

Utilizing deep learning techniques, namely the LUNA16 dataset, for lung nodule detection greatly contributes to early diagnosis of lung cancer. The MGI-CNN structure, specifically tailored for this purpose, boasts two major strengths:

- It enables the extraction of morphological and contextual features at varying scales from the input patches. Morphological and contextual information gets gradually incorporated through the zoom-in network, whereas the opposite occurs in the zoom-out network. Harnessing multi-scale information in these ways supplies complementary features, performance gets a boost as a result.
- The structure allows for the integration of more abstract features from the two streams in MSFI, hence maximizing the reduction of false positives (FP) by blending features at a more abstract level where the morphological and contextual information remains intact.

Three different methods: concatenation, element-wise summation, and 1x1 convolution, were sampled in an attempt to merge the feature maps of the two streams in MSFI @Lin2013network. Element-wise summation proved most effective in reducing FP, even though no significant variance in average CPM was noted among the three techniques.

The original 3D patches were modified to 20x20x6 to align with the network's receptive field size, risking potential information loss or distortion. However, the essential nodule information was preserved as the majority of the patch was occupied by the nodule. Thus, the resizing operation left the performance largely unaffected.

A thorough analysis was conducted on the 232 FPs left unattended by the MGI-CNN, categorizing them into three distinct groups formed based on their nodule probabilities: Low Confidence (p ranging from 0.5 to < 0.7); Moderate Confidence (p ranging from 0.7 to < 0.9); and High Confidence (p > 0.9). The majority of the FPs were essentially components of large tissues or organs that the network failed to differentiate from nodules.

The Moderate Confidence group's FPs showcased low contrast, potentially rooted in the normalization process during preprocessing. This observation hints at the likelihood of performance enhancement if we utilized more patches of varying scales and employed different normalization methodologies.

Our approach aims at enhancing the FP reduction segment of a typical lung nodule detection system which consists of two major components: a candidate detection segment and an FP reduction segment. The network can function in tandem with any candidate detection technique as it operates independently. Merging the network with advanced candidate detection techniques will presumably yield improved results.

= CONCLUSION GÉNÉRALE.

MGI-CNN, our architecture, is particularly designed to minimize FPs in lung nodule detection via CT scans. This is accomplished through three major strategies: multi-scale inputs with distinct levels of contextual information, gradual integration of data from different input scales, and multi-stream feature integration through end-to-end learning.

Using these techniques, we can extract morphological features and gradually integrate contextual information in multi-scale patches, reducing the number of FPs and extracting morphological and contextual features from the nodule region.

Performance analysis of the MGI-CNN on the LUNA16 challenge datasets yielded a mighty impressive average CPM of 0.942, significantly outperforming state-of-the-art techniques. Our methodology demonstrated exceptional effectiveness, particularly in conditions of low FP/scan.

By undertaking minor modifications such as replacing fully-connected layers with $1 times 1$ convolution layers, our network could directly detect nodules from the CT scans, pushing the boundaries of cancer detection.

Moving forward, our research aims at mastering subtype nodule classification, such as solid, non-solid, part-solid, perifissural, calcified, and spiculated nodules. Diverse treatments are required for different nodule types, making their accurate detection even more pertinent for successful treatment.

