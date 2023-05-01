#import "book.typ": book
#import "cover.typ": cover
#import "functions.typ": heading_center

#let book_info = (
  title: "SEGMENTATION DES IMAGE MEDICAL PAR INTELLIGENT ARTIFICIAL",
  authors: (
    "Ayoub EL MHAMDI",
    "youssef MADANE",
  ),
  encaders: (
    // "Pr BENHAMOU Mabrouk",
    // "Examinateur",
    // "Pr HACHEM El-Kaber",
    // "Examinateur",
    "Pr RAJAE Sebihi",
    "Encadrant",
  )
)
#show: book.with(book_info)
#cover(book_info)

= REMERCIEMENTS

Nous tenons à remercier d’abord toutes les équipes pédagogiques de *la Filière
Science de la Matière Physique* de la Faculté des Sciences à Meknès, ainsi que les
professeurs ayant contribué activement à notre formation.

Nous profitons de cette occasion pour remercier vivement notre Professeur
*RAJAE SEBIHI* qui n’a pas cessé de nous encourager tout au long de
l’exécution de notre Projet de Fin d’Études, ainsi que pour sa générosité et ses
compétences en matière de formation et d’encadrement. Nous lui sommes
reconnaissants pour ses aides et conseils précieux qui nous ont permis de mener à
bien le présent projet.

Nos vifs remerciements vont aussi aux membres de jury pour avoir accepté de
juger ce travail.

A la même occasion, nous voudrons également remercier chaleureusement nos
parents qui nous ont toujours encouragés durant notre cursus de formation.

Enfin, nos vifs remerciements sont adressés à toutes ces personnes qui nous
ont apporté leur aide précieuse et leur soutien inconditionnel. ■

= TABLE DES MATIÈRES

#outline()

= RÉSUMÉ.
#lorem(120)


= INTRODUCTION GÉNÉRALE.
#lorem(120)
= RÉFÉRENCES BIBLIOGRAPHIQUES.
#lorem(50)
= APERÇU SUR LES SYSTÈMES FRACTALS
#lorem(120)
= Detecting lung cancer using PyTorch

== introduction
The project is to create a detector for lung cancer using ct scans.
Automating this process will provide an experience in dealing with difficult scenarios where solving problems is challenging (exemple …).

On breaking down complex problems into smaller ones, exploring the constraints of an intricate deep learning problem, and downloading the training data. The reader will learn about data formats, data sources, and how to explore the constraints that a problem domain places on the project.

On choose to use the detection of malignant tumors in the lungs using only a CT scan of a patient's chest as input to illustrate how to overcome technical issues. Automatic detection of lung cancer is challenging, and even professional specialists face difficulty in identifying malignant tumors. Automating the process with deep learning will be more demanding and require a structured approach to succeeding.

Detecting lung cancer early is essential for increasing the patient's survival rate, but it's tough to do manually, especially on a large scale.

The problem space of lung tumor detection is important because it is an active research area with promising results. However, it is also unsolved, which satisfies the authors' objective of using PyTorch to tackle state-of-the-art projects.

=== Preparing for a Large-Scale Project
In large-scale project, it will be working with 3D data and require data manipulation, as no pre-built library is available for suitable training samples. The project will involve using convolutional layers followed by a resolution-reducing downsampling layer. To handle the computational requirements, you will need access to a GPU with at least `8 GB` of RAM or `220 GB` of free disk space for raw training data, cached data, and trained models.

Instead of analyzing the entire CT scan, it will break down the problem into simpler tasks. CT scans are 3D X-rays consisting of a three-dimensional array of single-channel data, with each voxel having a numeric value that approximately corresponds to the average mass density of the matter contained inside.

There are multiple approaches to handle large images when training a CNN:

1. **Downsampling**: This involves scaling down the input before passing it into the CNN. You can also downsample the image within the network by picking a large stride, which saves resources for the next layers. However, this method may result in the loss of important data [Source 3](https://ai.stackexchange.com/questions/3938/how-do-i-handle-large-images-when-training-a-cnn).

2. **PCA (Principal Component Analysis)**: This technique helps in selecting an important feature subset, reducing the feature set size [Source 3](https://ai.stackexchange.com/questions/3938/how-do-i-handle-large-images-when-training-a-cnn).

3. **Stochastic Gradient Descent**: Instead of using conventional Gradient Descent, this approach reduces the size of the dataset required for training in each iteration, thus reducing the time required to train the network [Source 3](https://ai.stackexchange.com/questions/3938/how-do-i-handle-large-images-when-training-a-cnn).

4. **Restricting the CNN**: In addition to downsampling in early layers, you can remove the FC (fully connected) layer in favor of a convolutional layer. This will help reduce the number of parameters, but training will still be slow due to the heavy computational load in the early layers [Source 3](https://ai.stackexchange.com/questions/3938/how-do-i-handle-large-images-when-training-a-cnn).

As for choosing the batch size, it depends on your specific situation. For example, with an image size of 2400x2400x3x4, a single image takes ~70 MB, so a batch size of 5 might be more realistic. However, this depends on the available GPU memory, and using 16-bit values instead of 32-bit can help double the batch size [Source 3](https://ai.stackexchange.com/questions/3938/how-do-i-handle-large-images-when-training-a-cnn).

== Approach
The goal of this project is to create an end-to-end solution for detecting cancerous nodules in lung CT scans using PyTorch. The approach involves five main steps:

1. Loading the CT data and converting it into a PyTorch dataset.
2. Segmenting the image to identify potential tumors.
3. Grouping interesting voxels to form candidates.
4. Classifying the nodules using a classification model.
5. Diagnosing the patient based on the malignancy of the identified nodules, combining segmentation and classification models for a final diagnosis.

\[...each approach has goal after starting discussion...\]

== Manipulation the Data

=== Data Conversions

To process the data, it is necessary to convert raw data files into a format that is usable by PyTorch, which means converting the row data from 3D array of intensity data to `Tensors` pyTorch format. This data is around 32 million voxels, which is much larger than the nodules. To make the task more manageable, the model will focus on a relevant crop of the CT scan. There are various steps involved in processing the data, including understanding the data, mapping location information to array indexes, and converting the CT scan intensity into mass density. Identifying the key concepts of the project, such as nodules, is crucial.

=== Data loading
In this chapter, we will discuss the first step in creating a neural network for detecting lung cancer using PyTorch: handling the dataset. The goal is to produce a training sample from raw CT scan data and a list of annotations. The process is described as transmuting the raw data into the stuff that the neural network will spin into gold.

This heading covers the following topics:

- Loading and processing raw data files
- Implementing a Python class to represent the data
- Converting the data into a format usable by PyTorch
- Visualizing the training and validation data

Overall, the quality of the data used to train the model has a significant impact on the project's success.

=== Raw CT Data Files

CT data comes in two files: a *.mhd* file of metadata header information and a *.raw* file of raw bytes. Each file name begins with the series `UID`. The `CT` class loads these files, processes the information to produce a 3D array, and transforms the patient coordinate system to the index, row, and column coordinates of each voxel in the array. Annotation data from LUNA with nodule coordinates and malignancy flags are also loaded, which are used to crop a small 3D slice of the CT data. The CT data, nodule status flag, series UID,

=== Parsing LUNA's Annotation Data

The `candidates.csv` file contains information about all lumps that look like nodules, whether they are malignant, benign, or something else. We'll use this to build a list of candidates that can be split into training and validation datasets. The annotations.csv file contains information about some of the candidates that have been flagged as nodules, including the diameter. This information is useful for ensuring a representative range of nodule sizes in the training and validation data.

=== Training and validation sets

For supervised learning tasks like classification, we need to split our data into training and validation sets. We want to ensure that both sets represent the real-world input data that we expect to see and handle normally. If either set is significantly different from our actual use cases, it's highly likely that our model will behave differently than we expect. This split helps us evaluate and improve the model's performance before we deploy it on production data.

=== Loading individual CT scans

We need to understand how to load and understand CT scan data, which is usually stored in a DICOM file format. The MetaIO format is suggested for easier use, and the Python SimpleITK library can be used to convert it to a NumPy array. Each CT scan is uniquely identified by a series instance UID. The Hounsfield Unit (HU) scale is used to measure CT scan voxel density, with air at -1000 HU, water at 0 HU, and bone at least 1000 HU.

=== Data Ranges and Model Inputs

Starting with adding channels of information to our samples. To prevent the overshadowing of the new channels by raw HU values, we must be aware that our data ranges from -1,000 to +1,000. We won't add more channels of data for the classification step, so our data handling will remain the same.

Fixed-size inputs are necessary due to a fixed number of input neurons. We want to train our model using a crop of the CT scan that accurately centers the candidate, making identification easier for the model by decreasing the variation in expected inputs.

=== The Patient Coordinate System

The candidate center data expressed in millimeters, not voxels. We need to convert our coordinates from the millimeter-based coordinate system $(X, Y, Z)$ to the voxel-address-based coordinate system $(I, R, C)$. The patient coordinate system defines the positive $X$ to be patient left, positive $Y$ to be patient behind, and the positive $Z$ to be toward patient head. The patient coordinate system is often used to specify the locations of interesting anatomy in a way that is independent of any particular scan.

=== CT Scan Shape and Voxel Sizes

The size of the voxels varies between CT scans and typically are not cubes. The row and column dimensions usually have voxel sizes that are equal, and the index dimension has a larger value, but other ratios can exist.

=== Converting Between Millimeters and Voxel Addresses

Converting between patient coordinates in millimeters and (I,R,C) array coordinates, we define some utility code to assist with the conversion. Flipping the axes is encoded in a $3 times 3$ matrix. The metadata we need to convert from patient coordinates to array coordinates is contained in the MetaIO file alongside the CT data itself.

In CT scan images of patients with lung nodules, most of the data is not relevant to the nodule (up to 99.9999%). To extract the nods, an area around each candidate will be extracted, so the model can focus on one candidate at a time.

The implementation involves building a dataset by subclassing PyTorch Dataset. The LunaDataset class flattens a CT's nodules into a single collection. The implementation of this class requires two methods: the first method returns the number of samples in the dataset, whereas the second returns a sample data needed to train (or validate).

== Training

=== XXX 1
==== steps to training

\[...\]
The design of a convolutional neural network for detecting tumors. They state that although the design space for such a network is vast, there have been effective models for image recognition that can be used as a starting point. A pre-existing network design will be modified for the project, with some adjustments made due to the input data being 3D.

This image shows the structure of the network and mentions that the four repeated blocks that make up most of the network will be examined in more detail.

Convolutional neural networks typically have a tail, backbone, and head. The tail processes the input, while the backbone contains most of the layers arranged in series of blocks. The head converts the output from the backbone to the desired output form. One block consists of two `3x3` convolutions followed by max-pooling. Stacking convolutional layers allows the final output to be influenced by input beyond the size of the convolutional kernel. A fully connected layer followed by `nn.Softmax` makes up the tail. Softmax is used for single-label classification tasks and expresses the degree of certainty in an answer.

Our implementation of a deep learning model is called `Luna`, used for computer-aided detection of lung nodules in medical images. The model uses convolutional neural networks and `softmax` layers to classify the images. The text also covers techniques for initializing the model parameters and the training process for the model. Different from previous training loop examples, the author uses a tensor to collect per-class metrics while iterating over the train data loader, and the actual loss computation is done in the computeBatchLoss method. The purpose of the `trnmetrics_g` tensor is to store information about the model's behavior on a per-sample basis from the `computeBatchLoss` function to the `logMetrics` function.

The `computeBatchLoss` function calculates the loss over a batch of samples which is used by both the training and validation loops. The core functionality of the function is feeding the batch into the model and computing the per-batch loss. By recording the label, prediction, and loss for each sample, we can have a wealth of detailed information we can use to investigate the behavior of our model. The validation loop is similar to the training loop, but without updating network weights. Per epoch, the performance metrics are logged and the progress is tracked. This logging is important because it helps us to notice when training is going off track and to keep an eye on how our model behaves.

==== `logMetrics` Function

The `logMetrics` function displays the results of the `computeBatchLoss` function with details about the training or validation samples. The `mode_str` argument indicates whether the metrics are for training or validation.

Two input tensors `trnmetrics_t` and `valMetrics_t` are used to log the results. Both tensors have floating-point values filled with the data during `computeBatchLoss`.

The function applies tensor masking and Boolean indexing while constructing masks. The purpose is to limit the metrics to only the nodule or non-nodule samples and count the total samples per class, as well as the number of samples that are classified correctly.

The function then computes some per-label statistics and stores them in a dictionary, `metrics_dict`. It determines the fraction of samples that are correctly classified, as well as the fraction that is correct from each label.

Finally, the results are displayed as percentages using the `log.info` function.

==== Epoch Training

The text talks about the first epoch of a deep learning model's training process. The first epoch is divided into 20,193 steps called batches, each containing 256 data points. The training progress is represented in a log format, showing the number of batches that have been completed and the current status of the training process.

The text also highlights the importance of preparing the data cache for training, which can take a significant amount of time to process. The exercises in Chapter 10 provide tools and scripts to make the caching process more efficient. Once the data is loaded and the training process begins, monitoring the performance of the computing resources is crucial to ensure that resources are being used effectively.

The text also discusses the need to maximize the use of available computing resources during the training process to minimize the training time. The authors recommend checking the CPU and GPU load to identify the root of performance bottlenecks that may arise during the training process. It is suggested that these bottlenecks can be addressed by optimizing the caching process and using more efficient waiting strategies during the training process.
The text discusses data requirements for deep learning training and the need for sanity checks to ensure all data is accounted for. The `enumerateWithEstimate` function is introduced as a tool for estimating completion times during training. The output of the model training script is analyzed, showing the need to consider consequences of misclassification. The text also introduces TensorBoard as a tool for graphing training metrics and mentions its official support in PyTorch.
To use TensorBoard, we need to install tensorflow. We can install the default CPU-only package. We also need to segregate our data into separate folders for each project to make it easier to manage as TensorBoard can get quite complex. Once installed, we can start TensorBoard by invoking it from any directory and pointing it to the directory where our data is stored. After starting TensorBoard, we should be able to access the main dashboard by pointing our browser to http://localhost:6006. The main part of the screen displays training and validation metrics in a graphical format, making it easier to interpret the data. We can adjust the smoothing option to remove noise from trend lines if our data is noisy. We can also select which runs to display and delete runs that are no longer of interest. To add our data to TensorBoard, we use the `torch.utils.tensorboard` module to write metrics data in a format that TensorBoard can understand. We create `SummaryWriter` objects for the training and validation runs and write the data for each epoch using the `add_scalar` method. We can also add comments to our training script to make the data more informative. Finally, we can use TensorBoard to visualize our data and make it easier to analyze.
To keep your `runs/` directory clean, it's important to delete the runs that didn't yield useful results. Writing scalars is easy. We can use the `metrics_dict` we've constructed and pass each key/value pair to the `writer.add_scalar` method. This method is found in the `torch.utils.tensorboard.SummaryWriter` class with the signature `add_scalar(tag, scalar_value, global_step=None, walltime=None)`.

==== Summary

In the given code snippet for adding values to TensorBoard graphs, the `tag` parameter gives the name of the graph, the `scalar_value` represents the Y-axis value, and the `global_step` parameter indicates the X-axis value. In the `doTraining` function, `totalTrainingSamples_count` is used as X-axis by providing it as input to the `global_step` parameter.

The key names separated by slashes create groups of charts with the substring before the '/'. Although the documentation advises using the epoch number as the `global_step` parameter, using the count of training samples that were presented to the network could be more beneficial, particularly when fewer samples are present or the number of samples is subject to change.

The loss trend lines highlight that the model is learning something. However, the model struggles to learn correctly about the desired output, particularly because the vast majority of cancer-detection answer set (around 99.7%) is false. The model typically decides that the answer to every question is false, which is similar to a student merely marking all the answers false in a test. However, the grades do not only reflect real knowledge, such as obtaining a comprehensive understanding of the topic by getting more questions right. Hence, to enhance the output, the author suggests introducing meaningful terms and a better way of grading.

==== Conclusion

The chapter has provided a model and a training loop, and now we are able to use the data produced in the previous chapter. The metrics are being displayed in the console and graphed visually, but the results are not fully usable yet. However, the upcoming chapter will focus on improving the metrics and using them to make necessary changes in order to achieve better results.

==== XXX

Data loaders can be used to load data from various sets by utilizing various processors. This enables unused CPU resources to be utilized for preparing data to be fed to the GPU.

Each dataset may contain several samples which can be loaded by data loaders in batches. PyTorch model processing is designed to operate on batches of data and not individual samples.

Data loaders can be used to modify data by adjusting the frequency of specific samples. This can be done to enhance or modify the dataset, although it may be more rational to directly modify the dataset.

In part 2, PyTorch's torch.optim.SGD optimizer will be utilized with a learning rate of 0.001 and a momentum of 0.99, which are the default values for most deep learning projects.

The initial model employed for classification will be quite similar to the model used in chapter 8 in order to start with a model that is believed to be effective. If it hinders the project's performance, it can be revisited.

For the majority of the deep learning projects, it's critical to choose appropriate metrics while monitoring the training sessions. By using misleading metrics, it is possible that the overall accuracy may not be as expected. Chapter 12 will explain how appropriate metrics can be chosen while evaluating.

TensorBoard can be utilized to represent numerous metrics visually, making it easier to consume such data as it varies per epoch of training.

This chapter focuses on how to quantify, express, and then enhance the performance of our model. We will adopt a metaphor derived from the "Guard Dogs and Birds and Burglars" approach to make the chapter's concepts more relatable. We will then create a visual language to represent some of the principal concepts needed to formally discuss the shortcomings of the implementation discussed in the previous chapter. Ratios such as Recall and Precision will be dealt with, and we will devise a way to score our model's performance, encapsulated in a single number as a New Metric, F1 Score. Finally, we'll introduce changes to LunaDataset to improve our training results, which include Balancing and Augmentation.

Our goal is to improve the performance of our trained model. By the end of the chapter, the model will perform much better and be capable of generating results that are clearly superior to chance. False positives and false negatives will be more explicitly discussed as well.

Roxie and Preston are two well-intentioned guard dogs from obedience school. While both dogs bark at burglars, Roxie barks at almost anything, while Preston only barks occasionally. Roxie makes too many false positive alerts, such as to thunderstorms and fire engines, so we will focus on the topic of false positives and false negatives in the chapter.
The text discusses the issues with using guard dogs to protect a house, as they can have a high number of false negatives, meaning they may ignore a real threat. The author uses a visual representation to explain true and false positives/negatives, in which burglars and rodents are considered threats, while birds are not. The X-axis shows the bark-worthiness of each event as determined by the guard dogs, while the Y-axis shows properties that humans perceive but dogs cannot. The model used to protect against cancer, which is much more complex than guarding a house, maps events and properties to a two-dimensional space so positive and negative events can be separated. The quadrant areas can be used to evaluate how well the model performs.

==== Recall and Precision in Guard Dogs

Recall is the ability to identify all relevant things, while precision is the ability to identify only relevant things. In guard dog terms, recall means never missing any potential robbers, while precision means only barking at burglars.

To improve recall, minimize false negatives by barking at anything that could potentially be a robber. This means pushing the classification threshold all the way to the left to encompass nearly all positive events. Roxie the dog has an incredibly high recall due to her barking at everything, but this leads to a large number of false positives.

To improve precision, minimize false positives by only barking at certain things. This means pushing the classification threshold all the way to the right to exclude a large number of negative events. Preston the dog has an incredibly high precision due to his only barking at burglar behavior, but this leads to a large number of false negatives.

While neither precision nor recall can be the single metric used to grade a dog's performance, they are both useful numbers to have on hand during training. It is important to balance both recall and precision when training a guard dog to identify potential robbers.
Implementing Precision and Recall in logMetrics

The metrics precision and recall are important during training because they reveal how well models are performing. If either of these metrics drops to zero, it could mean the model is behaving poorly. We would like to update the logmetrics function to include precision and recall in its output, so we can monitor them alongside the loss and correctness metrics. We have already calculated some of the values we need, but we have to include false positive and false negative values for the rest. With these values, we can compute precision and recall and store them in metrics-dict.

The ultimate performance metric is the F1 score, which combines the values of precision and recall. The F1 score is better than averaging since averaging assigns the same score of 0.5 to values of 1.0 and 0.0, which is not meaningful. The F1 score implies a balance between precision and recall. We can use other metrics like $\\text{min}(p, r)$, but they penalize the imbalance between precision and recall and do not capture the nuance between the values. Finally, we could multiply precision and recall's values, but this is not beneficial when the results are close to perfect.
The text discusses the importance of having a metric that's sensitive to changes in the early stages of model design, and therefore, the author opted to use the F1 score to evaluate classification model performance. The author updates the logging output to include precision, recall, and F1 score by including the exact values for the count of correctly identified and the total number of samples for both negative and positive samples. The new metrics result in drastically poorer performance results for the model. The author mentions that having an ideal dataset entails balancing positive and negative samples to better train the model. Currently, the dataset is imbalanced, with a 400:1 ratio of positive samples to negative ones, which is making "actually nodule" samples get lost in the crowd. As there are too few positive samples among the training data, the author proposes changing the class balance of the training data to look more like an "ideal" dataset.
The article discusses the importance of balancing training data for building and training machine learning models. The imbalanced data can lead to the degenerate behavior of the model scoring well by answering only one label, which is not useful in the real-world scenario. To achieve discrimination, the dataset needs to be updated to alternate between positive and negative samples in a balanced manner. One way to accomplish this is by using samplers that reshape, limit, or reemphasize the underlying data. However, in this article, the implementation of class balancing within the dataset is discussed where the positive and negative training samples are kept separate and alternated to prevent the degenerate behavior of the model. The article also raises concerns regarding the real-world discriminatory bias being present in the models trained from the internet-at-large data sources.
The text discusses the importance of using a balanced dataset for training a neural network model to improve its performance in predicting positive samples. It outlines a method of creating a dataset with a 2:1 ratio of negative to positive samples and shows how to implement it in the code. The article also describes the process of training the model using TensorBoard and highlights the problem of overfitting, which occurs when the training loss improves while the validation loss deteriorates. The article ends by emphasizing the need to stop the training process if overfitting occurs to prevent the model from getting worse in real-world scenarios.

==== Revisiting the problem of overfitting

Overfitting occurs when a model learns specific properties of the training set, losing the ability to generalize, and making it less accurate in predicting samples that haven't been trained on. For instance, a model can memorize quirks of a small set of positive training samples and consider everything else negative, which decreases its generalization ability.

To avoid overfitting, we must examine the right metrics. Looking at our overall loss, everything might seem fine, but that's because our validation set is unbalanced, and the negative samples dominate, making it hard for the model to memorize individual details. We need to make our training set and validation set both trend in the right direction to achieve better results. Figure 12.19 shows that our negative loss looks great since we have more negative samples (400 times) and, thus, it's harder for the model to memorize individual details.

Although some generalization is still going on, since we are classifying about 70% of the positive validation set correctly, we must change our training approach to improve our model's ability to recognize the general properties of the classes we are interested in. Overfitting is a common situation in machine learning that requires our attention to ensure the model's accuracy and reliability.
The article discusses the concept of overfitting and how it can affect a model that predicts the age of human faces. An overfit model remembers specific individuals' identifying details instead of developing a general model based on age signifiers. This leads to inaccuracies in predicting the age of a new picture. To prevent overfitting, the article suggests data augmentation, which involves modifying a dataset by applying synthetic alterations to individual samples, resulting in a new dataset with a larger number of effective samples. Five specific data augmentation techniques are discussed, including mirroring the image, shifting it by a few voxels, scaling it up or down, rotating it around the head-foot axis, and adding noise to the image. The article also provides code snippets to help readers understand how to implement these techniques.

=== Data Augmentation Techniques for Medical Imaging

This text discusses various data augmentation techniques that can be used to improve the accuracy of machine learning models when applied to medical image data. The techniques are designed to create new training samples from the existing ones by applying simple transformations. The transformations include shifting/mirroring, scaling, rotation, and adding noise. The article provides code examples to demonstrate the implementation of each augmentation technique that can be integrated into a machine learning pipeline. In addition, the article discusses how these techniques can be examined and compared to select the best augmentation strategy.

==== Summary:

This chapter discusses how to evaluate a model's performance and the importance of understanding the factors that contribute to it. It also covers dealing with insufficiently populated data sources and synthesizing representative training samples. The focus then shifts to finding candidate nodules and classifying them as malignant or benign in the upcoming chapters.

=== Segmentation 1

The focus of the chapter is the process of segmentation to identify possible nodules, which is step 2 of the project's plan. The segmentation model is created using a U-Net and involves updating the model, dataset, and training loop. The objective is to flag voxels that might be part of a nodule and use the classification step to reduce the number of incorrectly marked voxels. The chapter explains the steps involved in creating a model for segmentation, including per-pixel labeling and training with masks. Finally, the results of the new model are evaluated through quantitative segmentation.

==== Various types of segmentation

This article talks about different types of segmentation, specifically about semantic segmentation. Semantic segmentation classifies pixels in an image into labels such as "cat", "dog", etc. resulting in distinct regions identifying things like "all of these pixels are part of a cat". The article also briefly discussed instance segmentation and object detection, which are more complicated approaches. However, for this project, they are not the best approaches to find nodule candidates.

==== Semantic segmentation: Per-pixel classification

Semantic segmentation identifies different objects and where they are in a given image. If there are multiple cats in an image, semantic segmentation can identify each cat's position. The existing classification models can't pinpoint where the cat is; they can only predict whether or not a cat is present in the image.

Semantic segmentation requires combining raw pixels to develop specific detectors for items like color and then building on this to create more informative feature detectors to finally identify specific things like a cat or a dog. Nonetheless, the segmentation model will not give us a single classification-like list of binary flags like classification models since the output should be a heatmap or mask.

If we use only convolutional "layers" without downsampling, we can get an output the same size as the input, but our receptive field will be very limited. Meaning that each segmented pixel will only consider a very localized area.
Assuming $3 \\times 3$ convolutions, the size of the receptive field for a simple model of stacked convolutions is $2 * L+1$, with L being the number of convolutional layers. For instance, four layers of $3 \\times 3$ convolutions will have a receptive field size of $9 \\times 9$ per output pixel. By inserting a $2 \\times 2$ max pool between the second and third convolutions, and another at the end, we increase the receptive field to $16 \\times 16$. However, this happens after the first max pool, which makes the final effective receptive field $12 \\times 12$ in the original input resolution. One common way to improve the receptive field of an output pixel while maintaining a 1:1 ratio of input pixels to output pixels is to use a technique called upsampling.

The U-Net architecture is a design for a neural network that can produce pixelwise output and was invented for segmentation. The design of this architecture is complicated, as it is a lot different compared to the mostly sequential structure of the classifiers. The U-Net architecture is good for image segmentation. The model has a U-shape, and it operates at different resolutions. It first goes from top left to bottom center through a series of convolutions and downscaling, then uses upscaling convolutions to get back to the full resolution. The U-Net author added the skip connections in the model to address the previous design problems, which skip connections are short-circuited inputs along the downsampling path into the corresponding layers in the upsampling path. The key innovation behind U-Net is having the final detail layers operating with the best of both worlds.

To perform segmentation, we need a model that is capable of outputting a probability for every pixel. Instead of implementing a custom U-Net segmentation model from scratch, we are going to update an existing implementation from an open source repository on GitHub.
It is important to understand the license terms of open source software used in a project, even if it is for personal use. The MIT license, although flexible, still has requirements. The author still has copyright to their work even if they publish it on platforms like GitHub. It is not in the public domain unless explicitly stated.

To understand a model's architecture, it is suggested to inspect the code and identify the building blocks. This exercise can aid in recognizing skip connections and creating a diagram for the model layout.

When searching for a suitable model implementation, it is recommended to keep an eye out for models that can be adapted to fit the project's needs. It is essential to familiarize oneself with models that exist and their implementations and training processes. Also, knowledge of what parts can be scavenged and applied to current projects can be helpful. Building this knowledge toolkit is important, even for beginners.

==== Adapting an off-the-shelf model to our project

We're going to make changes to the classic U-Net model, to better suit our project's needs. We'll pass the input through batch normalization to get normalization statistics and restrict output values in the range $\[0,1\]$ with a sigmoid layer. We will also reduce the model's depth and number of filters. Our output will be in a single channel. We can wrap U-Net by implementing a model with three attributes.

==== Updating the dataset for segmentation

Our source data remains the same: CT scans and annotation data. But, our model produces output of a different form than we had previously. To solve this, we need to produce 2D data now. We'll use padded convolutions and certain input sizes for the U-Net model to get the output of the same size.

U-Net has specific input size requirements, causing some regions near the edges of the image to be artificially padded, but that's a compromise we'll accept.

==== U-Net trade-offs for 3D vs. 2D data

The data we have is of 3D, doesn't line up exactly with the 2D expected input. Feeding a 512 x 512 x 128 image into a converted-to-3D U-Net class won't work due to the GPU memory exhaustion. For example, the first layer of U-net is 64 channels, which is *8 GB* just for the first convolutional layer.

Instead of handling things in 3D, we treat each slice as a 2D segmentation problem and use neighbouring slices as separate channels. We lose the direct spatial relationship between slices as all channels are combined by the convolution kernels.

We also lose the wider receptive field in the depth dimension that would come from a true 3D segmentation with downsampling. In contrast, CT slices are usually thicker than the resolution in rows and columns.

There isn't an easy flowchart or rule of thumb that can give canned answers to questions about which trade-offs to make, or whether a given set of compromises compromise too much. Careful experimentation is key, and systematically testing hypothesis after hypothesis can help narrow down which changes and approaches are working well for the problem at hand.

==== Building the ground truth data

We have annotated points but we want a per-voxel mask that indicates whether any given voxel is part of a nodule. We'll have to build that mask ourselves from the data we have and then do manual checking to make sure the routine that builds the mask is performing well.

Our API allows us to easily grab results and plot them in a notebook. We are going to begin by converting the nodule locations we have into bounding boxes that cover the entire nodule.

To accomplish this goal, we start the origin of our search at the annotated center of our nodule. We then examine the density of the voxels adjacent to our origin on the column and row axis until we hit low-density voxels, which indicate that we've reached normal lung tissue. Finally, we search in the third dimension.

Our final bounding box is five voxels wide and seven voxels tall.
The text discusses how to create a bounding box around nodules in CT scans. This involves tracing outward from the nodule location in all three dimensions until low-density voxels are found. The bounding box is represented as a Boolean tensor which marks the voxels above the density threshold. The boundary of the box might include a portion of the lung wall, but this issue is not fixed. The text also mentions that the annotation data needs to be cleaned up, as several candidates are listed multiple times in the CSV file.
The text describes how to update the `getCandidateInfoList` function to pull nodules from a new annotations file. The data produced will be two-dimensional CT scans with multiple channels. These channels will hold adjacent slices of CT. The input to the segmentation model treats each slice as a single channel and produces a multichannel 2D image. The validation set will consist of one sample per slice of CT that has an entry in the positive mask. For handling the flag indicating whether this is meant to be a training or validation set, we partition the list of series into training and validation sets. The handling for the validation set needs to change. During training, we limit ourselves to only the CT slices that have a positive mask present. We need a new function that caches the size of each CT scan and its positive mask to disk. This is important to quickly construct the full size of a validation set without having to load each CT at Dataset initialization.

==== Conclusion

This text describes the process of designing and creating datasets for training and validating a segmentation model for detecting nodules in CT scans. The `dsets.py` file contains the code for creating these datasets.

To create the datasets, the series_uid values representing the CT scans are identified and used to filter the `candidateInfo_list` to include only nodule candidates with a series_uid that is included in that set of series. Additionally, another list containing only the positive candidates is created for training purposes.

The `_getitem_` function is used to return the appropriate type (full slice or training crop) based on whether it's training or validation.

For training, instead of the full CT slices, $64 \\times 64$ crops around the positive candidates are used. These crops are randomly taken from a $96 \\times 96$ crop centered on the nodule. Three slices of context are also included as additional "channels" to the 2D segmentation.

The validation dataset uses the same convolutions with the same weights, but applied to a larger set of pixels. Due to the inclusion of more negative pixels, the model will have a high false positive rate during validation.

==== Implementing TrainingLuna2dSegmentationDataset

This section of the text presents the code implementation of the "TrainingLuna2dSegmentationDataset". The code snippet shows the implementation for a method  for the training set, where samples are taken from "pos_list". This method is almost the same as the one for the validation set. However, there is a difference, as the "getItem_trainingCrop" method is used to process the sample with candidate info from the tuple. This tuple includes both the series and the exact center location, which is not available in just the slice. The code snippet shared below provides additional details on the implementation of the "__getitem__" method for the "TrainingLuna2dSegmentationDataset".

The text discusses implementing `getitem_trainingCrop` using `getctRawCandidate` function, which crops the image to a smaller size and returns an array with an additional crop. The data augmentation process is moved to the GPU to avoid bottleneck issues. A new model is introduced called `SegmentationAugmentation`, which consumes and produces tensors similarly to other models. The `training.py` script is updated to instantiate the new model, introduce Dice loss, and logs more metrics such as TensorBoard images, along with saving based on validation. The new model's initialization is similar to that of `UNetWrapper`.
UNet Input and Output

- For input into UNet, we have seven input channels; $3+3$ context slices, and 1 slice that is the focus for what we're actually segmenting.
- We have one output class indicating whether this voxel is part of a nodule.

UNet Depth and Filters

- The depth parameter controls how deep the U goes; each downsampling operation adds 1 to the depth.
- The first layer will have \$2 \*\* \\wf==32\$ filters (using \$\\wf=5\$), which doubles with each downsampling.

UNet Convolution, Batch Normalization, and Upsampling

- We want the convolutions to be padded so that we get an output image the same size as our input.
- We also want batch normalization inside the network after each activation function, and our upsampling function should be an upconvolution layer.

Adam optimizer

- Adam maintains a separate learning rate for each parameter and automatically updates that learning rate as training progresses.
- It's generally accepted that Adam is a reasonable optimizer to start most projects with.

Dice Loss

- The Sørensen-Dice coefficient or Dice loss is a common loss metric for segmentation tasks.
- It handles the case where only a small portion of the overall image is flagged as positive.
- We're basically going to be using a per-pixel F1 score where the "population" is one image's pixels.
- We're going to take our ratio and subtract it from 1 to invert the slope of our loss function so that in the high-overlap case, our loss is low; and in the low-overlap case, it's high.
- We're going to update our computeBatchLoss function to call diceLoss.
- By multiplying our predictions times the label (which are effectively Booleans), we'll get pseudo-predictions that got every negative pixel "exactly right."
- We're providing a loss that represents the fact of providing high recall.
  The text discusses a method for optimizing a model for better recall in segmentation tasks by sacrificing many true negative pixels through a false negative loss function. The performance metrics are computed using `computeBatchLoss`, which uses per sample values and summary statistics for true positives and other metrics. The results are visually represented with `TensorBoard` through `logImages`, which displays ground truth and model outputs for selected CT scans. The output images can be compared with a slider that shows previous epochs' images.
  The code creates an empty image with 512x512 pixels and three color channels. The image is used for flagging false positives and false negatives in a prediction. False positives are marked in red and overlaid on the image, while false negatives are marked in green. Pixels that are both false negatives and false positives are marked in orange. The final image is clipped between 0 and 1.
  The goal is to have a grayscale CT image with predicted-nodule pixels in various colors. Red is used for incorrect pixels (false positives and false negatives), green is used for correctly predicted pixels inside the nodule, and half-strength mask added green is used for false negatives, which appear as orange. The data is then renormalized to the 0.1 range and saved to TensorBoard. Per-epoch metrics are computed, including true positives, false negatives, and false positives. The recall will be used to determine the best model for this training run, and a flag will be included to indicate the best score we've seen. Finally, the saveModel function is implemented to persist the model to disk.
  In this section, we learn about how to save our model in PyTorch. It is recommended to save only the parameters of the model, using the model.state_dict() function. This approach allows us to load those parameters into any model that expects parameters of the same shape, even if the class doesn't match the saved model. We set the file path to our saved model. If we saved the optimizer state as well, we could resume training seamlessly. If the current model has the best score, we save a copy of state with a .best.state filename. PyTorch has the facility to save and load the model by using the torch.save and torch.load functions.

We have made all our code changes, and now it’s time to check the results of our proposed models after implementation. We first look at training metrics, and then we compare them to validation metrics. The F1 score, TPs, FPs, and FNs are in rows we need to be concerned about since they should all trend towards improvement. We may have fewer FPs and FNs along with higher accuracy. The validation metrics in general look good, but the test of the model still needs to be done. We have a higher false positive rate, which is expected because of the larger size of pixels we validate.

Our recall plateaus and then starts dropping, indicating overfitting, which can be further confirmed from figure 13.18. U-Net architecture has great capacity, and even with our reduced filter and depth counts, it memorizes our training set fairly quickly.

==== Segmentation Recall is Top Priority

In segmentation, recall is the top priority for the model, meaning the model should prioritize identifying all relevant instances, even if it results in some false positives. Precision can be handled downstream by classification models. As a result, it is more challenging to evaluate the model's performance, as it presents skewed results. The authors propose using the F2 score to mitigate this issue, but they will score the model solely based on recall and use human judgment to ensure that the training runs are not too focused on it. They trained their model on the Dice loss. However, this approach may not always be reliable, as educated guesses do not replace actual experimentation.

==== Good Enough Metrics

The authors have already trained and evaluated the model for Chapter 14, so they know its outcome. However, there is no guarantee that the results will hold up in a new situation. Nevertheless, the model's performance is currently deemed good enough to proceed with the end-to-end project, despite some extreme metric values.
This chapter discusses a new model architecture called U-Net, which is used for pixel-to-pixel segmentation. The segmentation is different from classification as it flags individual pixels or voxels for membership in a class. We developed a training loop with the ability to save images to TensorBoard, and we have moved augmentation from the dataset into a separate model that can operate on the GPU. It is possible to train a segmentation model on image crops while validating on whole-image slices. In addition, we looked at our training results and adapted an implementation for our own use.

We can use segmentation followed by classification for detecting nodules. We avoid the potential leak from the training set to the validation set by splitting the data into a training set and an independent validation set. We must avoid this situation as it may lead to performance figures that would be artificially higher compared to what we would obtain on an independent dataset.

We should keep an eye on the end-to-end process when defining the validation set, and the easiest way to do this is by having two separate directories for training and validation. After the validation dataset is defined, we can train our model. We can bridge the CT segmentation and nodule candidate classification models to reach the goal of our project, which is to automatically detect cancer.

==== Writing Code for Nodule Analysis

The chapter focuses on grouping segmented voxel data into nodule candidates and further classifying those candidates using a malignancy classifier. The process uses a saved segmentation model from chapter 13 and a newly trained classification model.

The aim is to convert the segmentation output into sample tuples. The groupings work by finding the dashed outline around the highlight in figure 14.3. The input is the segmented voxels flagged by the segmentation model, and the output is the center of mass coordinates of each 'lump' of flagged voxels.

Running the models is similar to the training and validation processes, but with a loop over the CTs. For each CT, every slice is segmented, and the segmented output is used as the input to the grouping process. The grouping output is then used as input to a nodule classifier, and the surviving nodules are passed to a malignancy classifier.

The process is executed by an outer loop over the CTs, which segments, groups, classifies the candidates, and provides the classifications for further processing.

The methods- 'segmentct,' 'groupSegmentationoutput,' and 'classifyCandidates'- are broken down in the following sections.

![figure 14.3](https://cdn.mathpix.com/cropped/2023_04_27_14ff7830b8aaf17904d3g-177.jpg?height=972&width=1430&top_left_y=189&top_left_x=223)

*Note: Listing 14.1, i.e., `NoduleAnalysisApp.main`, is presented for further understanding.*

=== Segmentation 2

This step involves dividing the CT scan into individual slices. A `Dataset` is created, which loads a single slice of a CT scan with a given `series_uid`. The output of the segmentation step is an array of per-pixel probabilities, indicating whether the pixel is part of a nodule. These slice-wise predictions are collected in a mask array with the same shape as the CT scan input, and a threshold is applied to the predictions to obtain a binary array. A cleanup step is then performed using the `scipy.ndimage.morphology` erosion operation, which shortens the flagged area and removes small components. The code will use the GPU if it's available. The function used for this step is called `segmentct`.

The text discusses the process of identifying nodule candidates in CT scans for possible cancer detection. A connected-components algorithm is used for grouping the suspected nodule voxels. The labeled chunks are passed on to a classification module to reduce false positives. The text also discusses the difference between fully automated and assistive systems. The goal is to discard a large amount of irrelevant data from millions of data points to a handful of tumors. Finally, the identified regions in the CT scan are cropped and passed onto the classification module using DataLoader.
We use a data loader to loop over a candidate list to threshold the output probabilities to get a list of things our model thinks are actual nodules, which would be output for a radiologist to inspect while adjusting the threshold to err a bit on the safe side. A single CT scan from the validation set is run and 16 nodule candidates are found. A confusion matrix is created with our results, showing that we found the 1 malignant nodule but missed a 17th benign one, and 15 false positive non-nodules made it through the nodule classifier. Quantitative validation is done and we detected 132 of the 154 nodules, or 85%. Toward the end of this chapter, some pointers to papers and techniques that can help improve these numbers will be provided.

== Predicting malignancy

The article discusses the task of identifying malignant nodules from benign ones in CT scans after implementing the nodule-detection task of the LUNA challenge. Even with a good system, diagnosing malignancy would need a more comprehensive view of the patient, additional non-CT context, and a biopsy instead of just looking at a particular nodule in isolation on a CT scan. This task is likely to be performed by a doctor for some time to come.

The key takeaways from the article are:

- Splitting training and validation (and test) sets between patients is important to avoid errors.
- Converting pixel-wise marks to nodules can be achieved using traditional image processing.
- The diagnosis script performs both segmentation and classification. Fine-tuning can be used to modify a pretrained model while using a minimum of training data. We need to retrain a portion of the network-matching features to our task.
- TensorBoard can help us visualise and identify network anomalies, but it is not a substitute for reviewing data that our model is not working well on.
- Successful training involves an overfitting network stage which is then regularised.
- There is no magic bullet when training neural networks.
- Kaggle is an excellent source of project ideas for deep learning experimentation. Many new datasets have cash prizes for the top performers.

