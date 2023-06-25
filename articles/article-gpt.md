# abstract
lung cancer is a deadly disease that can be treated better if detected early. One way to detect lung cancer is to use a computer system that can find small lumps called nodules in chest scans. However, finding nodules is hard because they look different and can be confused with other things in the chest. In this study, we propose a new method that uses a special type of neural network to find nodules more accurately. Our method uses three different sizes of patches from the chest scans and combines them gradually to learn more features. We also use two different ways of combining the patches to get more information. We test our method on a public dataset and show that it performs better than other methods in reducing false positives, which are nodules that are not cancerous.

# introduction
lung cancer is the most common cause of death from cancer in the world. However, if lung cancer is found early by screening chest scans, the chances of survival can be improved. One way to screen for lung cancer is to look for nodules in the lungs. Nodules are round or oval-shaped lumps that can be seen in chest scans. Some nodules are cancerous and some are not. A computer system that can help find nodules automatically can save time and resources for doctors and patients.

A computer system for finding nodules usually has two steps:
- first, it finds many possible nodules with high sensitivity, but also many false positives;
- second, it reduces the false positives by using more features and classifiers.
- the second step is challenging because nodules have different shapes, sizes, and types, and they can look like other things in the chest, such as blood vessels or lymph nodes.


In this study, we propose a new method for reducing false positives by using a special type of neural network called multi-scale gradual integration convolutional neural network (mgi-cnn). Our method has three main features:
1. it uses three different sizes of patches from the chest scans as inputs. Each size has different information about the nodule and its surroundings.
2. it combines the patches gradually in different layers of the network, instead of all at once. This way, it can learn more features from different scales.
3. it uses two different ways of combining the patches: one from small to large (zoom-in) and one from large to small (zoom-out). This way, it can get more information from different perspectives.

We test our method on a public dataset called luna16, which has chest scans from 888 patients with annotations from four experts. We compare our method with other methods that use neural networks and show that our method performs better in reducing false positives, especially at low rates. This means that our method can find more nodules that are cancerous and less nodules that are not.


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

In this section, we describe our proposed method, the Multi-Scale Gradual Integration Convolutional Neural Network (MGI-CNN), for pulmonary nodule identification. The network consists of two main components: Gradual Feature Extraction (GFE) and Multi-Stream Feature Integration (MSFI).

## Gradual Feature Extraction
Inspired by the human visual system, which captures meaningful contextual information from a scene by adjusting the field of view, our GFE network gradually integrates contextual information from patches at different scales. We propose two scenarios: Zoom-In and Zoom-Out.

In the Zoom-In scenario, patches at increasing scales are filtered using local convolutional kernels. The resulting feature maps from each scale are concatenated with the patch at the next scale and processed using convolution layers. This process continues until the final integration of contextual information from all scales is achieved. Conversely, in the Zoom-Out scenario, the same operations are performed but with patches in the opposite order.

Our GFE method allows the network to progressively integrate contextual features according to the order of scales, capturing both local and global information. By employing this approach, our network can focus on specific nodule regions or surrounding regions, effectively distinguishing nodules from other structures.

# Conclusion
In this study, we proposed a Multi-Scale Gradual Integration CNN (MGI-CNN) for false positive reduction in pulmonary nodule detection. Our approach leverages multi-scale inputs and gradual integration of contextual information to improve performance. Experimental results on the LUNA16 challenge datasets demonstrated the effectiveness of our method, outperforming existing techniques by a large margin. The proposed network architecture enables the integration of 3D contextual information from multi-scale patches in a gradual and multi-stream manner. Our work contributes to the advancement of pulmonary nodule detection and paves the way for future research in this field.
