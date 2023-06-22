#import "../functions.typ": heading_center, images, italic,linkb

#let finchapiter = text(size: 24pt, fill:rgb("#1E045B"),[■])

= MÉTHODES, RÉSULTATS ET DISCUSSION

== Methods
=== Preprocessing of the data
The first step is to load and process the raw data files. The CT scan data is loaded and processed to produce a 3D array, and the annotation data from LUNA with nodule coordinates and malignancy flags are also loaded. The dataset contains information about all lumps that look like nodules, whether they are malignant, benign, or something else. This information is useful for ensuring a representative range of nodule sizes in the training and validation data.

The second step is to convert raw data files into a format that is usable by PyTorch. This means converting the raw data from 3D array of intensity data to *Tensors* PyTorch format. This data is around 32 million voxels, which is much larger than the nodules. To make the task more manageable, the model will focus on a relevant crop of the CT scan.

The third step is to segment the image to identify potential tumors. Thresholding is a simple and common method of segmentation that works by selecting a pixel value (called a threshold) that separates the foreground (the region of interest) from the background (the rest of the image). For example, if you want to segment the bone from a CT scan, you can choose a threshold that corresponds to the intensity of bone pixels and ignore the pixels that are lower or higher than that value.

The fourth step is grouping interesting voxels to form candidates. The candidate center data expressed in millimeters, not voxels. We need to convert our coordinates from the millimeter-based coordinate system $(X, Y, Z)$ to the voxel-address-based coordinate system $(I, R, C)$. The patient coordinate system defines the positive $X$ to be patient left, positive $Y$ to be patient behind, and the positive $Z$ to be toward patient head.

The fifth step is classifying the nodules using a classification model. The goal of this project is to create an end-to-end solution for detecting cancerous nodules in lung CT scans using PyTorch.

=== Data augmentation

The LUNA16 dataset is a collection of CT scans of patients with lung nodules, which are small growths in the lungs that may indicate cancer. The dataset is part of a Grand Challenge, which is a competition among researchers to develop and test methods for detecting and classifying nodules. The dataset is open and publicly available. It contains 1,186 lung nodules annotated in 888 CT scans by 4 experienced radiologists. The LUNA dataset has two tracks: one for finding the locations of nodules in the scans, and another for reducing false positives by distinguishing benign from malignant nodules.

The project aims to create an end-to-end solution for detecting cancerous nodules in lung CT scans using PyTorch. The approach involves five main steps:

1. Loading the CT data and converting it into a PyTorch dataset.
2. Segmenting the image to identify potential tumors.
3. Grouping interesting voxels to form candidates.
4. Classifying the nodules using a classification model.
5. Diagnosing the patient based on the malignancy of the identified nodules, combining segmentation and classification models for a final diagnosis.

To prevent overfitting, data augmentation is used, which involves modifying a dataset by applying synthetic alterations to individual samples, resulting in a new dataset with a larger number of effective samples. Five specific data augmentation techniques are discussed, including mirroring the image, shifting it by a few voxels, scaling it up or down, rotating it around the head-foot axis, and adding noise to the image.

The project will involve using convolutional layers followed by a resolution-reducing downsampling layer. To handle the computational requirements, you will need access to a GPU with at least 8 GB of RAM or 220 GB of free disk space for raw training data, cached data, and trained models.

=== Model architecture

The model architecture for detecting lung cancer nodules using deep learning is a bi-directional deep learning architecture that aims to design and evaluate a deep learning (DL) algorithm for identifying pulmonary nodules (PNs) using the LUNA-16 dataset and examine the prevalence of PNs using DB-Net. The paper states that a new, resource-efficient deep learning architecture is called for, and it has been given the name of DB-NET.

---

Based on the Luna16 dataset, a detector for lung cancer was created using deep learning. The dataset is a collection of CT scans of patients with lung nodules, which are small growths in the lungs that may indicate cancer. The dataset is part of a Grand Challenge, which is a competition among researchers to develop and test methods for detecting and classifying nodules. The dataset is open and publicly available[^1^].

The project involves using convolutional layers followed by a resolution-reducing downsampling layer. To handle the computational requirements, you will need access to a GPU with at least `8 GB` of RAM or `220 GB` of free disk space for raw training data, cached data, and trained models[^1^].

The model architecture for detecting lung cancer nodules using deep learning is based on alternative image recognition that can be used as a starting point. This Convolutional neural networks typically have a tail, backbone, and head. The tail processes the input, while the backbone contains most of the layers arranged in series of blocks. The head converts the output from the backbone to the desired output form[^2^].

---

Deep Learning for Lung Nodule Detection: Model Architecture and Methodology
The task of detecting lung cancer nodules involves processing 888 CT scans annotated by experienced radiologists, as provided by the LUNA dataset. This dataset offers two tracks: one for locating nodules in the scans, and another for distinguishing benign from malignant nodules, thereby reducing false positives.
The automation of this process involves the design of a convolutional neural network (CNN) for tumor detection, which is based on alternative image recognition. A typical CNN consists of a tail, backbone, and head. The tail processes the input, the backbone contains the majority of layers arranged in blocks, and the head handles the final stages of processing.
Key metrics are displayed graphically to facilitate data interpretation. These metrics include recall, the ability to identify all relevant instances, and precision, the ability to identify only relevant instances. The logging output includes precision metrics, which account for the count of correctly identified samples and the total number of both negative and positive samples.
Overfitting, a common issue in machine learning, occurs when a model learns specific properties of the training set to such an extent that it loses its ability to generalize, thereby reducing its predictive accuracy on unseen samples. To prevent overfitting, it's crucial to monitor the right metrics and understand that an unbalanced validation set can mask this issue.
Data augmentation techniques are employed to generate new training samples from existing ones by applying simple transformations such as shifting/mirroring, scaling, rotation, and adding noise. This helps to increase the robustness of the model.
The raw data, a 3D array of intensity data, is converted into a PyTorch-friendly format, i.e., Tensors. Given the large size of the data (around 32 million voxels), the model focuses on a manageable subset. The process of creating a neural network for lung cancer detection using PyTorch involves handling the dataset to produce a training sample from raw CT scan data and a list of annotations. This process includes loading and processing raw data files, implementing a Python class to represent the data, and converting the data into suitable formats.
The dataset is split into training, validation, and test sets, a crucial step in building a machine learning model. This allows the model to be trained on one set, tuned on another, and evaluated on a final set, thereby preventing overfitting and providing an accurate measure of the model's performance.
The model is trained using a crop of the CT scan that accurately centers the candidate, reducing the variation in expected inputs and making identification easier. The candidate center data, expressed in millimeters, needs to be converted from the millimeter scale to the voxel scale. To extract the nodules, an area around each candidate is extracted, allowing the model to focus on one candidate at a time.


---

Based on the text you provided, the model architecture for detecting lung cancer nodules using deep learning and the LUNA16 dataset involves five main steps. The first step is manipulating the data, which includes loading and processing raw data files and converting them into a PyTorch dataset. The second step is segmentation, which involves identifying potential tumors by searching for voxels with high density around the center of each nodule on the row and column axis. The third step is grouping nodules, which involves grouping pixels that are next to each other and above the limit. Each group is a nodule candidate with a center point (index, row, column). The fourth step is classification, which involves dividing the CT scan into individual slices and using slice-wise predictions to obtain a binary array. Finally, step five is diagnosing the patient based on the malignancy of the identified nodules, combining segmentation and classification models for a final diagnosis.


=== Training and validation

The model architecture for detecting lung cancer nodules using deep learning is a bi-directional deep learning architecture that aims to design and evaluate a deep learning (DL) algorithm for identifying pulmonary nodules (PNs) using the LUNA-16 dataset and examine the prevalence of PNs using DB-Net[^1^]. The paper states that a new, resource-efficient deep learning architecture is called for, and it has been given the name of DB-NET.

---


To detect lung cancer nodules using deep learning, you can use the LUNA16 dataset. The LUNA16 dataset is a collection of CT scans of patients with lung nodules that may indicate cancer. The dataset is part of a Grand Challenge, which is a competition among researchers to develop and test methods for detecting and classifying nodules. The dataset is open and publicly available .

The project involves using convolutional layers followed by a resolution-reducing downsampling layer. To handle the computational requirements, you will need access to a GPU with at least 8 GB of RAM or 220 GB of free disk space for raw training data, cached data, and trained models .

The approach involves five main steps:

1. Loading the CT data and converting it into a PyTorch dataset.
2. Segmenting the image to identify potential tumors.
3. Grouping interesting voxels to form candidates.
4. Classifying the nodules using a classification model.
5. Diagnosing the patient based on the malignancy of the identified nodules, combining segmentation and classification models for a final diagnosis .

The segmentation model is created using a U-Net architecture that can produce pixelwise output for image segmentation . The objective is to flag voxels that might be part of a nodule and use the classification step to reduce the number of incorrectly marked voxels .



== Results
=== {{{
=== Performance Metrics

==== Data Conversion and Manipulation

The first step in the process of detecting lung cancer nodules using deep learning is to load the CT data and convert it into a PyTorch dataset. To do this, the raw data files must be converted into a format that is usable by PyTorch, which means converting the 3D array of intensity data into PyTorch Tensors [Source 5](https://paperswithcode.com/dataset/luna16). The data consists of approximately 32 million voxels, which is much larger than the nodules themselves. To make the task more manageable, the model will focus on a relevant crop of the CT scan. There are various steps involved in processing the data, including understanding the data, mapping location information to array indexes, and converting the CT scan intensity into mass density [text].

=== U-Net Architecture for Image Segmentation

U-Net is a convolutional neural network that can produce pixelwise output for image segmentation. It has a U-shaped encoder-decoder structure that operates at different resolutions. The encoder network reduces the spatial dimensions and increases the number of filters at each block, while the decoder network does the opposite. The key innovation of U-Net is the use of skip connections that link the encoder and decoder blocks at the same level, allowing the network to capture multi-scale features and produce more precise segmentations [text].

==== Nodule Candidate Grouping and Classification

After segmenting the image to identify potential tumors, the next step is to group interesting voxels to form candidates. This can be done by searching for voxels with high density around the center of each nodule on the row and column axis, stopping when low-density voxels are reached, which indicate normal lung tissue. The search is then repeated in the third dimension [text]. Each group is a nodule candidate with a center point (index, row, column). These points are used to classify the candidates, making the search easier and removing noise [text].

==== Diagnosing the Patient

The final step in the process is to diagnose the patient based on the malignancy of the identified nodules. This is done by combining the segmentation and classification models for a final diagnosis. The LIDC annotations are used to decide if a nodule in the lung is cancerous or not. These annotations are labels given by up to four doctors based on how the nodule looks in a CT scan, using a scale from 1 to 5. To make a final decision, a rule is applied that states a nodule is cancerous if at least two doctors gave it a score of 4 or 5. This rule is not very precise, and there are other ways of using the labels, such as taking the average or ignoring some nodules [text].

==== Evaluation Metrics

The performance of the model can be evaluated using various metrics such as accuracy, sensitivity, and specificity. #linkb("https://www.hindawi.com/journals/jhe/2019/5156416/", "For example"), a study on the LIDC/IDRI dataset extracted by the LUNA16 challenge achieved a classification accuracy of 97.2%, sensitivity of 96.0%, and specificity of 97.3% . Other studies have reported similarly high-quality results in detecting and #linkb("https://www.hindawi.com/journals/jhe/2019/5156416/", "classifying lung nodule").

=== }}}


=== Comparison with Other Methods

In the field of lung nodule detection, various techniques and methods have been proposed and implemented. Comparing the deep learning approach using the Luna16 dataset with other methods allows us to better understand the advantages and limitations of different techniques.

Other methods that have been used in the past for lung nodule detection include traditional image processing techniques, machine learning algorithms, and other deep learning architectures. These methods may involve feature extraction, thresholding, region growing, or statistical analysis. While some of these techniques have yielded promising results, the deep learning approach using U-Net and the Luna16 dataset has shown significant improvements in terms of accuracy, sensitivity, and specificity [text].

The U-Net architecture used in this approach provides several advantages over other methods, such as its ability to capture multi-scale features and produce more precise segmentations. Additionally, the use of Luna16 dataset, which consists of high-quality CT scans and expert annotations, further enhances the performance of the model [text].

Despite these advantages, it is essential to consider the limitations of the deep learning approach as well. For example, the model may require large amounts of computational resources, which may not be feasible for all applications. Furthermore, the reliance on expert annotations for training may introduce potential biases and limit the generalizability of the model [text].

By comparing the deep learning approach using the Luna16 dataset with other methods, we can gain a better understanding of the strengths and weaknesses of each technique. This, in turn, can guide future research and development efforts in the field of lung nodule detection and ultimately improve patient outcomes.


== Discussion
=== Interpretation of the results

In the discussion section, it is crucial to delve into the meaning, importance, and relevance of the results obtained from the deep learning approach using the Luna16 dataset for lung nodule detection. This involves explaining and evaluating the findings, showing how they relate to the existing literature and the overall research topic, and making an argument in support of the conclusions drawn [Source 6](https://www.scribbr.com/research-paper/discussion/).

To interpret the results, begin by summarizing the key findings, such as the accuracy, sensitivity, and specificity of the model in detecting and classifying lung nodules [text]. This summary should be concise and directly address the main research question without repeating all the data already reported [Source 6](https://www.scribbr.com/research-paper/discussion/).

Next, evaluate the performance of the deep learning approach in comparison with other methods, highlighting the advantages and limitations of the U-Net architecture and the Luna16 dataset [text]. Discuss the implications of these findings for the field of lung nodule detection, such as the potential for improved patient outcomes or the need for further research and development to address the limitations identified [text].

Finally, consider the broader context of these results and their relevance to the existing literature on lung nodule detection. This may involve discussing how the deep learning approach using the Luna16 dataset contributes to the current understanding of lung nodule detection, as well as identifying any gaps or areas for future research [Source 6](https://www.scribbr.com/research-paper/discussion/).

By interpreting the results in a comprehensive and thoughtful manner, the discussion section can provide valuable insights into the significance of the deep learning approach using the Luna16 dataset for lung nodule detection and its potential impact on the field.


=== Limitations and future work

In the discussion section, it is important to address the limitations of the deep learning approach using the Luna16 dataset for lung nodule detection, as well as outline potential avenues for future research and development [Source 10](https://www.scribbr.com/research-paper/discussion/).

Begin by identifying the limitations of the current study, such as the computational resources required for the deep learning model, which may not be feasible for all applications [text]. Another limitation to consider is the reliance on expert annotations for training, which may introduce potential biases and limit the generalizability of the model [text].

Having acknowledged these limitations, suggest possible strategies for future work to address these issues. For example, future research could explore alternative deep learning architectures or optimization techniques that require fewer computational resources while maintaining high performance [text]. Additionally, researchers might investigate methods for reducing the reliance on expert annotations, such as incorporating unsupervised or semi-supervised learning techniques, or developing strategies to minimize biases in the training data [text].

Furthermore, future work could focus on comparing the performance of the deep learning approach using the Luna16 dataset with other state-of-the-art methods in lung nodule detection, as well as assessing the generalizability of the model to other datasets or clinical settings [text].

By discussing the limitations and outlining potential future work, the discussion section can provide a comprehensive understanding of the current state of lung nodule detection using the deep learning approach with the Luna16 dataset, as well as offer valuable insights into the directions for future research and development in this field.






// // = CONCLUSION ET TRAVAUX FUTURS.
// == CONCLUSION ET TRAVAUX FUTURS.
// == Résumé des principales conclusions et implications.
// == Réponse à la question de recherche.
// == Limites et défis.
// == Perspectives et recommandations.
// == Dépistage du cancer du poumon et défis.
// == Méthodes traditionnelles pour la détection des nodules pulmonaires et limitations.
// == Applications d'apprentissage en profondeur dans l'imagerie médicale et avantages.
// == Théories et concepts pertinents pour votre recherche.
