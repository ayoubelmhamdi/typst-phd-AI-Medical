# Résume
lung cancer is a deadly disease that can be treated better if detected early. One way to detect lung cancer is to use a computer system that can find small lumps called nodules in chest scans. However, finding nodules is hard because they look different and can be confused with other things in the chest. In this study, we use a method that uses a special type of neural network to find nodules more accurately. This method uses three different sizes of patches from the chest scans and combines them gradually to learn more features. We also use two different ways of combining the patches to get more information. We test this method on a public dataset and show that it performs better in reducing false positives, which are nodules that are not cancerous.

# introduction
lung cancer is the most common cause of death from cancer in the world. However, if lung cancer is found early by screening chest scans, the chances of survival can be improved. One way to screen for lung cancer is to look for nodules in the lungs. Nodules are round or oval-shaped lumps that can be seen in chest scans. Some nodules are cancerous and some are not. A computer system that can help find nodules automatically can save time and resources for doctors and patients.

A computer system for finding nodules usually has two steps:
- first, it finds many possible nodules with high sensitivity, but also many false positives;
- second, it reduces the false positives by using more features and classifiers.
- the second step is challenging because nodules have different shapes, sizes, and types, and they can look like other things in the chest, such as blood vessels or lymph nodes.


In this rapport, we use a method for reducing false positives by using a special type of neural network called multi-scale gradual integration convolutional neural network (mgi-cnn). This method has three main features:
1. it uses three different sizes of patches from the chest scans as inputs. Each size has different information about the nodule and its surroundings.
2. it combines the patches gradually in different layers of the network, instead of all at once. This way, it can learn more features from different scales.
3. it uses two different ways of combining the patches: one from small to large (zoom-in) and one from large to small (zoom-out). This way, it can get more information from different perspectives.

We test this method on a public dataset called luna16, which has chest scans from 888 patients with annotations from four experts.
<!-- We compare our method with other methods that use neural networks, -->
This method performs better in reducing false positives, especially at low rates. This means that can find more nodules that are cancerous and less nodules that are not.


# Related Work
## Volumetric Contextual Information
Previous approaches for automatic lung cancer screening have focused on extracting nodule morphological characteristics using specific algorithms. Some methods have attempted to utilize volumetric information about the nodules and their surrounding areas to improve detection. For instance, researchers have extracted volumetric information from different types of bounding boxes defined around nodules to classify part-solid nodules. However, these methods have limitations in distinguishing diverse nodule types and require reconfiguration for each nodule type.

Recent advancements in deep neural networks, particularly CNN-based methods, have demonstrated promising results in classifying nodules correctly. These methods extract volumetric information using different input patches or planes and apply classifiers for nodule classification. However, they still do not fully exploit the 3D volumetric information and often require manual weight selection for each input scale.


## Multi-scale Contextual Information

The use of multi-scale contextual information in lung nodule detection. By using deep learning methodologies, specifically with the Luna16 dataset, varying scales of morphological and structural features are evaluated. This approach allows for the incorporation of multi-scale contextual data, a method found to enhance overall performance.

Several techniques aid in this task, for example:

- **Multi-scale CNN (MCNN)**: This technique is designed to extract high-level features from images at different scales. These features then assist in training classifiers for distinguishing nodules.

- **Multi-Crop CNN**: This method employs multiple cropping and pooling approaches. These enable the extraction of significant data from various regions of convolutional feature maps and can enhance detection accuracy due to this spatial relevance consideration.

The other strategies that could potentially improve the detection of lung abnormalities. These include the use of **3D patches** to harness volumetric data for better accuracy and mitigating false positives. Another innovative approach is **gradual feature extraction**. This step-by-step method involves sequentially merging context information from various scales and contradicts the conventional idea of radical integration. The goal behind these techniques is to create a more reliable and robust model for lung nodule detection.

Attention is also given to the regions surrounding potential lung nodules. By assessing these adjacent areas and comparing them with other organs or tissues, distinguishing the nodules becomes more manageable. This holistic approach combines multiple techniques and could potentially boost the accuracy and performance of lung nodule detection significantly.

# Method

In this section, we describe this method, the Multi-Scale Gradual Integration Convolutional Neural Network (MGI-CNN), for pulmonary nodule identification. The network consists of two main components: Gradual Feature Extraction (GFE) and Multi-Stream Feature Integration (MSFI).


## Gradual Feature Extraction
Inspired network gradually integrates contextual information from patches at different scales. We propose two scenarios: Zoom-In and Zoom-Out.

In the Zoom-In scenario, patches at increasing scales are filtered using local convolutional kernels. The resulting feature maps from each scale are concatenated with the patch at the next scale and processed using convolution layers. This process continues until the final integration of contextual information from all scales is achieved. Conversely, in the Zoom-Out scenario, the same operations are performed but with patches in the opposite order.

This method allows the network to progressively integrate contextual features according to the order of scales, capturing both local and global information. By employing this approach, this network can focus on specific nodule regions or surrounding regions, effectively distinguishing nodules from other structures.


## Multi-Stream Feature Integration (MSFI)

The combine of ‘zoom-in’ and ‘zoom-out’ information streams that capture different scales of nodule morphology and context. These streams have diverse and complementary features that can enhance the nodule detection. This model uses more convolutional and fully-connected layers.


MSFI stands for Multi-Stream Feature Integration, which is a technique to combine features from different scales and perspectives in lung nodule detection. MSFI is part of the MGI-CNN, which is a multi-scale convolutional neural network that developed to improve the performance of false positive reduction in lung nodule detection using the Luna16 dataset.

Suppose we have a 3D patch of a lung image that contains a nodule. We want to detect the nodule and reduce the false positives. We can use MSFI to combine features from different scales and perspectives.

First, we create two streams of input patches from the original patch: a zoom-in stream that crops the patch to focus on the nodule region, and a zoom-out stream that expands the patch to include more surrounding context. We can use different scales for each stream, such as $S1$, $S2$, and $S3$.

Second, we feed each stream into a convolutional neural network (CNN) that extracts features from the patches. The CNN can have multiple layers, such as convolution, pooling, and fully connected layers. The output of the CNN is a feature map that represents the characteristics of the patch. The output of MSFI is a combined feature map that contains information from the streams.

Finally, we use the combined feature map to classify the patch as nodule or non-nodule. We can use a classifier, such as a softmax layer, that assigns a probability to each class. The higher the probability, the more confident the prediction.

By using MSFI, we can improve the performance of lung nodule detection by utilizing features from different scales and perspectives. MSFI helps to capture both the morphological and contextual information of the nodule, and thus reduces the false positives.



# Experiments and Results

## Dataset Luna16

The LUNA16 challenge datasets[@Setio2017validation],, comprising 888 patients with lung nodules annotated by four radiologists, were utilized. Patients with a slice thickness exceeding 2.5 mm were omitted. *A nodule was deemed as Ground Truth (GT) if at least three radiologists concurred. The total number of nodules was 1186*.

For the False Positive (FP) reduction task, LUNA16 supplied candidate nodule coordinates, patient IDs, and labels.

<!-- Two versions of datasets were available: V1 contained 551065 candidates, including 1351 nodules and 549714 non-nodules, with 1120 nodules matching with GTs. V2 contained 754975 candidates, including 1557 nodules and 753418 non-nodules, with total of 1186 nodules matching with GTs. -->

3D patches were extracted from CT scans at scales of 40x40x26, 30x30x10, and 20x20x6, covering most nodules in the dataset. These patches were resized to 20x20x6 using nearest-neighbor interpolation and normalized within the [-1000, 400] HU range.

The network was trained using Xavier's initialization, a learning rate of 0.003, and a total of 40 epochs. ReLU activation and a dropout rate of 0.5 were applied for fully-connected layers. Stochastic gradient descent was employed with a batch size of 128.


The network used a Competitive Performance Metric (CPM) for performance evaluation.


### How CPM Calculated.

Let's assume we have a dataset of 100 CT scans with the following results from the model:

- Total lung nodules: 200
- True positives (TP): 150
- False positives (FP): 800
- False negatives (FN): 50

First, calculate the FP per scan level by dividing the total number of false positives by the total number of scans:

FP per scan level = FP / number of scans = 800 / 100 = 8

The FP per scan level in this example is 8, which matches the desired level.

Next, calculate the sensitivity (true positive rate) using the number of true positives and false negatives:

Sensitivity = TP / (TP + FN) = 150 / (150 + 50) = 150 / 200 = 0.75

In this example, the model's sensitivity at a false positive per scan level of 8 is 0.75 or 75%. This means that the model correctly identifies 75% of the lung nodules when it produces an average of 8 false positives per scan.

### Nodule-to-non-nodule ratio.

A nodule-to-non-nodule ratio of approximately 1:6 is mentioned, which means that for every nodule (a small growth or lump) in the dataset, there are approximately six non-nodule samples. This ratio helps balance the data by ensuring that the model has enough samples of both nodules and non-nodules for training and evaluation.


When the initial ratio is 1:5, to achieve a ratio of approximately 1:6. To do this, we can augment the nodule samples by rotating and shifting them on different planes and axes, creating new nodule samples in the process.

Balancing the data in this manner ensures that the model is trained on a more representative dataset, which can help improve its performance in detecting lung nodules.

## CPM <RESULT>

The Competitive Performance Metric (CPM) score, the average sensitivity at seven FP/scan levels (0.125, 0.25, 0.5, 1, 2, 4, and 8), is used for performance evaluation.

A 5-fold cross-validation was used for evaluation. To balance the data, nodule samples were augmented by rotating and shifting them on different planes and axes, resulting in a final nodule to non-nodule ratio of approximately 1:6.

## Performance Evaluation

To validate this method, we compared with other existing state-of-the-art methods and found this method surpassing others in terms of Competitive Performance Metric (CPM) scores over seven different FP/scan values.

## Efficacy of Proposed Strategies

For contrasting the effects of our strategies in creating a multi-scale CNN, we experimented with other Multi-scale CNNs as well. The performance of this method outclassed all other methods in terms of average CPM and FP reduction, bringing out the significance of our GFE and MSFI strategies.


# Discussions

Lung nodule detection using deep learning techniques can help in early detection and diagnosis of lung cancer. The LUNA16 dataset is a widely used resource for developing and evaluating lung nodule detection algorithms. In this context, the MGI-CNN architecture that has two main advantages:

- It can extract morphological and contextual features at different scales from the input patches. The zoom-in network gradually incorporates contextual information in the nodule region, while the zoom-out network does the opposite. These different ways of integrating multi-scale information provide complementary features that improve the performance.
- It can integrate abstract features from the two streams in MSFI. This maximizes the false positive (FP) reduction by combining features at a high level of abstraction, where the morphological and contextual information are well preserved.

Three different strategies were tested to combine the feature maps of the two streams in MSFI: concatenation, element-wise summation, and 1x1 convolution. Element-wise summation achieved the best FP reduction, although there was no significant difference among them in average CPM.

The input 3D patches were resized to 20x20x6 to fit the network's receptive field size. This may cause some information loss or distortion in the original patches. However, the resized patches still retained the nodule information, as the nodule occupied most of the patch. Therefore, the resizing operation did not affect the performance significantly.

The 232 false positives that the MGI-CNN failed to remove were analyzed and classified into three groups based on their nodule probabilities: Low Confidence (LC; 0.5 ≤ p < 0.7), Moderate Confidence (MC) $0.7 ≤ p < 0.9$, and High Confidence (HC) $p > 0.9$. Most of the false positives were parts of large tissues or organs that the network could not distinguish from nodules.

For the Moderate Confidence (MC) group, the false positives had low contrast, possibly due to normalization during preprocessing. This suggests that network performance could be improved by using more patches with different scales and normalization methods.

The method improving the FP reduction part of a pulmonary nodule detection system, which typically consists of a candidate detection part and an FP reduction part. The network can work with any candidate detection method, as it is independent of it. Combining the network with more advanced candidate detection methods is expected to yield better results.


# Conclusion

The multi-scale gradual integration CNN (MGI-CNN) for reducing false positives (FPs) in lung nodule detection on chest CT scans uses three main strategies:
1. multi-scale inputs with different amounts of contextual information.
2. gradual integration of the features from different scales.
3. multi-stream feature integration by end-to-end learning. These strategies help us to extract morphological and contextual features from the nodule region and reduce the FPs.

We tested this network on the LUNA16 challenge datasets and achieved the best performance with an average CPM of  0.942 on the  LUNA16 dataset, surpassing the existing methods by a large margin. Our method was especially effective in low FP/scan conditions.

We think that our network can also detect nodules directly from the CT scans with minor modifications, such as using $1\times1$ convolution layers instead of fully-connected layers.

For clinical practice, it is also important to classify nodules into different subtypes, such as solid, non-solid, part-solid, perifissural, calcified, spiculated, which may require different treatments. This will be our future research direction.
