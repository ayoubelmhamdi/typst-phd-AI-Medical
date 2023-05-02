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


On choose to use the detection of malignant tumors in the lungs using only a CT scan of a patient's chest as input to illustrate how to overcome technical issues. Automatic detection of lung cancer is challenging, and even professional specialists face difficulty in identifying malignant tumors. Automating the process with deep learning will be more demanding and require a structured approach to succeeding.


Detecting lung cancer early is essential for increasing the patient's survival rate, but it's tough to do manually, especially on a large scale.

The problem space of lung tumor detection is important because it is an active research area with promising results. However, it is also unsolved, which satisfies the authors' objective of using PyTorch to tackle state-of-the-art projects.

=== Preparing for a Large-Scale Project
In large-scale project, it will be working with 3D data and require data manipulation, as no pre-built library is available for suitable training samples. The project will involve using convolutional layers followed by a resolution-reducing downsampling layer. To handle the computational requirements, you will need access to a GPU with at least `8 GB` of RAM or `220 GB` of free disk space for raw training data, cached data, and trained models.

Instead of analyzing the entire CT scan, it will break down the problem into simpler tasks. CT scans are 3D X-rays consisting of a three-dimensional array of single-channel data, with each voxel having a numeric value that approximately corresponds to the average mass density of the matter contained inside.


As for choosing the batch size, it depends on your specific situation. For example, with an image size of 2400x2400x3x4, a single image takes ~70 MB, so a batch size of 5 might be more realistic. However, this depends on the available GPU memory, and using 16-bit values instead of 32-bit can help double the batch size [Source 3](https://ai.stackexchange.com/questions/3938/how-do-i-handle-large-images-when-training-a-cnn).

== Approach
The goal of this project is to create an end-to-end solution for detecting cancerous nodules in lung CT scans using PyTorch. The approach involves five main steps:

1. Loading the CT data and converting it into a PyTorch dataset.
2. Segmenting the image to identify potential tumors.
3. Grouping interesting voxels to form candidates.
4. Classifying the nodules using a classification model.
5. Diagnosing the patient based on the malignancy of the identified nodules, combining segmentation and classification models for a final diagnosis.

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

CT data comes in two files: a *.mhd* file of metadata header information and a *.raw* file of raw bytes. The `CT` class loads these files, processes the information to produce a 3D array, and transforms the patient coordinate system to the index, row, and column coordinates of each voxel in the array. Annotation data from LUNA with nodule coordinates and malignancy flags are also loaded.


The `candidates.csv` file contains information about all lumps that look like nodules, whether they are malignant, benign, or something else. We'll use this to build a list of candidates that can be split into training and validation datasets. The annotations.csv file contains information about some of the candidates that have been flagged as nodules, including the diameter. This information is useful for ensuring a representative range of nodule sizes in the training and validation data.

=== Training and validation sets

For supervised learning tasks like classification, we need to split our data into training and validation sets. We want to ensure that both sets represent the real-world input data that we expect to see and handle normally. If either set is significantly different from our actual use cases, it's highly likely that our model will behave differently than we expect. This split helps us evaluate and improve the model's performance before we deploy it on production data.

=== Loading individual CT scans

We need to understand how to load and understand CT scan data, which is usually stored in a DICOM file format. The MetaIO format is suggested for easier use, and the Python SimpleITK library can be used to convert it to a NumPy array. The Hounsfield Unit (HU) scale is used to measure CT scan voxel density, with air at -1000 HU, water at 0 HU, and bone at least 1000 HU.

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

== Training

=== XXX 1
==== steps to training

\[...\]
The design of a convolutional neural network for detecting tumors are based on alternative image recognition that can be used as a starting point. A pre-existing network design will be modified for the project, with some adjustments made due to the input data being 3D.


Convolutional neural networks typically have a tail, backbone, and head. The tail processes the input, while the backbone contains most of the layers arranged in series of blocks. The head converts the output from the backbone to the desired output form.

Our implementation of a deep learning model is called `Luna`, used for computer-aided detection of lung nodules in medical images. The model uses convolutional neural networks and `softmax` layers to classify the images. The text also covers techniques for initializing the model parameters and the training process for the model.


==== Metrics


Two input tensors are used to log the results. applies tensor masking and Boolean indexing while constructing masks. The purpose is to limit the metrics to only the nodule or non-nodule samples and count the total samples per class, as well as the number of samples that are classified correctly.

The metric computes some per-label statistics and stores them in a dictionary, It determines the fraction of samples that are correctly classified, as well as the fraction that is correct from each label. Finally, the results are displayed as percentages.

==== Epoch Training

The first epoch is divided into 20193 steps called batches, each containing 256 data points. Once the data is loaded and the training process begins, monitoring the performance of the computing resources is crucial to ensure that resources are being used effectively.

displays training and validation metrics in a graphical format, making it easier to interpret the data. We can adjust the smoothing option to remove noise from trend lines if our data is noisy.


==== Conclusion (but)

The chapter has provided a model and a training loop.

==== XXX

Each dataset may contain several samples.

Data loaders can be used to modify data by adjusting the frequency of specific samples. This can be done to enhance or modify the dataset.


Recall is the ability to identify all relevant things, while precision is the ability to identify only relevant things.


The logging output are include the precision by including the count of correctly identified and the total number of samples for both negative and positive samples.


==== Revisiting the problem of overfitting

Overfitting occurs when a model learns specific properties of the training set, losing the ability to generalize, and making it less accurate in predicting samples that haven't been trained on. For instance.

To avoid overfitting, we must examine the right metrics. Looking at our overall loss, everything might seem fine, but that's because our validation set is unbalanced, and the negative samples dominate, making it hard for the model to memorize individual details.


To prevent overfitting, we use data augmentation, which involves modifying a dataset by applying synthetic alterations to individual samples, resulting in a new dataset with a larger number of effective samples. Five specific data augmentation techniques are discussed, including mirroring the image, shifting it by a few voxels, scaling it up or down, rotating it around the head-foot axis, and adding noise to the image.

This technique are designed to create new training samples from the existing ones by applying simple transformations. The transformations include shifting/mirroring, scaling, rotation, and adding noise.

=== Segmentation 1

The process of segmentation to identify possible nodules, which is step 2 of the project's plan. The segmentation model is created using a U-Net. The objective is to flag voxels that might be part of a nodule and use the classification step to reduce the number of incorrectly marked voxels.


==== Semantic segmentation: Per-pixel classification

Semantic segmentation identifies different objects and where they are in a given image. If there are multiple cats in an image, semantic segmentation can identify each cat's position. The existing classification models can't pinpoint where the cat is; they can only predict whether or not a cat is present in the image.

Semantic segmentation requires combining raw pixels to develop specific detectors for items like color and then building on this to create more informative feature detectors to finally identify specific things like a cat or a dog. Nonetheless, the segmentation model will not give us a single classification-like list of binary flags like classification models since the output should be a heatmap or mask.

The U-Net architecture is a design for a neural network that can produce pixelwise output and was invented for segmentation. The design of this architecture is complicated, as it is a lot different compared to the mostly sequential structure of the classifiers.

The U-Net architecture is good for image segmentation. The model has a U-shape, and it operates at different resolutions. It first goes from top left to bottom center through a series of convolutions and downscaling, then uses upscaling convolutions to get back to the full resolution. The key innovation behind U-Net is having the final detail layers operating with the best of both worlds.


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

