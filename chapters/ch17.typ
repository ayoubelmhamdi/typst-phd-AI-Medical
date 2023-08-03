#import "../functions.typ": heading_center, images, italic,linkb

#let finchapiter = text(size: 24pt, fill:rgb("#1E045B"),[■])

= DETECTING LUNG CANCER NODULES.

== Introduction

Lung cancer ranks among the top contributors to cancer-related mortality worldwide@national2011reduced. Early recognition and diagnosis of lung nodules, small tissue masses in the lungs, can significantly elevate survival rates and treatment success for individuals with lung cancer. However, detecting and classifying these lung nodules poses a worthy challenge due to their varying size, shape, location, and physical characteristics@SetioTBBBC0DFGG16. Furthermore, the majority of lung nodules are benign or non-cancerous, with only a scant percentage classified as malignant or cancerous@dou2017automated. These conditions create complications for automated lung nodule detection and classification through machine learning models.

In this study, we put into action a machine learning experiment utilizing a CNN model to determine benign or malignant lung nodules from CT scan images. We employed the publicly accessible LUNA16 dataset@SetioTBBBC0DFGG16 comprising 888 annotated nodule CT scans. A total of 10862 nodules were singled out from these scans where only 25 were malicious. The nodules were partitioned into a training set consisting of 8152 nodules and a validation set of 2709 nodules@armato2011lidc. We facilitated training of the CNN model using the training set and gauged its performance on the validation set@lin2017feature. Providing accuracy and recall as performance indicators.

=== CT Scans with Lung Nodules

To read, process, and visually represent CT scans depicting lung nodules@SetioTBBBC0DFGG16@dou2017automated@ding2017accurate, we implemented two Python libraries: SimpleITK and matplotlib. SimpleITK furnishes a simplified access point to the Insight Segmentation and Registration Toolkit (ITK), a framework built for image analysis and processing. Matplotlib, on the other hand, offers functionalities for image visualization and enhancement.

With SimpleITK, we read the CT scan files from the LUNA16 dataset@SetioTBBBC0DFGG16, converting these images from their DICOM or NIfTI format into manipulable multidimensional numerical arrays, referred to as numpy arrays. Additionally, SimpleITK was utilized to obtain the images' origin and spacing, defined as the image coordinates and the voxel size, respectively@SetioTBBBC0DFGG16. Afterward, we resampled the images using SimpleITK, achieving a uniform voxel size of 1 mm x 1 mm x 1 mm, normalized pixel values to a range of -1000 to 320 Hounsfield Units (HU), and applied a lung segmentation algorithm to isolate the lung regions from the images.

We utilized matplotlib for plotting and displaying the CT scan slices containing nodules, supplementing these images with white lines marking the boundaries around each nodule to emphasize their location and dimensions@SetioTBBBC0DFGG16@dou2017automated@ding2017accurate. A function was developed, accepting as its input a CT scan array, a numpy array consisting of nodule coordinates and diameters, the image's origin and spacing, and some optional parameters. This function iterates over the nodule array, computing the voxel coordinates for each nodule based on the image's physical coordinates, origin, and spacing. Afterward, it alters the CT scan array, incorporating the white lines around each nodule, and concludes with creating a plot to display the CT scan slices housing the nodules using matplotlib.

Figure 1 offers an example of a CT scan slice, where the nodule is highlighted with white lines.
![Figure 1: Examples of a CT scan slice with a nodule highlighted by white lines](images/seg4.png)

== Methodology

-== Resources

Our study's resources were CT scans and annotations sourced from the LUNA16 dataset@SetioTBBBC0DFGG16. LUNA16, a publicly accessible CT scan set from the Lung Image Database Consortium (LIDC) and Image Database Resource Initiative (IDRI), comprises 888 CT scans with a slice thickness lesser than 3 mm and a pixel spacing diminutive of 0.7 mm. This set also caters two separate CSV files embodying candidate and annotation details.

In the candidates.csv file, four columns are illustrated: seriesuid, coordX, coordY, coordZ, and class. Here, the seriesuid works as a unique identifier for each scan; coordX, coordY, and coordZ represent spatial coordinates for each candidate in millimeters, and 'class' provides a binary categorization, depicting whether the candidate is a nodule (1) or not (0). The annotations.csv file consists of five columns: seriesuid, coordX, coordY, coordZ, and diameter_mm, commanding the scanner's unique identifier, spatial annotation coordinates in millimeters, and each annotation's diameter in millimeters, respectively. Based on the identification of nodules larger than 3 mm in diameter by four independent radiologists, these annotations were manually marked@dou2017automated@ding2017accurate@armato2011lidc.

=== Procedural Outline

Our study encompassed three principal stages: Data preprocessing, nodule detection algorithm development, and performance evaluation@dou2017automated@ding2017accurate@armato2011lidc.

==== Data Preprocessing

In the data preprocessing phase, the CT scans were transformed from DICOM format to arrays(tensors). This was followed by resampling the images to attain uniform voxel dimensions of 1 mm x 1 mm x 1 mm, pixel value normalization to cater a -1000 to 320 Hounsfield Unit (HU) range, and finally the usage of a lung segmentation algorithm to extract lung regions from the images. This segmentation algorithm was designed on composite thresholding, morphological operations, and connected component analysis, delivering a set of lung masks for each scan@dou2017automated@ding2017accurate@armato2011lidc.

==== Development of Nodule Detection Algorithm

The nodule detection algorithm construction was divided into several imperative stages. At its foundation, the algorithm relied on a Convolutional Neural Network (CNN) model, tasked with identifying nodules from CT scan images@lin2017feature.

The designed model entailed:

- An _Input Layer_ to receive a 3D grayscale image.
- The first convolutional layer (Convolutional Layer 1) was encoded with 32 filters and a 3x3x3 kernel size. Padding was adjusted to 1 to preserve the image's spatial dimensions.
- The output from Convolutional Layer 1 was directed through a _ReLU Activation Function (Activation Layer 1)._
- The framework further encapsulated a second convolutional layer (Convolutional Layer 2) with 32 filters and a 3x3x3 kernel size, with a padding of 1.
- The output from Convolutional Layer 2 found itself in another ReLU activation function (Activation Layer 2).
- 3D max pooling was executed in Max Pooling Layer 1 with a kernel dimension of 2x2x2 and a stride of 2, reducing spatial dimensions by half.
- This structure was hence reiterated with Convolutional Layer 3 and 4, Activation Layer 3 and 4, and Max Pooling Layer 2, albeit the convolutional layers were outfitted with 64 filters.
- The output from the final max pooling layer was compressed into a 1D tensor in the Flatten Layer before directing it to the fully connected layer using PyTorch's 'view' method.
- The condensed tensor underwent a fully connected (dense) layer processing, called the _Fully Connected Layer_. This layer embodied two output neurons, corresponding to the presence or absence of nodules@lin2017focal.
- Lastly, a softmax function was applied to the output generated from the fully connected layer in the Softmax Layer. This step is mandatory for binary classification tasks, offering a probability distribution over the two classes@lin2017feature.

To train the model, the *Adam optimizer* was commissioned with a learning rate of 0.001, a batch size of 40, and the binary cross-entropy loss function. The model training spanned over 100 epochs@SetioTBBBC0DFGG16.


== Results
=== Assessment of Model Performance

We gauged the success of the model through its precision on both training and validation datasets. The model's accuracy on training data and validation data was documented at each stage of the learning process@SetioTBBBC0DFGG16.

The term *accuracy* refers to the ability of the model to forecast the results on the training data accurately, while *validation accuracy* signifies the model's capability to extend its predictions to new, unseen data, i.e., the validation data.

Upon examining the accuracy and validation accuracy values throughout the stages of learning, it's indicative that the model is acquiring knowledge, as can be seen through the gradual enhancement of both training and validation accuracies. The model begins with comparatively lower accuracies, around 0.64, before improving to above 0.89 by the end of training. This showcases the model's refined ability to accurately categorize a considerable ratio of cases.

Nonetheless, an accuracy of 89% was garnered on the validation set, implying that the model correctly predicted the class of 2654 of the 2709 nodules@SetioTBBBC0DFGG16.

=== Evaluation Metrics: Precision, Recall and F1-Score

The model performance was additionally evaluated using metrics such as *precision*, *recall*, and *F1-score* alongside accuracy. These measures provide a broader insight into the model's performance, especially in circumstances where an imbalance in classes is witnessed@lin2017focal.

- *Precision* represents the fraction of correct positive predictions (pecifically, when the model accurately identifies a nodule) out of all positive forecasts made by the model. A high precision indicates a model's low false positive rate. The model achieved a precision of 0.91 for class 0 and 0.86 for class 1.

- *Recall*, synonymous with sensitivity or true positive rate, is the ratio of accurate positive predictions to all actual positives. A high *recall* indicates that the model correctly identified a majority of the actual positive cases. The model achieved a recall of 0.91 for class 0 and 0.86 for class 1 @lin2017focal.

- *F1-score* is the harmonic mean of precision and recall, providing a single measure that balances between these metrics. The model scored an _F1-score_ of 0.91 for class 0 and 0.86 for class 1 @lin2017focal.

The results illustrate that the model performed proficiently in identifying both classes, with a slight preference in identifying class 0 (no nodule) over class 1 (presence of nodule). In general, the model performed impressively in terms of precision, recall, and _F1 score_@SetioTBBBC0DFGG16.

== Discussion

A significant barrier to optimizing performance is that our dataset presents an imbalance problem@dou2017automated. The dataset exhibits an excessive discrepancy between benign and malignant classes, with the benign class being more than 400 times prevalent than the malignant class. This disproportion obstructs the model's learning process in distinguishing between the classes, and it might default to predicting the most frequent class@lin2017focal. Furthermore, due to our dataset's high imbalance, accuracy doesn't serve as an appropriate performance measure as it can present a deceptively high figure, even when the model incorrectly predicts the minority class@lin2017focal.

Addressing this issue requires a refined strategy to train our model and an improved performance indicator better than accuracy. Potential solutions encompass:

- Implementing data augmentation techniques to amplify the number of malignant samples in our dataset@SetioTBBBC0DFGG16.
- Employing oversampling or undersampling techniques to achieve class balance in our dataset@lin2017focal.

In our subsequent work, we aim to incorporate some of these solutions and expect to enhance our model's performance relative to lung nodule classification@SetioTBBBC0DFGG16@dou2017automated@ding2017accurate.
